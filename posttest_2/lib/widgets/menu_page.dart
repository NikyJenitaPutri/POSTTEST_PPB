import 'package:flutter/material.dart';

// Mengambil widget ProductCard dari file productCard.dart
import 'product_card.dart';

// MenuPage digunakan untuk menampilkan seluruh daftar menu
class MenuPage extends StatelessWidget {
  // Constructor untuk MenuPage
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold sebagai struktur utama halaman
    return Scaffold(
      // Warna background halaman
      backgroundColor: Colors.white,

      // SafeArea menjaga isi halaman agar tidak tertutup bagian sistem
      body: SafeArea(
        // SingleChildScrollView membuat halaman bisa di-scroll
        child: SingleChildScrollView(
          // Padding memberikan jarak isi halaman dari tepi layar
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),

            // Column menyusun semua isi halaman dari atas ke bawah
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ================= HEADER =================
                // Row digunakan untuk menampilkan ikon dan judul halaman di bagian atas
                Row(
                  children: [
                    Navigator.canPop(context)
                        ? GestureDetector(
                            // Navigator.pop digunakan untuk kembali ke halaman sebelumnya
                            onTap: () => Navigator.pop(context),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Color(0xFF660000),
                              size: 24,
                            ),
                          )
                        : const Icon(
                            Icons.menu_book,
                            color: Color(0xFF660000),
                            size: 24,
                          ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Menu',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2B0000),
                        ),
                      ),
                    ),
                    // Icon pencarian (belum menjalankan aksi)
                    const Icon(Icons.search, color: Color(0xFF660000)),
                  ],
                ),
                const SizedBox(height: 20),

                // ================= BANNER =================

                // SizedBox menentukan tinggi area banner
                SizedBox(
                  height: 130,

                  // Stack digunakan untuk menumpuk beberapa widget dalam satu area yang sama
                  child: Stack(
                    children: [
                      // Container digunakan sebagai background banner
                      Container(
                        // Lebar mengikuti ukuran yang tersedia
                        width: double.infinity,

                        // Tinggi banner
                        height: 130,

                        // Membuat isi Container mengikuti bentuk sudut
                        clipBehavior: Clip.antiAlias,

                        // BoxDecoration mengatur tampilan Container
                        decoration: BoxDecoration(
                          // LinearGradient membuat warna background gradasi
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF2B0000),
                              Color(0xFF660000),
                            ],

                            // Arah awal gradasi
                            begin: Alignment.topLeft,

                            // Arah akhir gradasi
                            end: Alignment.bottomRight,
                          ),

                          // Membuat sudut banner melengkung
                          borderRadius: BorderRadius.circular(18),

                          // Memberikan efek bayangan pada banner
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x59660000),
                              blurRadius: 12,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                      ),

                      // Positioned digunakan untuk menentukan posisi icon kopi di dalam Stack
                      const Positioned(
                        // Jarak icon dari sisi kanan
                        right: 20,

                        // Posisi atas
                        top: 0,

                        // Posisi bawah
                        bottom: 0,

                        // Icon kopi sebagai hiasan banner
                        child: Icon(
                          Icons.local_cafe,
                          size: 85,
                          color: Color(0x26FFFFFF),
                        ),
                      ),

                      // Positioned digunakan untuk menentukan posisi tulisan di dalam Stack
                      const Positioned(
                        // Jarak tulisan dari sisi kiri
                        left: 20,

                        // Memberikan batas agar tulisan tidak bertabrakan dengan icon kopi
                        right: 90,

                        // Posisi atas
                        top: 0,

                        // Posisi bawah
                        bottom: 0,

                        // Column menyusun judul dan deskripsi
                        child: Column(
                          // Menempatkan isi di tengah secara vertikal
                          mainAxisAlignment: MainAxisAlignment.center,

                          // Menempatkan isi dari sisi kiri
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            // Judul banner
                            Text(
                              'Semua Menu',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            // Memberikan jarak antara judul dan deskripsi
                            SizedBox(height: 4),

                            // Deskripsi banner
                            Text(
                              'Temukan minuman dan makanan\nfavoritmu',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Memberikan jarak setelah banner
                const SizedBox(height: 20),

                // ================= DAFTAR KATEGORI =================

                // Container digunakan sebagai kotak pembungkus kategori
                Container(
                  // Lebar mengikuti ukuran layar
                  width: double.infinity,

                  // Memberikan jarak isi dari tepi Container
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),

                  // Mengatur tampilan Container
                  decoration: BoxDecoration(
                    // Warna background
                    color: Colors.white,

                    // Membuat sudut melengkung
                    borderRadius: BorderRadius.circular(16),

                    // Memberikan garis tepi
                    border: Border.all(
                      color: const Color(0x33660000),
                    ),

                    // Memberikan efek bayangan
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x1A660000),
                        blurRadius: 10,
                        offset: Offset(0, -3),
                      ),
                    ],
                  ),

                  // Column menyusun daftar kategori secara vertikal
                  child: Column(
                    children: [
                      // Menampilkan kategori Coffee
                      _buildBarisKategori(
                        icon: Icons.coffee,
                        label: 'Coffee',
                      ),

                      // Menampilkan kategori Non-Coffee
                      _buildBarisKategori(
                        icon: Icons.local_drink,
                        label: 'Non-Coffee',
                      ),

                      // Menampilkan kategori Snack
                      _buildBarisKategori(
                        icon: Icons.bakery_dining,
                        label: 'Snack',
                      ),
                    ],
                  ),
                ),

                // Memberikan jarak setelah daftar kategori
                const SizedBox(height: 24),

                // ================= SECTION COFFEE =================

                // Menampilkan section produk Coffee
                _buildSection(
                  context: context,
                  judul: 'Coffee',

                  // Daftar produk yang masuk kategori Coffee
                  produk: const [
                    // Data produk Cappuccino
                    _DataProduk(
                      nama: 'Cappuccino',
                      deskripsi: 'Espresso dengan busa susu lembut',
                      harga: 'Rp18.000',
                      rating: 4.9,
                      ulasan: 245,
                      icon: Icons.coffee,
                      gambar: 'assets/images/Cappucino.png',
                      isBestSeller: true,
                    ),

                    // Data produk Caffe Latte
                    _DataProduk(
                      nama: 'Caffe Latte',
                      deskripsi: 'Espresso dengan susu steamed',
                      harga: 'Rp20.000',
                      rating: 4.8,
                      ulasan: 180,
                      icon: Icons.coffee_maker,
                      gambar: 'assets/images/CoffeLatte.png',
                      isBestSeller: true,
                    ),
                  ],
                ),

                // Memberikan jarak antar section
                const SizedBox(height: 24),

                // ================= SECTION NON-COFFEE =================

                // Menampilkan section produk Non-Coffee
                _buildSection(
                  context: context,
                  judul: 'Non-Coffee',

                  // Daftar produk Non-Coffee
                  produk: const [
                    // Data produk Matcha Latte
                    _DataProduk(
                      nama: 'Matcha Latte',
                      deskripsi: 'Matcha premium dengan susu segar',
                      harga: 'Rp20.000',
                      rating: 4.8,
                      ulasan: 150,
                      icon: Icons.emoji_food_beverage,
                      gambar: 'assets/images/MatchaLatte.png',
                      isBestSeller: true,
                    ),

                    // Data produk Chocolate
                    _DataProduk(
                      nama: 'Chocolate',
                      deskripsi: 'Cokelat manis dengan whipped cream',
                      harga: 'Rp18.000',
                      rating: 4.7,
                      ulasan: 130,
                      icon: Icons.local_drink,
                      gambar: 'assets/images/Chocolate.png',
                      isBestSeller: false,
                    ),
                  ],
                ),

                // Memberikan jarak antar section
                const SizedBox(height: 24),

                // ================= SECTION SNACK =================

                // Menampilkan section produk Snack
                _buildSection(
                  context: context,
                  judul: 'Snack',

                  // Daftar produk Snack
                  produk: const [
                    // Data produk Croissant
                    _DataProduk(
                      nama: 'Croissant',
                      deskripsi: 'Pastry butter yang renyah di luar',
                      harga: 'Rp15.000',
                      rating: 4.8,
                      ulasan: 90,
                      icon: Icons.bakery_dining,
                      gambar: 'assets/images/Croissant.png',
                      isBestSeller: false,
                    ),

                    // Data produk French Fries
                    _DataProduk(
                      nama: 'French Fries',
                      deskripsi: 'Kentang goreng gurih dan hangat',
                      harga: 'Rp13.000',
                      rating: 4.6,
                      ulasan: 75,
                      icon: Icons.lunch_dining,
                      gambar: 'assets/images/FrenchFries.png',
                      isBestSeller: false,
                    ),
                  ],
                ),

                // Memberikan jarak di bagian bawah halaman
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= WIDGET BARIS KATEGORI =================

  // Fungsi ini digunakan untuk membuat satu baris kategori sehingga tidak perlu menulis kode yang sama berulang kali
  Widget _buildBarisKategori({
    // Icon yang akan ditampilkan pada kategori
    required IconData icon,

    // Nama kategori yang akan ditampilkan
    required String label,
  }) {
    // Padding memberikan jarak atas dan bawah pada baris kategori
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),

      // Row menyusun icon, nama kategori, dan tanda panah secara horizontal
      child: Row(
        children: [
          // Container digunakan sebagai kotak icon kategori
          Container(
            // Lebar kotak icon
            width: 38,

            // Tinggi kotak icon
            height: 38,

            // Mengatur tampilan kotak icon
            decoration: BoxDecoration(
              // Warna background kotak
              color: const Color(0x1A660000),

              // Membuat sudut kotak melengkung
              borderRadius: BorderRadius.circular(10),

              // Memberikan bayangan pada kotak icon
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1A660000),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),

            // Icon menampilkan icon sesuai kategori
            child: Icon(
              icon,
              size: 20,
              color: const Color(0xFF660000),
            ),
          ),

          // Memberikan jarak antara icon dan nama kategori
          const SizedBox(width: 14),

          // Expanded membuat nama kategori menggunakan ruang yang tersedia
          Expanded(
            // Text menampilkan nama kategori
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2B0000),
              ),
            ),
          ),

          // Icon chevron menunjukkan tanda panah ke kanan
          const Icon(
            Icons.chevron_right,
            color: Color(0xFF660000),
          ),
        ],
      ),
    );
  }

  // ================= WIDGET SECTION =================

  // Fungsi ini digunakan untuk membuat satu section produk seperti Coffee, Non-Coffee, dan Snack
  Widget _buildSection({
    // context digunakan jika widget membutuhkan informasi halaman
    required BuildContext context,

    // Judul section seperti Coffee atau Snack
    required String judul,

    // Daftar data produk yang akan ditampilkan
    required List<_DataProduk> produk,
  }) {
    // Column menyusun judul dan ProductCard secara vertikal
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text menampilkan judul section
        Text(
          judul,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2B0000),
          ),
        ),

        // Memberikan jarak antara judul dan produk
        const SizedBox(height: 12),

        // List.generate digunakan untuk membuat ProductCard berdasarkan jumlah data produk
        ...List.generate(produk.length, (index) {
          // Mengambil data produk berdasarkan index
          final item = produk[index];

          // Padding memberikan jarak antar ProductCard
          return Padding(
            padding: const EdgeInsets.only(bottom: 14),

            // ProductCard digunakan untuk menampilkan informasi setiap produk
            child: ProductCard(
              // Mengirim nama produk ke ProductCard
              nama: item.nama,

              // Mengirim deskripsi produk
              deskripsi: item.deskripsi,

              // Mengirim harga produk
              harga: item.harga,

              // Mengirim rating produk
              rating: item.rating,

              // Mengirim jumlah ulasan
              ulasan: item.ulasan,

              // Mengirim icon produk
              icon: item.icon,

              // Mengirim lokasi gambar produk
              gambar: item.gambar,

              // Mengirim status best seller
              isBestSeller: item.isBestSeller,
            ),
          );
        }),
      ],
    );
  }
}

// ================= MODEL DATA PRODUK =================

// Class ini digunakan untuk menyimpan data satu produk
class _DataProduk {
  // Menyimpan nama produk
  final String nama;

  // Menyimpan deskripsi produk
  final String deskripsi;

  // Menyimpan harga produk
  final String harga;

  // Menyimpan nilai rating produk
  final double rating;

  // Menyimpan jumlah ulasan produk
  final int ulasan;

  // Menyimpan icon produk
  final IconData icon;

  // Menyimpan lokasi file gambar produk
  final String gambar;

  // Menentukan apakah produk merupakan Best Seller
  final bool isBestSeller;

  // Constructor untuk membuat data produk
  const _DataProduk({
    // Parameter nama wajib diisi
    required this.nama,

    // Parameter deskripsi wajib diisi
    required this.deskripsi,

    // Parameter harga wajib diisi
    required this.harga,

    // Parameter rating wajib diisi
    required this.rating,

    // Parameter ulasan wajib diisi
    required this.ulasan,

    // Parameter icon wajib diisi
    required this.icon,

    // Parameter gambar wajib diisi
    required this.gambar,

    // Parameter status Best Seller wajib diisi
    required this.isBestSeller,
  });
}