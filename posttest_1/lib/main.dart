import 'package:flutter/material.dart';
import 'widgets/productCard.dart';

void main() {
  // runApp digunakan untuk menjalankan aplikasi Flutter
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp digunakan sebagai pembungkus utama dan pengaturan dasar aplikasi
    return MaterialApp(
      title: 'KopiKita',
      debugShowCheckedModeBanner: false,

      // ThemeData digunakan untuk mengatur tampilan dan warna utama aplikasi
      theme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6F4E37),
        ),
        useMaterial3: true,
      ),

      // HomePage digunakan sebagai halaman pertama yang ditampilkan
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold digunakan sebagai struktur dasar halaman aplikasi
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0EB),

      // SafeArea digunakan agar isi aplikasi tidak tertutup status bar
      body: SafeArea(

        // SingleChildScrollView digunakan agar seluruh isi halaman dapat digulir
        child: SingleChildScrollView(

          // Padding digunakan untuk memberikan jarak antara isi dan tepi layar
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),

            // Column digunakan untuk menyusun seluruh bagian halaman secara vertikal
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Row digunakan untuk menyusun bagian logo dan notifikasi secara horizontal
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    // Row digunakan untuk menyusun logo dan nama aplikasi berdampingan
                    Row(
                      children: [

                        // Container digunakan untuk membuat kotak sebagai latar logo aplikasi
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: const Color(0xFF6F4E37),
                            borderRadius: BorderRadius.circular(12),
                          ),

                          // Icon digunakan untuk menampilkan simbol kopi sebagai logo
                          child: const Icon(
                            Icons.local_cafe,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),

                        // SizedBox digunakan untuk memberikan jarak antara logo dan nama aplikasi
                        const SizedBox(width: 12),

                        // Text digunakan untuk menampilkan nama aplikasi KopiKita
                        const Text(
                          'KopiKita',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3E2723),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),

                    // Container digunakan sebagai tempat ikon notifikasi
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),

                      // Icon digunakan untuk menunjukkan fitur notifikasi
                      child: const Icon(
                        Icons.notifications_outlined,
                        size: 24,
                        color: Color(0xFF6F4E37),
                      ),
                    ),
                  ],
                ),

                // SizedBox digunakan untuk memberikan jarak setelah bagian header
                const SizedBox(height: 6),

                // Text digunakan untuk menampilkan sapaan kepada pengguna
                const Text(
                  'Mau ngopi apa hari ini?',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF8D6E63),
                  ),
                ),

                // SizedBox digunakan untuk memberikan jarak sebelum kolom pencarian
                const SizedBox(height: 22),

                // TextField digunakan untuk menyediakan kolom pencarian menu
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari kopi favoritmu...',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 14,
                    ),

                    // Icon digunakan sebagai penanda bahwa kolom berfungsi untuk mencari
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF6F4E37),
                      size: 22,
                    ),

                    // Container digunakan sebagai latar tombol filter pencarian
                    suffixIcon: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6F4E37),
                        borderRadius: BorderRadius.circular(10),
                      ),

                      // Icon digunakan untuk menunjukkan fitur pengaturan filter
                      child: const Icon(
                        Icons.tune,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),

                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),

                    // OutlineInputBorder digunakan untuk mengatur bentuk tepi kolom pencarian
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Colors.brown.shade100,
                        width: 1,
                      ),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color(0xFF6F4E37),
                        width: 2,
                      ),
                    ),
                  ),
                ),

                // SizedBox digunakan untuk memberikan jarak sebelum banner promo
                const SizedBox(height: 22),

                // Container digunakan untuk membuat area banner promo
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF6F4E37),
                        Color(0xFFA67B5B),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  padding: const EdgeInsets.all(22),

                  // Row digunakan untuk menempatkan informasi promo dan ikon secara berdampingan
                  child: Row(
                    children: [

                      // Expanded digunakan agar bagian teks promo menggunakan ruang yang tersedia
                      Expanded(

                        // Column digunakan untuk menyusun isi promo secara vertikal
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            // Container digunakan untuk membuat tanda khusus pada promo
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0x33FFFFFF),
                                borderRadius: BorderRadius.circular(20),
                              ),

                              // Text digunakan untuk menampilkan label promo
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

                            // SizedBox digunakan untuk memberikan jarak antar informasi promo
                            const SizedBox(height: 12),

                            // Text digunakan untuk menampilkan nama promo.
                            const Text(
                              'Buy 1 Get 1',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            // SizedBox digunakan untuk memberikan jarak sebelum deskripsi
                            const SizedBox(height: 6),

                            // Text digunakan untuk menjelaskan detail promo
                            const Text(
                              'Nikmati kopi favoritmu\ndengan harga spesial',
                              style: TextStyle(
                                color: Color(0xCCFFFFFF),
                                fontSize: 12,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Icon digunakan untuk memperkuat tampilan visual banner kopi
                      const Icon(
                        Icons.local_cafe,
                        size: 64,
                        color: Color(0x40FFFFFF),
                      ),
                    ],
                  ),
                ),

                // SizedBox digunakan untuk memberikan jarak sebelum bagian kategori
                const SizedBox(height: 26),

                // Text digunakan untuk menampilkan judul bagian kategori
                const Text(
                  'Kategori',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E2723),
                  ),
                ),

                // SizedBox digunakan untuk memberikan jarak antara judul dan kategori
                const SizedBox(height: 14),

                // Row digunakan untuk menyusun pilihan kategori secara horizontal
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildKategoriItem(
                      icon: Icons.coffee,
                      label: 'Coffee',
                    ),
                    _buildKategoriItem(
                      icon: Icons.local_drink,
                      label: 'Non Coffee',
                    ),
                    _buildKategoriItem(
                      icon: Icons.bakery_dining,
                      label: 'Snack',
                    ),
                  ],
                ),

                // SizedBox digunakan untuk memberikan jarak sebelum rekomendasi
                const SizedBox(height: 26),

                // Widget rekomendasi digunakan untuk menampilkan menu yang disarankan
                _buildRekomendasiBanner(
                  menu: 'Caramel Latte',
                  deskripsi: 'Manis, creamy, dan bikin nagih',
                ),

                // SizedBox digunakan untuk memberikan jarak sebelum daftar produk
                const SizedBox(height: 26),

                // Row digunakan untuk menyusun judul produk dan pilihan lihat semua
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    // Text digunakan untuk menampilkan judul bagian produk
                    const Text(
                      'Produk',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3E2723),
                      ),
                    ),

                    // Text digunakan untuk memberikan pilihan melihat seluruh produk
                    Text(
                      'Lihat semua',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.brown.shade400,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                // SizedBox digunakan untuk memberikan jarak sebelum produk pertama
                const SizedBox(height: 14),

                // ProductCard digunakan untuk menampilkan informasi produk Cappuccino
                ProductCard(
                  nama: 'Cappuccino',
                  deskripsi: 'Espresso dengan busa susu lembut',
                  harga: 'Rp18.000',
                  rating: 4.8,
                  ulasan: 245,
                  icon: Icons.coffee,
                  isBestSeller: true,
                ),

                // SizedBox digunakan untuk memberikan jarak antar produk
                const SizedBox(height: 14),

                // ProductCard digunakan untuk menampilkan informasi produk Caffe Latte
                ProductCard(
                  nama: 'Caffe Latte',
                  deskripsi: 'Espresso dengan susu steamed',
                  harga: 'Rp20.000',
                  rating: 4.7,
                  ulasan: 180,
                  icon: Icons.coffee_maker,
                  isBestSeller: true,
                ),

                // SizedBox digunakan untuk memberikan jarak antar produk
                const SizedBox(height: 14),

                // ProductCard digunakan untuk menampilkan informasi produk Espresso
                ProductCard(
                  nama: 'Espresso',
                  deskripsi: 'Kopi murni pekat khas Italia',
                  harga: 'Rp15.000',
                  rating: 4.6,
                  ulasan: 120,
                  icon: Icons.emoji_food_beverage,
                  isBestSeller: false,
                ),

                // SizedBox digunakan untuk memberikan ruang di bagian bawah halaman
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),

      // BottomNavigationBar digunakan untuk menyediakan navigasi utama aplikasi
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF6F4E37),
        unselectedItemColor: Colors.grey.shade400,
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        elevation: 8,

        // items digunakan untuk menentukan pilihan navigasi yang tersedia
        items: const [

          // BottomNavigationBarItem digunakan untuk menuju halaman Home
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          // BottomNavigationBarItem digunakan untuk menuju halaman Menu
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Menu',
          ),

          // BottomNavigationBarItem digunakan untuk menuju halaman Keranjang
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Keranjang',
          ),

          // BottomNavigationBarItem digunakan untuk menuju halaman Profil
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget _buildKategoriItem({
    required IconData icon,
    required String label,
  }) {
    // Column digunakan untuk menyusun ikon dan nama kategori secara vertikal
    return Column(
      children: [

        // Container digunakan untuk membuat area tampilan ikon kategori
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.brown.shade100,
              width: 1,
            ),
          ),

          // Icon digunakan untuk menunjukkan jenis kategori
          child: Icon(
            icon,
            size: 30,
            color: const Color(0xFF6F4E37),
          ),
        ),

        // SizedBox digunakan untuk memberikan jarak antara ikon dan nama kategori
        const SizedBox(height: 8),

        // Text digunakan untuk menampilkan nama kategori
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF3E2723),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildRekomendasiBanner({
    required String menu,
    required String deskripsi,
  }) {
    // Container digunakan untuk membuat area khusus rekomendasi menu
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF6EC),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE8C9A0),
          width: 1.2,
        ),
      ),

      // Row digunakan untuk menyusun ikon dan informasi rekomendasi secara horizontal
      child: Row(
        children: [

          // Container digunakan sebagai latar ikon rekomendasi
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFF6F4E37),
              borderRadius: BorderRadius.circular(12),
            ),

            // Icon digunakan untuk menandai bagian rekomendasi
            child: const Icon(
              Icons.auto_awesome,
              color: Colors.white,
              size: 22,
            ),
          ),

          // SizedBox digunakan untuk memberikan jarak antara ikon dan teks
          const SizedBox(width: 14),

          // Expanded digunakan agar informasi rekomendasi menyesuaikan lebar layar
          Expanded(

            // Column digunakan untuk menyusun informasi rekomendasi secara vertikal
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Row digunakan untuk menyusun judul rekomendasi dan ikon panah
                Row(
                  children: [

                    // Text digunakan untuk menampilkan judul rekomendasi
                    const Text(
                      'Rekomendasi Untukmu',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF6F4E37),
                      ),
                    ),

                    // SizedBox digunakan untuk memberikan jarak sebelum ikon panah
                    const SizedBox(width: 4),

                    // Icon digunakan untuk menunjukkan arah rekomendasi
                    Icon(
                      Icons.arrow_forward,
                      size: 14,
                      color: Colors.brown.shade400,
                    ),
                  ],
                ),

                // SizedBox digunakan untuk memberikan jarak sebelum nama menu
                const SizedBox(height: 4),

                // Text digunakan untuk menampilkan nama menu yang direkomendasikan
                Text(
                  'Coba $menu!',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E2723),
                  ),
                ),

                // SizedBox digunakan untuk memberikan jarak sebelum deskripsi
                const SizedBox(height: 2),

                // Text digunakan untuk menampilkan deskripsi menu rekomendasi
                Text(
                  deskripsi,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
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