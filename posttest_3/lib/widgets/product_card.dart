import 'package:flutter/material.dart';

import 'product_detail_page.dart';
import '../state/cart_state.dart';
import '../models/cart_item.dart';

// ============================================================
// ProductCard = KARTU PRODUK (StatefulWidget, reusable)
//
// STATE LOKAL: _quantity (quantity yang akan ditambahkan)
// Kegunaan: menampilkan produk + tombol tambah ke keranjang
//           langsung dari card tanpa buka detail
// KONSEP: ListenableBuilder → stok & info keranjang reaktif
// ============================================================
class ProductCard extends StatefulWidget {
  final String nama;
  final String deskripsi;
  final String harga;
  final double rating;
  final int ulasan;
  final IconData icon;
  final String gambar;
  final bool isBestSeller;
  final int stokAwal;

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
  // STATE LOKAL: quantity yang akan ditambahkan
  // Kegunaan: mengontrol berapa banyak user mau tambah
  // Konsep  : setState → rebuild widget → angka terupdate
  int _quantity = 1;

  // Kegunaan: tambah quantity, dibatasi sisaStok (dari CartState)
  void _tambahQty(int sisaStok) {
    if (_quantity >= sisaStok) return;
    // setState: memicu rebuild widget lokal
    setState(() => _quantity++);
  }

  // Kegunaan: kurangi quantity, minimal 1
  void _kurangQty() {
    if (_quantity <= 1) return;
    setState(() => _quantity--);
  }

  // Kegunaan: tambah item ke keranjang
  // Konsep  : validasi stok → buat CartItem → addItem ke CartState → SnackBar
  void _tambahKeKeranjang() {
    final sisaStok =
        CartState.instance.sisaStok(widget.nama, widget.stokAwal);
    if (sisaStok <= 0) return;

    final jumlahAman = _quantity > sisaStok ? sisaStok : _quantity;

    CartState.instance.addItem(
      CartItem(
        nama: widget.nama,
        harga: CartState.parseHarga(widget.harga),
        gambar: widget.gambar,
        icon: widget.icon,
        jumlah: jumlahAman,
        stokAwal: widget.stokAwal,
      ),
    );

    // ScaffoldMessenger: menampilkan SnackBar (feedback visual)
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
        duration: const Duration(seconds: 1),
        backgroundColor: const Color(0xFF6B1F1F),
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );

    // Reset quantity ke 1 setelah tambah
    setState(() => _quantity = 1);
  }

  @override
  Widget build(BuildContext context) {
    // ListenableBuilder: rebuild saat CartState berubah
    // (misal stok berkurang setelah item ditambahkan)
    return ListenableBuilder(
      listenable: CartState.instance,
      builder: (context, _) {
        // Derived state
        final sisaStok =
            CartState.instance.sisaStok(widget.nama, widget.stokAwal);
        final habis = sisaStok <= 0;
        final diKeranjang = CartState.instance.jumlahDiKeranjang(widget.nama);

        // GestureDetector: tangkap tap seluruh card → ke detail produk
        return GestureDetector(
          onTap: () {
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
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6B1F1F).withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            // crossAxisAlignment.start: anak rata atas
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ---------- GAMBAR + OVERLAY HABIS ----------
                // Stack: menumpuk gambar + overlay
                Stack(
                  children: [
                    Container(
                      width: 92,
                      height: 92,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDF6F0),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      clipBehavior: Clip.antiAlias,
                      // Opacity: atur transparansi
                      child: Opacity(
                        opacity: habis ? 0.4 : 1.0,
                        child: Image.asset(
                          widget.gambar,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            widget.icon,
                            size: 40,
                            color: const Color(0xFF6B1F1F),
                          ),
                        ),
                      ),
                    ),
                    // Overlay "HABIS"
                    // Positioned.fill: isi seluruh Stack
                    if (habis)
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.35),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          // Center: posisikan anak di tengah
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
                const SizedBox(width: 12),

                // ---------- INFO PRODUK ----------
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.nama,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF2B0000),
                                letterSpacing: -0.2,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // Badge BEST SELLER (kondisional)
                          if (widget.isBestSeller)
                            _buildBadge(
                              text: 'BEST SELLER',
                              icon: Icons.local_fire_department_rounded,
                            ),
                        ],
                      ),
                      const SizedBox(height: 3),

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

                      // RATING + STOK
                      Row(
                        children: [
                          const Icon(Icons.star_rounded,
                              color: Color(0xFFD4A574), size: 13),
                          const SizedBox(width: 3),
                          Text(
                            widget.rating.toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2B0000),
                            ),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            '(${widget.ulasan})',
                            style: const TextStyle(
                                fontSize: 11, color: Color(0xFFB8A8A0)),
                          ),
                          const SizedBox(width: 8),

                          // Badge stok (warna berubah jika habis)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: habis
                                  ? const Color(0xFFB5474A)
                                      .withOpacity(0.12)
                                  : const Color(0xFF6B1F1F)
                                      .withOpacity(0.08),
                              borderRadius: BorderRadius.circular(6),
                            ),
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

                      // Info tambahan: berapa item di keranjang
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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.harga,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF6B1F1F),
                              letterSpacing: -0.3,
                            ),
                          ),
                          // Quantity picker hanya kalau stok ada
                          if (!habis) _buildQtyPicker(sisaStok),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // TOMBOL TAMBAH
                      SizedBox(
                        width: double.infinity,
                        child: GestureDetector(
                          // onTap null: tombol disabled kalau stok habis
                          onTap: habis ? null : _tambahKeKeranjang,
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(vertical: 9),
                            decoration: BoxDecoration(
                              // Warna abu kalau habis, gradien kalau ada stok
                              gradient: habis
                                  ? const LinearGradient(
                                      colors: [
                                        Color(0xFFB8A8A0),
                                        Color(0xFFB8A8A0),
                                      ],
                                    )
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
                                        color: const Color(0xFF6B1F1F)
                                            .withOpacity(0.25),
                                        blurRadius: 8,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  habis
                                      ? Icons.block_rounded
                                      : Icons.add_shopping_cart_rounded,
                                  color: Colors.white,
                                  size: 14,
                                ),
                                const SizedBox(width: 6),
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

  // Kegunaan: quantity picker — tombol − [angka] +
  Widget _buildQtyPicker(int sisaStok) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF6F0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        // MainAxisSize.min: Row hanya selebar konten
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: _kurangQty,
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6B1F1F).withOpacity(0.08),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.remove_rounded,
                  size: 13, color: Color(0xFF6B1F1F)),
            ),
          ),
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
          GestureDetector(
            onTap: () => _tambahQty(sisaStok),
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

  // Kegunaan: badge "BEST SELLER"
  Widget _buildBadge({required String text, required IconData icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFD4A574), Color(0xFFC08B5C)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 10),
          const SizedBox(width: 3),
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