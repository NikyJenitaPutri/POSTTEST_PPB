import 'package:flutter/material.dart';

import '../state/cart_state.dart';
import '../models/cart_item.dart';

// ============================================================
// ProductDetailPage = HALAMAN DETAIL PRODUK (StatefulWidget)
//
// STATE LOKAL: _quantity (quantity yang akan ditambahkan)
// KONSEP: ListenableBuilder → sisaStok & info keranjang reaktif
// KEGUNAAN: gambar besar, info lengkap, quantity picker, tombol tambah
// ============================================================
class ProductDetailPage extends StatefulWidget {
  final String nama;
  final String deskripsi;
  final String harga;
  final double rating;
  final int ulasan;
  final IconData icon;
  final String gambar;
  final bool isBestSeller;
  final int stokAwal;

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
  // STATE LOKAL: quantity yang akan ditambahkan
  int _quantity = 1;

  // Kegunaan: tambah quantity, dibatasi sisaStok
  void _tambahQty(int sisaStok) {
    if (_quantity >= sisaStok) return;
    // setState: memicu rebuild
    setState(() => _quantity++);
  }

  // Kegunaan: kurangi quantity, minimal 1
  void _kurangQty() {
    if (_quantity <= 1) return;
    setState(() => _quantity--);
  }

  // Kegunaan: tambah ke keranjang + reset + SnackBar
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
        duration: const Duration(seconds: 1),
        backgroundColor: const Color(0xFF6B1F1F),
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );

    setState(() => _quantity = 1);
  }

  @override
  Widget build(BuildContext context) {
    // ListenableBuilder: rebuild otomatis saat CartState berubah
    return ListenableBuilder(
      listenable: CartState.instance,
      builder: (context, _) {
        final sisaStok =
            CartState.instance.sisaStok(widget.nama, widget.stokAwal);
        final habis = sisaStok <= 0;
        final diKeranjang =
            CartState.instance.jumlahDiKeranjang(widget.nama);

        // Scaffold: kerangka halaman
        return Scaffold(
          backgroundColor: const Color(0xFFFDF6F0),
          // Stack: 3 lapisan — konten scroll, tombol back, bottom bar
          body: Stack(
            children: [
              // Konten utama (scrollable)
              SingleChildScrollView(
                // padding bottom: hindari tertutup bottom bar
                padding: const EdgeInsets.only(bottom: 160),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Gambar besar di atas
                    SizedBox(
                      width: double.infinity,
                      height: 340,
                      child: Stack(
                        children: [
                          // Positioned.fill: gambar mengisi seluruh area
                          Positioned.fill(
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFFDF6F0),
                                // BorderRadius.vertical: radius per sisi
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(32)),
                              ),
                              clipBehavior: Clip.antiAlias,
                              // Opacity: atur transparansi gambar
                              child: Opacity(
                                opacity: habis ? 0.5 : 1.0,
                                child: Image.asset(
                                  widget.gambar,
                                  fit: BoxFit.cover,
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
                          // Gradien gelap di bawah gambar (agar badge kontras)
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            height: 120,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.15),
                                  ],
                                ),
                                borderRadius: const BorderRadius.vertical(
                                    bottom: Radius.circular(32)),
                              ),
                            ),
                          ),
                          // Badge "BEST SELLER" di bawah kiri
                          if (widget.isBestSeller)
                            Positioned(
                              left: 20,
                              bottom: 20,
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
                                          .withOpacity(0.5),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                // MainAxisSize.min: Row selebar konten
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

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Nama produk
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

                          // Rating, ulasan, stok
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD4A574)
                                      .withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
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
                              Text(
                                '${widget.ulasan} ulasan',
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF8B6F6F)),
                              ),
                              const SizedBox(width: 10),
                              // Badge stok (warna berubah jika habis)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: habis
                                      ? const Color(0xFFB5474A)
                                          .withOpacity(0.12)
                                      : const Color(0xFF6B1F1F)
                                          .withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(8),
                                ),
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

                          // Info item yang sudah di keranjang (kondisional)
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

                          // Harga besar
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
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

                          // Kartu deskripsi
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF6B1F1F)
                                      .withOpacity(0.06),
                                  blurRadius: 16,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    // Aksen garis gradien
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

              // Tombol back mengambang di atas gambar
              // SafeArea dengan minimum: jarak dari tepi layar
              SafeArea(
                minimum: const EdgeInsets.only(top: 12, left: 16),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color:
                              const Color(0xFF6B1F1F).withOpacity(0.15),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.arrow_back_rounded,
                        color: Color(0xFF6B1F1F), size: 22),
                  ),
                ),
              ),

              // Bottom bar: quantity picker + tombol tambah
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6B1F1F).withOpacity(0.15),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    // MainAxisSize.min: tinggi sesuai konten
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Total harga dinamis berdasarkan _quantity
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                                fontSize: 11, color: Color(0xFFB8A8A0)),
                          ),
                          Text(
                            CartState.formatRupiah(
                              CartState.parseHarga(widget.harga) * _quantity,
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
                      Row(
                        children: [
                          // Quantity picker
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFDF6F0),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Tombol minus
                                GestureDetector(
                                  onTap: _kurangQty,
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
                                              .withOpacity(0.08),
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
                                // Angka quantity
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
                                // Tombol plus
                                GestureDetector(
                                  onTap: () => _tambahQty(sisaStok),
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
                                              .withOpacity(0.3),
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

                          // Tombol tambah ke keranjang
                          Expanded(
                            child: GestureDetector(
                              // Nonaktif jika stok habis
                              onTap: habis ? null : _tambahKeKeranjang,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14),
                                decoration: BoxDecoration(
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
                                                .withOpacity(0.35),
                                            blurRadius: 12,
                                            offset: const Offset(0, 4),
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
                                      size: 18,
                                    ),
                                    const SizedBox(width: 8),
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