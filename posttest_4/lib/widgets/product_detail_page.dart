import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../models/cart_item.dart';

// ProductDetailPage: StatefulWidget karena memiliki state lokal (_quantity)
// yang berubah saat user menambah/mengurangi jumlah
class ProductDetailPage extends StatefulWidget {
  final String nama;          // Nama produk
  final String deskripsi;     // Deskripsi produk
  final String harga;         // Harga dalam format string (mis. "Rp18.000")
  final double rating;        // Rating produk
  final int ulasan;           // Jumlah ulasan
  final IconData icon;        // Ikon fallback jika gambar gagal dimuat
  final String gambar;        // Path gambar produk
  final bool isBestSeller;    // Status best seller
  final int stokAwal;         // Stok awal produk (default 10)

  const ProductDetailPage({
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
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
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

  // Modul 5: context.read<CartProvider>()
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
              child: Text(
                  '${widget.nama} x$jumlahAman ditambahkan ke keranjang'),
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
    // Modul 5: Consumer<CartProvider> → halaman reaktif terhadap perubahan keranjang
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        // sisaStok: sisa stok setelah dikurangi item di keranjang
        final sisaStok = cart.sisaStok(widget.nama, widget.stokAwal);
        // habis: true jika stok sudah habis
        final habis = sisaStok <= 0;
        // diKeranjang: jumlah produk yang sudah ada di keranjang
        final diKeranjang = cart.jumlahDiKeranjang(widget.nama);

        // Scaffold: kerangka halaman
        return Scaffold(
          backgroundColor: const Color(0xFFFDF6F0), // Warna latar
          // Stack: menumpuk konten dan tombol back serta bottom bar
          body: Stack(
            children: [
              // SingleChildScrollView: konten dapat discroll
              SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 160), // Ruang untuk bottom bar
                // Column: menyusun konten secara vertikal
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri
                  children: [
                    // SizedBox: area gambar produk dengan tinggi 340
                    SizedBox(
                      width: double.infinity,
                      height: 340,
                      // Stack: menumpuk gambar, gradien, dan badge best seller
                      child: Stack(
                        children: [
                          // Positioned.fill: mengisi seluruh area Stack
                          Positioned.fill(
                            // Container: wadah gambar dengan sudut melengkung bawah
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFFDF6F0),
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(32)),
                              ),
                              clipBehavior: Clip.antiAlias, // Memotong gambar
                              // Opacity: meredupkan gambar jika stok habis
                              child: Opacity(
                                opacity: habis ? 0.5 : 1.0,
                                // Image.asset: menampilkan gambar produk
                                child: Image.asset(
                                  widget.gambar,
                                  fit: BoxFit.cover,
                                  // errorBuilder: fallback jika gambar gagal
                                  errorBuilder:
                                      (context, error, stackTrace) =>
                                          Icon(widget.icon,
                                              size: 100,
                                              color:
                                                  const Color(0xFF6B1F1F)),
                                ),
                              ),
                            ),
                          ),
                          // Positioned: gradien gelap di bagian bawah gambar
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            height: 120,
                            child: Container(
                              decoration: BoxDecoration(
                                // LinearGradient: transparan ke hitam transparan
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withValues(alpha: 0.15),
                                  ],
                                ),
                                borderRadius: const BorderRadius.vertical(
                                    bottom: Radius.circular(32)),
                              ),
                            ),
                          ),
                          // Badge BEST SELLER: hanya tampil jika isBestSeller true
                          if (widget.isBestSeller)
                            Positioned(
                              left: 20,
                              bottom: 20,
                              // Container: badge dengan gradien dan bayangan
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFD4A574),
                                      Color(0xFFC08B5C),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFFD4A574)
                                          .withValues(alpha: 0.5),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                // Row: ikon api + teks BEST SELLER
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                        Icons.local_fire_department_rounded,
                                        color: Colors.white,
                                        size: 14),
                                    SizedBox(width: 4),
                                    Text(
                                      'BEST SELLER',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0.6,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    // Padding: memberi jarak untuk konten teks di bawah gambar
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 24),
                      // Column: menyusun detail produk secara vertikal
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text: nama produk
                          Text(
                            widget.nama,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF2B0000),
                              letterSpacing: -0.8,
                              height: 1.1,
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Row: menampilkan rating, ulasan, dan stok
                          Row(
                            children: [
                              // Container: badge rating
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD4A574)
                                      .withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                // Row: ikon bintang + angka rating
                                child: Row(
                                  children: [
                                    const Icon(Icons.star_rounded,
                                        color: Color(0xFFD4A574), size: 14),
                                    const SizedBox(width: 3),
                                    Text(
                                      widget.rating.toStringAsFixed(1),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF2B0000),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Text: jumlah ulasan
                              Text(
                                '${widget.ulasan} ulasan',
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF8B6F6F)),
                              ),
                              const SizedBox(width: 10),
                              // Container: badge stok (habis atau tersedia)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: habis
                                      ? const Color(0xFFB5474A)
                                          .withValues(alpha: 0.12)
                                      : const Color(0xFF6B1F1F)
                                          .withValues(alpha: 0.08),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                // Text: status stok
                                child: Text(
                                  habis
                                      ? 'Stok Habis'
                                      : 'Stok: $sisaStok',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
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
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.shopping_bag_rounded,
                                    size: 12, color: Color(0xFF6B1F1F)),
                                const SizedBox(width: 4),
                                Text(
                                  '$diKeranjang sudah di keranjang',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF6B1F1F),
                                  ),
                                ),
                              ],
                            ),
                          ],
                          const SizedBox(height: 20),
                          // Row: menampilkan harga dan satuan
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // Text: harga produk
                              Text(
                                widget.harga,
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF6B1F1F),
                                  letterSpacing: -0.8,
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Text: satuan "/ cup"
                              const Padding(
                                padding: EdgeInsets.only(bottom: 6),
                                child: Text(
                                  '/ cup',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFFB8A8A0)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          // Container: kartu deskripsi produk
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF6B1F1F)
                                      .withValues(alpha: 0.06),
                                  blurRadius: 16,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            // Column: judul "Deskripsi" dan isi deskripsi
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    // Container: garis aksen kecil
                                    Container(
                                      width: 4,
                                      height: 18,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF6B1F1F),
                                            Color(0xFFD4A574)
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(2),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    // Text: judul "Deskripsi"
                                    const Text(
                                      'Deskripsi',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF2B0000),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                // Text: isi deskripsi produk
                                Text(
                                  widget.deskripsi,
                                  style: const TextStyle(
                                    fontSize: 13.5,
                                    height: 1.6,
                                    color: Color(0xFF8B6F6F),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Back button: tombol kembali ke halaman sebelumnya
              SafeArea(
                minimum: const EdgeInsets.only(top: 12, left: 16),
                // GestureDetector: mendeteksi tap pada tombol back
                child: GestureDetector(
                  onTap: () => Navigator.pop(context), // Kembali
                  // Container: tombol bulat putih dengan bayangan
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6B1F1F)
                              .withValues(alpha: 0.15),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    // Icon: ikon panah kembali
                    child: const Icon(Icons.arrow_back_rounded,
                        color: Color(0xFF6B1F1F), size: 22),
                  ),
                ),
              ),

              // Bottom bar: panel bawah untuk quantity dan tombol tambah
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                // Container: latar putih dengan sudut melengkung dan bayangan
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6B1F1F)
                            .withValues(alpha: 0.15),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  // Column: total harga dan kontrol quantity + tombol tambah
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Row: label "Total" dan nilai total harga
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                                fontSize: 11, color: Color(0xFFB8A8A0)),
                          ),
                          // Text: total harga = harga * quantity
                          Text(
                            CartProvider.formatRupiah(
                              CartProvider.parseHarga(widget.harga) *
                                  _quantity,
                            ),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF6B1F1F),
                              letterSpacing: -0.3,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Row: kontrol quantity dan tombol tambah ke keranjang
                      Row(
                        children: [
                          // Container: pembungkus kontrol quantity
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFDF6F0),
                              borderRadius: BorderRadius.circular(14),
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
                                    width: 34,
                                    height: 34,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF6B1F1F)
                                              .withValues(alpha: 0.08),
                                          blurRadius: 6,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: const Icon(Icons.remove_rounded,
                                        size: 18,
                                        color: Color(0xFF6B1F1F)),
                                  ),
                                ),
                                // SizedBox: menampilkan angka quantity
                                SizedBox(
                                  width: 40,
                                  child: Text(
                                    '$_quantity',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFF2B0000),
                                    ),
                                  ),
                                ),
                                // GestureDetector: tombol tambah quantity
                                GestureDetector(
                                  onTap: () => _tambahQty(sisaStok),
                                  // Container: tombol dengan gradien dan ikon plus
                                  child: Container(
                                    width: 34,
                                    height: 34,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF6B1F1F),
                                          Color(0xFFB5474A)
                                        ],
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF6B1F1F)
                                              .withValues(alpha: 0.3),
                                          blurRadius: 8,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: const Icon(Icons.add_rounded,
                                        size: 18, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Expanded: tombol "Tambah" mengisi sisa ruang
                          Expanded(
                            // GestureDetector: tombol tambah ke keranjang
                            // onTap null jika stok habis
                            child: GestureDetector(
                              onTap: habis ? null : _tambahKeKeranjang,
                              // Container: tombol dengan gradien
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14),
                                decoration: BoxDecoration(
                                  gradient: habis
                                      ? const LinearGradient(colors: [
                                          Color(0xFFB8A8A0),
                                          Color(0xFFB8A8A0),
                                        ])
                                      : const LinearGradient(
                                          colors: [
                                            Color(0xFF6B1F1F),
                                            Color(0xFFB5474A)
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: habis
                                      ? null
                                      : [
                                          BoxShadow(
                                            color: const Color(0xFF6B1F1F)
                                                .withValues(alpha: 0.35),
                                            blurRadius: 12,
                                            offset: const Offset(0, 4),
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
                                      size: 18,
                                    ),
                                    const SizedBox(width: 8),
                                    // Text: label tombol
                                    Text(
                                      habis ? 'Stok Habis' : 'Tambah',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}