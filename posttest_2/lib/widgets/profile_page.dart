import 'package:flutter/material.dart';

// ProfilePage digunakan untuk menampilkan halaman profil pengguna
class ProfilePage extends StatelessWidget {
  // Constructor ProfilePage
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold digunakan sebagai struktur dasar halaman yang terdiri dari body
    return Scaffold(
      // Warna background halaman dibuat putih
      backgroundColor: Colors.white,

      // body merupakan isi utama halaman
      body: SafeArea(
        // SafeArea mencegah konten tertutup oleh status bar atau bagian layar lainnya
        child: SingleChildScrollView(
          // Padding memberikan jarak antara isi dan tepi layar
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),

          // Column digunakan untuk menyusun seluruh isi halaman dari atas ke bawah
          child: Column(
            // Semua isi Column dimulai dari sisi kiri
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // ================= HEADER =================
              // Row digunakan untuk menampilkan ikon dan judul halaman di bagian atas
              Row(
                children: [
                  const Icon(Icons.person, color: Color(0xFF660000), size: 24),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Profil',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2B0000),
                      ),
                    ),
                  ),
                  // Icon pengaturan (belum menjalankan aksi)
                  const Icon(Icons.settings, color: Color(0xFF660000)),
                ],
              ),
              const SizedBox(height: 20),

              // ================= KARTU IDENTITAS =================

              // Container digunakan sebagai kartu profil utama
              Container(
                // Lebar kartu mengikuti seluruh ruang yang tersedia
                width: double.infinity,

                // Memberikan jarak antara isi dan tepi kartu
                padding: const EdgeInsets.all(20),

                // BoxDecoration digunakan untuk mengatur gradient, radius, dan bayangan kartu
                decoration: BoxDecoration(
                  // LinearGradient memberikan warna gradasi
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

                  // Membuat sudut kartu melengkung
                  borderRadius: BorderRadius.circular(18),

                  // Memberikan bayangan pada kartu
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x59660000),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),

                // Column digunakan untuk menyusun foto, nama, status, email, dan statistik
                child: Column(
                  children: [
                    // Container digunakan sebagai lingkaran foto profil
                    Container(
                      // Lebar foto profil
                      width: 84,

                      // Tinggi foto profil
                      height: 84,

                      // Mengatur tampilan lingkaran profil
                      decoration: BoxDecoration(
                        // Warna background foto
                        color: Colors.white,

                        // Membuat Container menjadi lingkaran
                        shape: BoxShape.circle,

                        // Memberikan garis tepi pada foto
                        border: Border.all(
                          color: const Color(0xFF660000),
                          width: 3,
                        ),
                      ),

                      // Icon digunakan sebagai gambar profil sementara
                      child: const Icon(
                        Icons.person,
                        size: 46,
                        color: Color(0xFF2B0000),
                      ),
                    ),

                    // Memberikan jarak antara foto dan nama
                    const SizedBox(height: 14),

                    // Text digunakan untuk menampilkan nama pengguna
                    const Text(
                      'Niky Putri',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    // Memberikan jarak kecil
                    const SizedBox(height: 2),

                    // Text menampilkan keterangan pengguna
                    const Text(
                      'Coffee Lover',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),

                    // Memberikan jarak kecil
                    const SizedBox(height: 4),

                    // Text menampilkan email pengguna
                    const Text(
                      'niky@kopikita.com',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),

                    // Memberikan jarak sebelum statistik
                    const SizedBox(height: 18),

                    // Row digunakan untuk menampilkan statistik secara horizontal
                    Row(
                      children: [
                        // Expanded membuat statistik pertama menggunakan ruang yang tersedia
                        Expanded(
                          child: _buildStatistik(
                            angka: '12',
                            label: 'Pesanan',
                          ),
                        ),

                        // Container digunakan sebagai garis pemisah antara dua statistik
                        Container(
                          width: 1,
                          height: 40,
                          color: const Color(0x66FFFFFF),
                        ),

                        // Expanded membuat statistik kedua menggunakan ruang yang tersedia
                        Expanded(
                          child: _buildStatistik(
                            angka: '5',
                            label: 'Bulan Ini',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Memberikan jarak setelah kartu identitas
              const SizedBox(height: 22),

              // ================= PESANAN TERAKHIR =================

              // Text digunakan sebagai judul bagian
              const Text(
                'Pesanan Terakhir',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2B0000),
                ),
              ),

              // Memberikan jarak antara judul dan kartu pesanan
              const SizedBox(height: 12),

              // Container digunakan sebagai kartu pesanan terakhir
              Container(
                // Lebar kartu mengikuti ruang yang tersedia
                width: double.infinity,

                // Jarak antara isi dan tepi kartu
                padding: const EdgeInsets.all(16),

                // Mengatur tampilan kartu
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),

                  // Memberikan garis tepi
                  border: Border.all(
                    color: const Color(0x33660000),
                  ),

                  // Memberikan bayangan
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1A660000),
                      blurRadius: 10,
                      offset: Offset(0, -3),
                    ),
                  ],
                ),

                // Row digunakan untuk menyusun gambar, informasi produk, dan status
                child: Row(
                  children: [
                    // Container digunakan sebagai tempat gambar Cappuccino
                    Container(
                      width: 42,
                      height: 42,

                      // Mengatur background dan bentuk gambar
                      decoration: BoxDecoration(
                        color: const Color(0x1F660000),
                        borderRadius: BorderRadius.circular(12),
                      ),

                      // Membuat gambar mengikuti radius Container
                      clipBehavior: Clip.antiAlias,

                      // Image.asset digunakan untuk mengambil gambar dari folder assets
                      child: Image.asset(
                        'assets/images/Cappucino.png',

                        width: 42,
                        height: 42,

                        // Membuat gambar memenuhi area
                        fit: BoxFit.cover,

                        // Digunakan jika gambar gagal dimuat
                        errorBuilder: (context, error, stackTrace) {
                          // Menampilkan icon kopi sebagai pengganti gambar
                          return const Icon(
                            Icons.coffee,
                            color: Color(0xFF660000),
                            size: 22,
                          );
                        },
                      ),
                    ),

                    // Memberikan jarak antara gambar dan informasi produk
                    const SizedBox(width: 14),

                    // Expanded membuat informasi produk menggunakan sisa ruang
                    Expanded(
                      child: Column(
                        // Isi dimulai dari sisi kiri
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          // Menampilkan nama produk
                          const Text(
                            'Cappuccino',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2B0000),
                            ),
                          ),

                          // Jarak antara nama dan harga
                          const SizedBox(height: 3),

                          // Menampilkan harga produk
                          const Text(
                            'Rp18.000',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF660000),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Container digunakan untuk membuat badge status pesanan
                    Container(
                      // Memberikan jarak di dalam badge
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),

                      // Mengatur warna dan bentuk badge
                      decoration: BoxDecoration(
                        color: const Color(0x1F660000),
                        borderRadius: BorderRadius.circular(20),
                      ),

                      // Text menampilkan status pesanan
                      child: const Text(
                        'Selesai',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF660000),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Memberikan jarak setelah kartu pesanan
              const SizedBox(height: 22),

              // ================= PENGATURAN =================

              // Text digunakan sebagai judul bagian pengaturan
              const Text(
                'Pengaturan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2B0000),
                ),
              ),

              // Memberikan jarak antara judul dan daftar menu
              const SizedBox(height: 12),

              // Container digunakan sebagai pembungkus seluruh menu pengaturan
              Container(
                // Mengatur tampilan kotak pengaturan
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),

                  // Memberikan garis tepi
                  border: Border.all(
                    color: const Color(0x33660000),
                  ),

                  // Memberikan bayangan
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1A660000),
                      blurRadius: 10,
                      offset: Offset(0, -3),
                    ),
                  ],
                ),

                // Column menyusun menu pengaturan dari atas ke bawah
                child: Column(
                  children: [
                    // Menu Edit Profil
                    _buildMenuProfil(
                      icon: Icons.person_outline,
                      label: 'Edit Profil',
                    ),

                    // Menu Notifikasi
                    _buildMenuProfil(
                      icon: Icons.notifications_none,
                      label: 'Notifikasi',
                    ),

                    // Menu Pengaturan
                    _buildMenuProfil(
                      icon: Icons.settings_outlined,
                      label: 'Pengaturan',
                    ),

                    // Menu Bantuan garisBawah dibuat false agar tidak ada garis setelah menu terakhir
                    _buildMenuProfil(
                      icon: Icons.help_outline,
                      label: 'Bantuan',
                      garisBawah: false,
                    ),
                  ],
                ),
              ),

              // Jarak bagian bawah halaman
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // ================= WIDGET STATISTIK =================

  // Fungsi ini digunakan untuk membuat tampilan statistik seperti jumlah pesanan dan bulan
  Widget _buildStatistik({
    // Angka statistik yang ditampilkan
    required String angka,

    // Label yang menjelaskan angka statistik
    required String label,
  }) {
    // Column digunakan untuk menampilkan angka di atas dan label di bawah
    return Column(
      children: [
        // Text digunakan untuk menampilkan angka statistik
        Text(
          angka,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        // Memberikan jarak antara angka dan label
        const SizedBox(height: 2),

        // Text digunakan untuk menampilkan label statistik
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  // ================= WIDGET MENU PROFIL =================

  // Fungsi ini digunakan untuk membuat satu baris menu pada bagian Pengaturan
  Widget _buildMenuProfil({
    // Icon menu
    required IconData icon,

    // Nama atau label menu
    required String label,

    // Menentukan apakah garis pemisah ditampilkan
    bool garisBawah = true,
  }) {
    // Column digunakan agar setiap menu dapat memiliki Row dan Divider
    return Column(
      children: [
        // Padding memberikan jarak di dalam setiap menu
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),

          // Row digunakan untuk menyusun icon, teks, dan tanda panah secara horizontal
          child: Row(
            children: [
              // Icon menampilkan ikon menu
              Icon(
                icon,
                color: const Color(0xFF660000),
                size: 22,
              ),

              // Memberikan jarak antara icon dan teks
              const SizedBox(width: 16),

              // Expanded membuat teks menggunakan sisa ruang yang tersedia
              Expanded(
                // Text menampilkan nama menu
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2B0000),
                  ),
                ),
              ),

              // Icon chevron digunakan sebagai tanda bahwa menu dapat dipilih/dibuka
              const Icon(
                Icons.chevron_right,
                color: Color(0xFF660000),
              ),
            ],
          ),
        ),

        // Divider hanya ditampilkan jika garisBawah bernilai true
        if (garisBawah)

          // Divider digunakan sebagai garis pemisah antar menu
          const Divider(
            height: 1,
            thickness: 1,

            // Jarak garis dari sisi kiri
            indent: 16,

            // Jarak garis dari sisi kanan
            endIndent: 16,

            // Warna garis pemisah
            color: Color(0x33660000),
          ),
      ],
    );
  }
}