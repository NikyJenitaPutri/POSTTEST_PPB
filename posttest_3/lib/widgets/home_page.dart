import 'package:flutter/material.dart';

import 'product_card.dart';
import 'menu_page.dart';
import 'product_detail_page.dart';

// ============================================================
// HomePage = HALAMAN UTAMA (StatelessWidget)
// Kegunaan: banner promo, kategori, rekomendasi, produk
// Tidak ada state lokal — data masih statis/hardcoded
// ============================================================
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold: kerangka halaman
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6F0),
      // SafeArea: hindari notch & status bar
      body: SafeArea(
        // SingleChildScrollView: seluruh halaman bisa discroll
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          // Column: susun anak vertikal
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER — Row: susun anak horizontal
              Row(
                children: [
                  // Logo dengan fallback gradient + icon
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6B1F1F).withOpacity(0.25),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    // Image.asset: gambar dari assets + errorBuilder
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 42,
                      height: 42,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF6B1F1F),
                                Color(0xFFB5474A)
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.local_cafe_rounded,
                              color: Colors.white, size: 22),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Expanded: kolom teks mengisi ruang sisa
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'KopiKita',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF2B0000),
                            letterSpacing: -0.5,
                          ),
                        ),
                        Text(
                          'Premium Coffee',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFFB8A8A0),
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Stack: menumpuk anak; Positioned: atur posisi absolut
                  Stack(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF6B1F1F)
                                  .withOpacity(0.08),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.notifications_none_rounded,
                            size: 22, color: Color(0xFF6B1F1F)),
                      ),
                      // Positioned: titik notifikasi di atas ikon
                      Positioned(
                        right: 9,
                        top: 9,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD4A574),
                            shape: BoxShape.circle,
                            // Border.all: garis tepi semua sisi
                            border:
                                Border.all(color: Colors.white, width: 1.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Text: menampilkan sapaan satu baris
              // maxLines+overflow: potong jadi "..." jika kepanjangan
              const Text(
                'Mau ngopi apa hari ini?',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2B0000),
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: 20),

              // BANNER PROMO — Container dengan gradient + Stack dekorasi
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF2B0000),
                      Color(0xFF6B1F1F),
                      Color(0xFFB5474A),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6B1F1F).withOpacity(0.4),
                      blurRadius: 24,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Dekorasi lingkaran buram di sudut kanan atas
                    Positioned(
                      right: -30,
                      top: -30,
                      child: Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.08),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Badge "SPECIAL OFFER"
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD4A574),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    '✨ SPECIAL OFFER',
                                    style: TextStyle(
                                      color: Color(0xFF2B0000),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 14),
                                // height: line-height teks
                                const Text(
                                  'Buy 1\nGet 1',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    height: 1.05,
                                    letterSpacing: -1,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Nikmati kopi favoritmu\ndengan harga spesial',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.85),
                                    fontSize: 12,
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                // Tombol "Klaim" (visual saja)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  // MainAxisSize.min: Row hanya selebar konten
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Klaim',
                                        style: TextStyle(
                                          color: Color(0xFF6B1F1F),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Icon(Icons.arrow_forward_rounded,
                                          size: 14,
                                          color: Color(0xFF6B1F1F)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Ikon besar di kanan banner
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.1),
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                  width: 2),
                            ),
                            child: const Icon(Icons.local_cafe_rounded,
                                size: 56, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // KATEGORI
              const Text(
                'Kategori',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2B0000),
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 14),
              Row(
                // spaceBetween: dorong ke ujung kiri & kanan
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildKategoriItem(
                    icon: Icons.coffee_rounded,
                    label: 'Coffee',
                    colors: const [Color(0xFF6B1F1F), Color(0xFFB5474A)],
                  ),
                  _buildKategoriItem(
                    icon: Icons.local_drink_rounded,
                    label: 'Non Coffee',
                    colors: const [Color(0xFFD4A574), Color(0xFFC08B5C)],
                  ),
                  _buildKategoriItem(
                    icon: Icons.bakery_dining_rounded,
                    label: 'Snack',
                    colors: const [Color(0xFF8B6F6F), Color(0xFF6B4F4F)],
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // REKOMENDASI
              // GestureDetector: mendeteksi tap pada seluruh banner
              // Navigator.push: navigasi ke halaman detail produk
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    // MaterialPageRoute: rute halaman Material
                    MaterialPageRoute(
                      builder: (context) => const ProductDetailPage(
                        nama: 'Caffe Latte',
                        deskripsi:
                            'Espresso dengan susu steamed yang lembut dan creamy, dipadukan dengan sentuhan manis yang pas',
                        harga: 'Rp20.000',
                        rating: 4.8,
                        ulasan: 180,
                        icon: Icons.coffee_maker,
                        gambar: 'assets/images/CoffeLatte.png',
                        isBestSeller: true,
                        stokAwal: 8,
                      ),
                    ),
                  );
                },
                child: _buildRekomendasiBanner(),
              ),
              const SizedBox(height: 28),

              // PRODUK
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Produk',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF2B0000),
                      letterSpacing: -0.3,
                    ),
                  ),
                  // Tombol "Lihat semua" → push ke MenuPage
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MenuPage()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6B1F1F).withOpacity(0.08),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Text(
                            'Lihat semua',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF6B1F1F),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 2),
                          Icon(Icons.arrow_forward_rounded,
                              size: 14, color: Color(0xFF6B1F1F)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Reuse ProductCard (widget reusable)
              const ProductCard(
                nama: 'Cappuccino',
                deskripsi: 'Espresso dengan busa susu lembut',
                harga: 'Rp18.000',
                rating: 4.9,
                ulasan: 245,
                icon: Icons.coffee,
                gambar: 'assets/images/Cappucino.png',
                isBestSeller: true,
                stokAwal: 15,
              ),
              const SizedBox(height: 12),
              const ProductCard(
                nama: 'Caffe Latte',
                deskripsi: 'Espresso dengan susu steamed',
                harga: 'Rp20.000',
                rating: 4.8,
                ulasan: 180,
                icon: Icons.coffee_maker,
                gambar: 'assets/images/CoffeLatte.png',
                isBestSeller: true,
                stokAwal: 8,
              ),
              const SizedBox(height: 12),
              const ProductCard(
                nama: 'Matcha Latte',
                deskripsi: 'Matcha premium dengan susu segar',
                harga: 'Rp20.000',
                rating: 4.8,
                ulasan: 150,
                icon: Icons.emoji_food_beverage,
                gambar: 'assets/images/MatchaLatte.png',
                isBestSeller: false,
                stokAwal: 12,
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget: satu item kategori (gradien + icon + label)
  Widget _buildKategoriItem({
    required IconData icon,
    required String label,
    required List<Color> colors,
  }) {
    return Column(
      children: [
        Container(
          width: 78,
          height: 78,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: colors[0].withOpacity(0.35),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          // Icon: menampilkan ikon kategori
          child: Icon(icon, size: 32, color: Colors.white),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF2B0000),
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  // Helper widget: banner rekomendasi
  Widget _buildRekomendasiBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        // Border.all: garis tepi semua sisi
        border: Border.all(
            color: const Color(0xFF6B1F1F).withOpacity(0.15), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B1F1F).withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6B1F1F), Color(0xFFB5474A)],
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.auto_awesome_rounded,
                color: Colors.white, size: 24),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Rekomendasi Untukmu',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF6B1F1F),
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_forward_rounded,
                        size: 13, color: Color(0xFF6B1F1F)),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  'Coba Caffe Latte!',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF2B0000),
                    letterSpacing: -0.3,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Manis, creamy, dan bikin nagih',
                  style: TextStyle(fontSize: 12, color: Color(0xFF8B6F6F)),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: Color(0xFF6B1F1F)),
        ],
      ),
    );
  }
}