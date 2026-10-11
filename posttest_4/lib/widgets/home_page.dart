import 'package:flutter/material.dart';

import 'product_card.dart';
import 'menu_page.dart';
import 'product_detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold: kerangka halaman (background, body, dll)
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6F0), // Warna latar halaman
      // SafeArea: menghindari notch & status bar agar konten tidak terpotong
      body: SafeArea(
        // SingleChildScrollView: seluruh halaman bisa discroll
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16), // Padding halaman
          // Column: menyusun anak secara vertikal
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Anak rata kiri
            children: [
              // HEADER
              // Row: menyusun anak secara horizontal
              Row(
                children: [
                  // Container: wadah logo dengan dekorasi
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12), // Sudut melengkung
                      boxShadow: [
                        // BoxShadow: efek bayangan pada container
                        BoxShadow(
                          color: const Color(0xFF6B1F1F).withValues(alpha: 0.25),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias, // Memotong gambar agar sesuai sudut
                    // Image.asset: menampilkan gambar dari assets
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 42,
                      height: 42,
                      fit: BoxFit.cover, // Gambar menutupi area
                      // errorBuilder: fallback jika gambar gagal dimuat
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            // LinearGradient: gradien latar fallback
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF6B1F1F),
                                Color(0xFFB5474A)
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          // Icon: ikon pengganti logo
                          child: const Icon(Icons.local_cafe_rounded,
                              color: Colors.white, size: 22),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12), // Jarak horizontal 12
                  // Expanded: kolom teks mengisi ruang sisa
                  const Expanded(
                    // Column: menyusun judul dan subjudul secara vertikal
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text: judul aplikasi "KopiKita"
                        Text(
                          'KopiKita',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF2B0000),
                            letterSpacing: -0.5,
                          ),
                        ),
                        // Text: subjudul "Premium Coffee"
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
                  // Stack: menumpuk ikon notifikasi dan titik notifikasi
                  Stack(
                    children: [
                      // Container: tombol notifikasi
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF6B1F1F).withValues(alpha: 0.08),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        // Icon: ikon notifikasi
                        child: const Icon(Icons.notifications_none_rounded,
                            size: 22, color: Color(0xFF6B1F1F)),
                      ),
                      // Positioned: mengatur posisi titik notifikasi
                      Positioned(
                        right: 9,
                        top: 9,
                        // Container: titik notifikasi
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD4A574),
                            shape: BoxShape.circle, // Bentuk lingkaran
                            // Border.all: garis tepi putih
                            border:
                                Border.all(color: Colors.white, width: 1.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20), // Jarak vertikal 20

              // Text: sapaan satu baris
              // maxLines + overflow: potong jadi "..." jika kepanjangan
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

              // BANNER PROMO
              // Container: banner promo dengan gradien dan dekorasi
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  // LinearGradient: gradien latar banner
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF2B0000),
                      Color(0xFF6B1F1F),
                      Color(0xFFB5474A),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24), // Sudut melengkung
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6B1F1F).withValues(alpha: 0.4),
                      blurRadius: 24,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                // Stack: menumpuk dekorasi lingkaran dan konten banner
                child: Stack(
                  children: [
                    // Positioned: dekorasi lingkaran buram di sudut kanan atas
                    Positioned(
                      right: -30,
                      top: -30,
                      child: Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle, // Bentuk lingkaran
                          color: Colors.white.withValues(alpha: 0.08), // Putih transparan
                        ),
                      ),
                    ),
                    // Padding: memberi jarak untuk konten banner
                    Padding(
                      padding: const EdgeInsets.all(24),
                      // Row: menyusun teks banner dan ikon secara horizontal
                      child: Row(
                        children: [
                          // Expanded: kolom teks mengisi ruang sisa
                          Expanded(
                            // Column: menyusun konten banner secara vertikal
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Container: badge "SPECIAL OFFER"
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD4A574),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  // Text: teks badge
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
                                // Text: judul promo "Buy 1 Get 1"
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
                                // Text: deskripsi promo
                                Text(
                                  'Nikmati kopi favoritmu\ndengan harga spesial',
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.85),
                                    fontSize: 12,
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                // Container: tombol "Klaim" (visual saja)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  // Row: ikon dan teks tombol
                                  // MainAxisSize.min: Row hanya selebar konten
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Text: teks "Klaim"
                                      Text(
                                        'Klaim',
                                        style: TextStyle(
                                          color: Color(0xFF6B1F1F),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      // Icon: ikon panah
                                      Icon(Icons.arrow_forward_rounded,
                                          size: 14,
                                          color: Color(0xFF6B1F1F)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Container: ikon besar di kanan banner
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(alpha: 0.1),
                              // Border.all: garis tepi lingkaran
                              border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  width: 2),
                            ),
                            // Icon: ikon cangkir kopi
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
              // Text: judul section "Kategori"
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
              // Row: menyusun item kategori secara horizontal
              Row(
                // spaceBetween: dorong ke ujung kiri & kanan
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Memanggil helper _buildKategoriItem untuk Coffee
                  _buildKategoriItem(
                    icon: Icons.coffee_rounded,
                    label: 'Coffee',
                    colors: const [Color(0xFF6B1F1F), Color(0xFFB5474A)],
                  ),
                  // Memanggil helper _buildKategoriItem untuk Non Coffee
                  _buildKategoriItem(
                    icon: Icons.local_drink_rounded,
                    label: 'Non Coffee',
                    colors: const [Color(0xFFD4A574), Color(0xFFC08B5C)],
                  ),
                  // Memanggil helper _buildKategoriItem untuk Snack
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
              GestureDetector(
                onTap: () {
                  // Navigator.push: navigasi ke halaman detail produk
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
                // Memanggil helper _buildRekomendasiBanner
                child: _buildRekomendasiBanner(),
              ),
              const SizedBox(height: 28),

              // PRODUK
              // Row: judul "Produk" dan tombol "Lihat semua"
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text: judul section "Produk"
                  const Text(
                    'Produk',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF2B0000),
                      letterSpacing: -0.3,
                    ),
                  ),
                  // GestureDetector: tombol "Lihat semua"
                  GestureDetector(
                    onTap: () {
                      // Navigator.push: navigasi ke halaman MenuPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MenuPage()),
                      );
                    },
                    // Container: tombol dengan latar tipis
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6B1F1F).withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      // Row: teks dan ikon tombol
                      child: const Row(
                        children: [
                          // Text: teks "Lihat semua"
                          Text(
                            'Lihat semua',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF6B1F1F),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 2),
                          // Icon: ikon panah
                          Icon(Icons.arrow_forward_rounded,
                              size: 14, color: Color(0xFF6B1F1F)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // ProductCard: widget reusable untuk menampilkan produk Cappuccino
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
              // ProductCard: widget reusable untuk menampilkan produk Caffe Latte
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
              // ProductCard: widget reusable untuk menampilkan produk Matcha Latte
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

              const SizedBox(height: 30), // Jarak vertikal akhir
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
    // Column: menyusun kotak kategori dan label secara vertikal
    return Column(
      children: [
        // Container: kotak kategori dengan gradien
        Container(
          width: 78,
          height: 78,
          decoration: BoxDecoration(
            // LinearGradient: gradien latar kategori
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(22), // Sudut melengkung
            boxShadow: [
              BoxShadow(
                color: colors[0].withValues(alpha: 0.35),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          // Icon: menampilkan ikon kategori
          child: Icon(icon, size: 32, color: Colors.white),
        ),
        const SizedBox(height: 10),
        // Text: label kategori
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
    // Container: banner dengan latar putih dan border
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        // Border.all: garis tepi tipis
        border: Border.all(
            color: const Color(0xFF6B1F1F).withValues(alpha: 0.15), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B1F1F).withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      // Row: menyusun ikon, teks, dan chevron secara horizontal
      child: Row(
        children: [
          // Container: ikon gradien untuk rekomendasi
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6B1F1F), Color(0xFFB5474A)],
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            // Icon: ikon auto awesome
            child: const Icon(Icons.auto_awesome_rounded,
                color: Colors.white, size: 24),
          ),
          const SizedBox(width: 14),
          // Expanded: kolom teks rekomendasi mengisi ruang sisa
          const Expanded(
            // Column: menyusun teks rekomendasi secara vertikal
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row: teks dan ikon panah pada baris pertama
                Row(
                  children: [
                    // Text: label "Rekomendasi Untukmu"
                    Text(
                      'Rekomendasi Untukmu',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF6B1F1F),
                      ),
                    ),
                    SizedBox(width: 4),
                    // Icon: ikon panah kecil
                    Icon(Icons.arrow_forward_rounded,
                        size: 13, color: Color(0xFF6B1F1F)),
                  ],
                ),
                SizedBox(height: 4),
                // Text: nama produk rekomendasi
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
                // Text: deskripsi singkat rekomendasi
                Text(
                  'Manis, creamy, dan bikin nagih',
                  style: TextStyle(fontSize: 12, color: Color(0xFF8B6F6F)),
                ),
              ],
            ),
          ),
          // Icon: chevron kanan sebagai indikasi bisa diklik
          Icon(Icons.chevron_right_rounded, color: Color(0xFF6B1F1F)),
        ],
      ),
    );
  }
}