import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'product_detail_page.dart';
import '../providers/cart_provider.dart';
import '../models/cart_item.dart';

// ProductCard: StatefulWidget karena memiliki state lokal (_quantity)
// yang berubah saat user menambah/mengurangi jumlah
class ProductCard extends StatefulWidget {
  final String nama;          // Nama produk
  final String deskripsi;     // Deskripsi produk
  final String harga;         // Harga dalam format string (mis. "Rp18.000")
  final double rating;        // Rating produk
  final int ulasan;           // Jumlah ulasan
  final IconData icon;        // Ikon fallback jika gambar gagal dimuat
  final String gambar;        // Path gambar produk
  final bool isBestSeller;    // Status best seller
  final int stokAwal;         // Stok awal produk (default 10)

  const ProductCard({
    super.key,
    required this.nama,
    required this.deskripsi,
    required this.harga,
    required this.rating,
    required this.ulasan,
    required this.icon,
    required this.gambar,
    required this.isBestSeller,
    this.stokAwal = 10,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  // State: _quantity menyimpan jumlah produk yang akan dibeli
  int _quantity = 1;

  // Method: menambah quantity jika belum melebihi sisa stok
  void _tambahQty(int sisaStok) {
    if (_quantity >= sisaStok) return; // Batas maksimal sisa stok
    setState(() => _quantity++); // setState: memberitahu framework untuk rebuild UI
  }

  // Method: mengurangi quantity, minimal 1
  void _kurangQty() {
    if (_quantity <= 1) return;
    setState(() => _quantity--);
  }

  // Modul 5: context.read<CartProvider>() — akses provider tanpa listen
  // Method: menambahkan produk ke keranjang
  void _tambahKeKeranjang() {
    // context.read: mengambil instance CartProvider tanpa mendengarkan perubahan
    final cart = context.read<CartProvider>();
    // sisaStok: menghitung sisa stok berdasarkan keranjang saat ini
    final sisaStok = cart.sisaStok(widget.nama, widget.stokAwal);
    if (sisaStok <= 0) return; // Jika stok habis, batalkan

    // Pastikan jumlah yang ditambahkan tidak melebihi sisa stok
    final jumlahAman = _quantity > sisaStok ? sisaStok : _quantity;

    // Menambahkan item ke keranjang
    cart.addItem(
      CartItem(
        nama: widget.nama,
        harga: CartProvider.parseHarga(widget.harga),
        gambar: widget.gambar,
        icon: widget.icon,
        jumlah: jumlahAman,
        stokAwal: widget.stokAwal,
      ),
    );

    // ScaffoldMessenger: menampilkan SnackBar sebagai notifikasi
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded,
                color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text('${widget.nama} x$jumlahAman ditambahkan'),
            ),
          ],
        ),
        duration: const Duration(seconds: 1), // Durasi tampil 1 detik
        backgroundColor: const Color(0xFF6B1F1F), // Warna latar SnackBar
        behavior: SnackBarBehavior.floating, // SnackBar mengambang
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)), // Sudut melengkung
        margin: const EdgeInsets.all(16), // Jarak dari tepi
      ),
    );

    // Reset quantity ke 1 setelah ditambahkan
    setState(() => _quantity = 1);
  }

  @override
  Widget build(BuildContext context) {
    // Modul 5: Consumer<CartProvider> → hanya area ini yang rebuild
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        // sisaStok: sisa stok setelah dikurangi item di keranjang
        final sisaStok = cart.sisaStok(widget.nama, widget.stokAwal);
        // habis: true jika stok sudah habis
        final habis = sisaStok <= 0;
        // diKeranjang: jumlah produk yang sudah ada di keranjang
        final diKeranjang = cart.jumlahDiKeranjang(widget.nama);

        // GestureDetector: mendeteksi tap pada seluruh kartu
        return GestureDetector(
          onTap: () {
            // Navigator.push: navigasi ke halaman detail produk
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(
                  nama: widget.nama,
                  deskripsi: widget.deskripsi,
                  harga: widget.harga,
                  rating: widget.rating,
                  ulasan: widget.ulasan,
                  icon: widget.icon,
                  gambar: widget.gambar,
                  isBestSeller: widget.isBestSeller,
                  stokAwal: widget.stokAwal,
                ),
              ),
            );
          },
          // Container: kartu produk dengan latar putih dan sudut melengkung
          child: Container(
            width: double.infinity, // Lebar penuh
            padding: const EdgeInsets.all(12), // Padding dalam 12
            decoration: BoxDecoration(
              color: Colors.white, // Warna latar kartu
              borderRadius: BorderRadius.circular(20), // Sudut melengkung 20
              boxShadow: [
                // BoxShadow: efek bayangan pada kartu
                BoxShadow(
                  color: const Color(0xFF6B1F1F).withValues(alpha: 0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            // Row: menyusun gambar dan info produk secara horizontal
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start, // Anak rata atas
              children: [
                // Stack: menumpuk gambar produk dan overlay "HABIS"
                Stack(
                  children: [
                    // Container: wadah gambar produk
                    Container(
                      width: 92,
                      height: 92,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDF6F0), // Warna latar gambar
                        borderRadius: BorderRadius.circular(16), // Sudut melengkung
                      ),
                      clipBehavior: Clip.antiAlias, // Memotong gambar
                      // Opacity: meredupkan gambar jika stok habis
                      child: Opacity(
                        opacity: habis ? 0.4 : 1.0,
                        // Image.asset: menampilkan gambar produk
                        child: Image.asset(
                          widget.gambar,
                          fit: BoxFit.cover, // Gambar menutupi area
                          // errorBuilder: fallback jika gambar gagal
                          errorBuilder: (context, error, stackTrace) => Icon(
                            widget.icon,
                            size: 40,
                            color: const Color(0xFF6B1F1F),
                          ),
                        ),
                      ),
                    ),
                    // Jika stok habis, tampilkan overlay "HABIS"
                    if (habis)
                      // Positioned.fill: mengisi seluruh area Stack
                      Positioned.fill(
                        // Container: overlay gelap dengan teks HABIS
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.35),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          // Center: menempatkan teks di tengah
                          child: const Center(
                            child: Text(
                              'HABIS',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 12), // Jarak horizontal 12
                // Expanded: info produk mengisi ruang sisa
                Expanded(
                  // Column: menyusun info produk secara vertikal
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row: nama produk dan badge best seller
                      Row(
                        children: [
                          // Expanded: nama produk mengisi ruang sisa
                          Expanded(
                            // Text: nama produk
                            child: Text(
                              widget.nama,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF2B0000),
                                letterSpacing: -0.2,
                              ),
                              maxLines: 1, // Maksimal 1 baris
                              overflow: TextOverflow.ellipsis, // Potong dengan elipsis
                            ),
                          ),
                          // Badge BEST SELLER: hanya tampil jika isBestSeller true
                          if (widget.isBestSeller)
                            _buildBadge(
                              text: 'BEST SELLER',
                              icon: Icons.local_fire_department_rounded,
                            ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      // Text: deskripsi produk
                      Text(
                        widget.deskripsi,
                        style: const TextStyle(
                          fontSize: 11.5,
                          color: Color(0xFF8B6F6F),
                          height: 1.3,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      // Row: rating, ulasan, dan stok
                      Row(
                        children: [
                          // Icon: ikon bintang
                          const Icon(Icons.star_rounded,
                              color: Color(0xFFD4A574), size: 13),
                          const SizedBox(width: 3),
                          // Text: angka rating
                          Text(
                            widget.rating.toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2B0000),
                            ),
                          ),
                          const SizedBox(width: 3),
                          // Text: jumlah ulasan
                          Text(
                            '(${widget.ulasan})',
                            style: const TextStyle(
                                fontSize: 11, color: Color(0xFFB8A8A0)),
                          ),
                          const SizedBox(width: 8),
                          // Container: badge stok
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: habis
                                  ? const Color(0xFFB5474A).withValues(alpha: 0.12)
                                  : const Color(0xFF6B1F1F).withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            // Text: status stok
                            child: Text(
                              habis ? 'Stok habis' : 'Stok: $sisaStok',
                              style: TextStyle(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w700,
                                color: habis
                                    ? const Color(0xFFB5474A)
                                    : const Color(0xFF6B1F1F),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Jika sudah ada di keranjang, tampilkan info
                      if (diKeranjang > 0) ...[
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.shopping_bag_rounded,
                                size: 11, color: Color(0xFF6B1F1F)),
                            const SizedBox(width: 3),
                            Text(
                              '$diKeranjang di keranjang',
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF6B1F1F),
                              ),
                            ),
                          ],
                        ),
                      ],
                      const SizedBox(height: 10),
                      // Row: harga dan quantity picker
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Text: harga produk
                          Text(
                            widget.harga,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF6B1F1F),
                              letterSpacing: -0.3,
                            ),
                          ),
                          // Quantity picker: hanya tampil jika stok tidak habis
                          if (!habis) _buildQtyPicker(sisaStok),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // SizedBox: tombol tambah ke keranjang lebar penuh
                      SizedBox(
                        width: double.infinity,
                        // GestureDetector: tombol tambah ke keranjang
                        child: GestureDetector(
                          onTap: habis ? null : _tambahKeKeranjang, // null jika habis
                          // Container: tombol dengan gradien
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(vertical: 9),
                            decoration: BoxDecoration(
                              gradient: habis
                                  ? const LinearGradient(colors: [
                                      Color(0xFFB8A8A0),
                                      Color(0xFFB8A8A0),
                                    ])
                                  : const LinearGradient(
                                      colors: [
                                        Color(0xFF6B1F1F),
                                        Color(0xFFB5474A),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: habis
                                  ? null
                                  : [
                                      BoxShadow(
                                        color: const Color(0xFF6B1F1F).withValues(alpha: 0.25),
                                        blurRadius: 8,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                            ),
                            // Row: ikon dan teks tombol
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Icon: ikon berubah sesuai status stok
                                Icon(
                                  habis
                                      ? Icons.block_rounded
                                      : Icons.add_shopping_cart_rounded,
                                  color: Colors.white,
                                  size: 14,
                                ),
                                const SizedBox(width: 6),
                                // Text: label tombol
                                Text(
                                  habis ? 'Stok Habis' : 'Tambah',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Helper: quantity picker (tombol kurang, angka, tombol tambah)
  Widget _buildQtyPicker(int sisaStok) {
    // Container: pembungkus quantity picker
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF6F0), // Warna latar
        borderRadius: BorderRadius.circular(20), // Sudut melengkung
      ),
      // Row: tombol kurang, angka, tombol tambah
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // GestureDetector: tombol kurang quantity
          GestureDetector(
            onTap: _kurangQty,
            // Container: tombol bulat putih dengan ikon minus
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle, // Bentuk lingkaran
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6B1F1F).withValues(alpha: 0.08),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.remove_rounded,
                  size: 13, color: Color(0xFF6B1F1F)),
            ),
          ),
          // SizedBox: menampilkan angka quantity
          SizedBox(
            width: 26,
            child: Text(
              '$_quantity',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: Color(0xFF2B0000),
              ),
            ),
          ),
          // GestureDetector: tombol tambah quantity
          GestureDetector(
            onTap: () => _tambahQty(sisaStok),
            // Container: tombol bulat dengan gradien dan ikon plus
            child: Container(
              width: 22,
              height: 22,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF6B1F1F), Color(0xFFB5474A)],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add_rounded,
                  size: 13, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // Helper: badge kecil dengan ikon dan teks
  Widget _buildBadge({required String text, required IconData icon}) {
    // Container: badge dengan gradien
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFD4A574), Color(0xFFC08B5C)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      // Row: ikon dan teks badge
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon: ikon badge
          Icon(icon, color: Colors.white, size: 10),
          const SizedBox(width: 3),
          // Text: teks badge
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}