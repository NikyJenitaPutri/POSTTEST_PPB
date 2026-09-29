import 'package:flutter/material.dart';

import 'product_card.dart';
import 'menu_page.dart';
import 'product_detail_page.dart';

// StatelessWidget digunakan karena HomePage tidak memiliki state yang berubah secara langsung
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold digunakan sebagai struktur dasar halaman
    return Scaffold(
      // Mengatur warna background halaman menjadi putih
      backgroundColor: Colors.white,

      // SafeArea digunakan agar isi halaman tidak tertutup oleh status bar atau bagian sistem lainnya
      body: SafeArea(
        // SingleChildScrollView membuat halaman dapat di-scroll
        child: SingleChildScrollView(
          // Padding memberikan jarak isi dari tepi layar
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),

            // Column menyusun isi halaman dari atas ke bawah
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ================= HEADER =================

                // Row menyusun logo dan notifikasi secara horizontal
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Row digunakan untuk menggabungkan logo dan nama aplikasi
                    Row(
                      children: [
                        // Container digunakan sebagai tempat logo KopiKita
                        Container(
                          width: 42,
                          height: 42,

                          // BoxDecoration mengatur warna dan bentuk logo
                          decoration: BoxDecoration(
                            color: const Color(0xFF2B0000),
                            borderRadius: BorderRadius.circular(12),
                          ),

                          // Icon digunakan untuk menampilkan ikon kopi
                          child: const Icon(
                            Icons.local_cafe,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),

                        // SizedBox memberikan jarak antara logo dan nama
                        const SizedBox(width: 12),

                        // Text menampilkan nama aplikasi
                        const Text(
                          'KopiKita',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2B0000),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),

                    // Container digunakan sebagai tempat ikon notifikasi
                    Container(
                      width: 44,
                      height: 44,

                      // BoxDecoration mengatur background dan border
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0x33660000),
                        ),
                      ),

                      // Icon digunakan untuk menampilkan ikon notifikasi
                      child: const Icon(
                        Icons.notifications_outlined,
                        size: 24,
                        color: Color(0xFF660000),
                      ),
                    ),
                  ],
                ),

                // SizedBox memberikan jarak setelah header
                const SizedBox(height: 6),

                // Text digunakan untuk menampilkan sapaan
                const Text(
                  'Mau ngopi apa hari ini?',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF660000),
                  ),
                ),

                // SizedBox memberikan jarak sebelum search bar
                const SizedBox(height: 22),

                // ================= SEARCH BAR =================

                // TextField digunakan untuk membuat kolom pencarian
                TextField(
                  // InputDecoration mengatur tampilan TextField
                  decoration: InputDecoration(
                    // hintText menampilkan petunjuk pencarian
                    hintText: 'Cari kopi favoritmu...',

                    // hintStyle mengatur tampilan teks petunjuk
                    hintStyle: const TextStyle(
                      color: Color(0x80660000),
                      fontSize: 14,
                    ),

                    // prefixIcon menampilkan ikon search di sebelah kiri
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF660000),
                      size: 22,
                    ),

                    // suffixIcon menampilkan ikon filter di sebelah kanan
                    suffixIcon: Container(
                      margin: const EdgeInsets.all(8),

                      // BoxDecoration mengatur background tombol filter
                      decoration: BoxDecoration(
                        color: const Color(0xFF660000),
                        borderRadius: BorderRadius.circular(10),
                      ),

                      // Icon digunakan untuk ikon filter
                      child: const Icon(
                        Icons.tune,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),

                    // Membuat TextField memiliki background
                    filled: true,

                    // Mengatur warna background TextField
                    fillColor: Colors.white,

                    // Memberikan jarak isi TextField
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),

                    // Mengatur bentuk TextField
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),

                    // Border ketika TextField tidak dipilih
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color(0x33660000),
                        width: 1,
                      ),
                    ),

                    // Border ketika TextField sedang digunakan
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color(0xFF660000),
                        width: 2,
                      ),
                    ),
                  ),
                ),

                // SizedBox memberikan jarak setelah search bar
                const SizedBox(height: 22),

                // ================= BANNER PROMO =================

                // Container digunakan sebagai banner promosi
                Container(
                  width: double.infinity,

                  // BoxDecoration mengatur gradient dan bentuk banner
                  decoration: BoxDecoration(
                    // LinearGradient membuat background memiliki gradasi
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF2B0000),
                        Color(0xFF660000),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),

                    // Membuat sudut banner melengkung
                    borderRadius: BorderRadius.circular(18),

                    // BoxShadow memberikan efek bayangan
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x59660000),
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),

                  // Padding memberikan jarak isi banner
                  padding: const EdgeInsets.all(22),

                  // Row menyusun teks dan ikon secara horizontal
                  child: Row(
                    children: [
                      // Expanded membuat bagian teks
                      // menggunakan ruang yang tersedia
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Container digunakan untuk label promo
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),

                              // BoxDecoration mengatur background label
                              decoration: BoxDecoration(
                                color: const Color(0x99660000),
                                borderRadius: BorderRadius.circular(20),
                              ),

                              // Text menampilkan tulisan promo
                              child: const Text(
                                'SPECIAL OFFER',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ),

                            // SizedBox memberikan jarak
                            const SizedBox(height: 12),

                            // Text menampilkan judul promo
                            const Text(
                              'Buy 1 Get 1',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            // SizedBox memberikan jarak
                            const SizedBox(height: 6),

                            // Text menampilkan deskripsi promo
                            const Text(
                              'Nikmati kopi favoritmu\ndengan harga spesial',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Icon menampilkan ikon kopi pada banner
                      const Icon(
                        Icons.local_cafe,
                        size: 64,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),

                // SizedBox memberikan jarak setelah banner
                const SizedBox(height: 26),

                // ================= KATEGORI =================

                // Text menampilkan judul kategori
                const Text(
                  'Kategori',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2B0000),
                  ),
                ),

                // SizedBox memberikan jarak
                const SizedBox(height: 14),

                // Row menyusun kategori secara horizontal
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Menampilkan kategori Coffee
                    _buildKategoriItem(
                      icon: Icons.coffee,
                      label: 'Coffee',
                    ),

                    // Menampilkan kategori Non Coffee
                    _buildKategoriItem(
                      icon: Icons.local_drink,
                      label: 'Non Coffee',
                    ),

                    // Menampilkan kategori Snack
                    _buildKategoriItem(
                      icon: Icons.bakery_dining,
                      label: 'Snack',
                    ),
                  ],
                ),

                // SizedBox memberikan jarak setelah kategori
                const SizedBox(height: 26),

                // ================= REKOMENDASI =================

                // GestureDetector digunakan agar banner rekomendasi dapat ditekan
                GestureDetector(
                  // onTap dijalankan ketika banner ditekan
                  onTap: () {
                    // Navigator.push digunakan untuk berpindah ke halaman detail produk
                    Navigator.push(
                      context,

                      // MaterialPageRoute menentukan halaman tujuan
                      MaterialPageRoute(
                        builder: (context) => const ProductDetailPage(
                          nama: 'Caffe Latte',
                          deskripsi: 'Espresso dengan susu steamed',
                          harga: 'Rp20.000',
                          rating: 4.8,
                          ulasan: 180,
                          icon: Icons.coffee_maker,
                          gambar: 'assets/images/CoffeLatte.png',
                          isBestSeller: true,
                        ),
                      ),
                    );
                  },

                  // Menampilkan banner rekomendasi
                  child: _buildRekomendasiBanner(
                    menu: 'Caffe Latte',
                    deskripsi: 'Manis, creamy, dan bikin nagih',
                  ),
                ),

                // SizedBox memberikan jarak
                const SizedBox(height: 26),

                // ================= PRODUK =================

                // Row digunakan untuk membuat judul Produk dan tombol Lihat semua dalam satu baris
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text menampilkan judul Produk
                    const Text(
                      'Produk',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2B0000),
                      ),
                    ),

                    // GestureDetector membuat teks Lihat semua dapat ditekan
                    GestureDetector(
                      // onTap dijalankan ketika Lihat semua ditekan
                      onTap: () {
                        // Navigator.push digunakan untuk berpindah
                        // ke halaman MenuPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            // MenuPage adalah halaman yang akan dibuka
                            builder: (context) => const MenuPage(),
                          ),
                        );
                      },

                      // Text digunakan sebagai tombol Lihat semua
                      // Tidak menggunakan const pada Text agar lebih aman
                      child: Text(
                        'Lihat semua',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF660000),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                // SizedBox memberikan jarak sebelum produk
                const SizedBox(height: 14),

                // ProductCard digunakan untuk menampilkan produk Cappuccino
                const ProductCard(
                  nama: 'Cappuccino',
                  deskripsi: 'Espresso dengan busa susu lembut',
                  harga: 'Rp18.000',
                  rating: 4.8,
                  ulasan: 245,
                  icon: Icons.coffee,
                  gambar: 'assets/images/Cappucino.png',
                  isBestSeller: true,
                ),

                // SizedBox memberikan jarak antar produk
                const SizedBox(height: 14),

                // ProductCard digunakan untuk menampilkan produk Caffe Latte
                const ProductCard(
                  nama: 'Caffe Latte',
                  deskripsi: 'Espresso dengan susu steamed',
                  harga: 'Rp20.000',
                  rating: 4.7,
                  ulasan: 180,
                  icon: Icons.coffee_maker,
                  gambar: 'assets/images/CoffeLatte.png',
                  isBestSeller: true,
                ),

                // SizedBox memberikan jarak antar produk
                const SizedBox(height: 14),

                // ProductCard digunakan untuk menampilkan produk Espresso
                const ProductCard(
                  nama: 'Espresso',
                  deskripsi: 'Kopi murni pekat khas Italia',
                  harga: 'Rp15.000',
                  rating: 4.6,
                  ulasan: 120,
                  icon: Icons.emoji_food_beverage,
                  gambar: 'assets/images/Espresso.png',
                  isBestSeller: false,
                ),

                // SizedBox memberikan jarak bagian bawah halaman
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= WIDGET KATEGORI =================

  // Fungsi ini digunakan untuk membuat satu item kategori
  Widget _buildKategoriItem({
    required IconData icon,
    required String label,
  }) {
    // Column menyusun ikon dan nama kategori secara vertikal
    return Column(
      children: [
        // Container digunakan sebagai kotak ikon kategori
        Container(
          width: 70,
          height: 70,

          // BoxDecoration mengatur background, border, sudut, dan bayangan
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),

            // Border memberikan garis tepi
            border: Border.all(
              color: const Color(0x33660000),
              width: 1,
            ),

            // BoxShadow memberikan efek bayangan
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A660000),
                blurRadius: 8,
                offset: Offset(0, -3),
              ),
            ],
          ),

          // Icon menampilkan ikon kategori
          child: Icon(
            icon,
            size: 30,
            color: const Color(0xFF660000),
          ),
        ),

        // SizedBox memberikan jarak antara ikon dan nama kategori
        const SizedBox(height: 8),

        // Text menampilkan nama kategori
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF2B0000),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // ================= WIDGET REKOMENDASI =================

  // Fungsi ini digunakan untuk membuat banner rekomendasi
  Widget _buildRekomendasiBanner({
    required String menu,
    required String deskripsi,
  }) {
    // Container digunakan sebagai kotak utama rekomendasi
    return Container(
      width: double.infinity,

      // Padding memberikan jarak isi dengan batas Container
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 16,
      ),

      // BoxDecoration mengatur warna, border, dan sudut
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF660000),
          width: 1.2,
        ),
      ),

      // Row menyusun ikon dan teks secara horizontal
      child: Row(
        children: [
          // Container digunakan sebagai kotak ikon rekomendasi
          Container(
            width: 42,
            height: 42,

            // BoxDecoration mengatur background dan sudut
            decoration: BoxDecoration(
              color: const Color(0xFF660000),
              borderRadius: BorderRadius.circular(12),
            ),

            // Icon menampilkan ikon rekomendasi
            child: const Icon(
              Icons.auto_awesome,
              color: Colors.white,
              size: 22,
            ),
          ),

          // SizedBox memberikan jarak antara ikon dan teks
          const SizedBox(width: 14),

          // Expanded membuat teks menggunakan ruang yang tersedia
          Expanded(
            // Column menyusun teks rekomendasi secara vertikal
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row menyusun judul dan ikon panah
                Row(
                  children: [
                    // Text menampilkan judul rekomendasi
                    const Text(
                      'Rekomendasi Untukmu',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF660000),
                      ),
                    ),

                    // SizedBox memberikan jarak
                    const SizedBox(width: 4),

                    // Icon menampilkan ikon panah
                    const Icon(
                      Icons.arrow_forward,
                      size: 14,
                      color: Color(0xFF660000),
                    ),
                  ],
                ),

                // SizedBox memberikan jarak
                const SizedBox(height: 4),

                // Text menampilkan nama menu
                Text(
                  'Coba $menu!',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2B0000),
                  ),
                ),

                // SizedBox memberikan jarak
                const SizedBox(height: 2),

                // Text menampilkan deskripsi menu
                Text(
                  deskripsi,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF660000),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}