import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold: kerangka halaman (menyediakan background, body, dll)
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6F0), // Warna latar halaman
      // SafeArea: menghindari notch & status bar agar konten tidak terpotong
      body: SafeArea(
        // SingleChildScrollView: memungkinkan halaman discroll jika konten melebihi layar
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16), // Padding kiri-kanan 20, atas-bawah 16
          // Column: menyusun anak secara vertikal
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Anak rata kiri
            children: [
              // ================= HEADER =================
              // Row: menyusun anak secara horizontal
              Row(
                children: [
                  // Container: wadah untuk logo dengan dekorasi
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12), // Sudut melengkung 12
                      boxShadow: [
                        // BoxShadow: efek bayangan pada container
                        BoxShadow(
                          color: const Color(0xFF6B1F1F).withValues(alpha: 0.25),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias, // Memotong gambar agar sesuai sudut melengkung
                    // Image.asset: menampilkan gambar dari folder assets
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 42,
                      height: 42,
                      fit: BoxFit.cover, // Gambar menutupi seluruh area
                      // errorBuilder: widget fallback jika gambar gagal dimuat
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            // LinearGradient: gradien warna latar fallback
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF6B1F1F),
                                Color(0xFFB5474A)
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.person_rounded,
                              color: Colors.white, size: 22), // Ikon pengganti
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12), // Jarak horizontal 12
                  // Expanded: mengisi ruang sisa secara horizontal
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text: menampilkan judul "Profil"
                        Text(
                          'Profil',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF2B0000),
                            letterSpacing: -0.5,
                          ),
                        ),
                        // Text: subjudul "Akun saya"
                        Text(
                          'Akun saya',
                          style: TextStyle(
                              fontSize: 11, color: Color(0xFFB8A8A0)),
                        ),
                      ],
                    ),
                  ),
                  // Container: tombol settings di kanan atas
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
                    // Icon: ikon settings
                    child: const Icon(Icons.settings_rounded,
                        color: Color(0xFF6B1F1F), size: 22),
                  ),
                ],
              ),
              const SizedBox(height: 24), // Jarak vertikal 24

              // ================= KARTU PROFIL (gradien + avatar + statistik) =================
              // Container: kartu utama profil
              Container(
                width: double.infinity, // Lebar penuh
                padding: const EdgeInsets.all(24), // Padding dalam 24
                decoration: BoxDecoration(
                  // LinearGradient: gradien latar kartu
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF2B0000),
                      Color(0xFF6B1F1F),
                      Color(0xFFB5474A),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24), // Sudut melengkung 24
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6B1F1F).withValues(alpha: 0.4),
                      blurRadius: 24,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                // Stack: menumpuk widget (kartu + dekorasi lingkaran)
                child: Stack(
                  children: [
                    // Positioned: dekorasi lingkaran buram di pojok kanan atas
                    Positioned(
                      right: -40,
                      top: -40,
                      child: Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle, // Bentuk lingkaran
                          color: Colors.white.withValues(alpha: 0.08), // Warna putih transparan
                        ),
                      ),
                    ),
                    // Column: menyusun konten kartu secara vertikal
                    Column(
                      children: [
                        // Container: avatar user (lingkaran putih dengan ikon)
                        Container(
                          width: 88,
                          height: 88,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            // Border.all: garis tepi avatar
                            border: Border.all(
                                color: const Color(0xFFD4A574), width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 16,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          // Icon: ikon orang sebagai avatar
                          child: const Icon(Icons.person_rounded,
                              size: 48, color: Color(0xFF6B1F1F)),
                        ),
                        const SizedBox(height: 14),
                        // Text: nama user
                        const Text(
                          'Niky Jenita Putri',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Container: badge "Coffee Lover"
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD4A574),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          // Text: label badge
                          child: const Text(
                            'Coffee Lover',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF2B0000),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        // Text: email user
                        Text(
                          'niky@kopikita.com',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.75),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Container: panel statistik (pesanan & bulan ini)
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          // Row: menyusun statistik secara horizontal
                          child: Row(
                            children: [
                              // Expanded: kolom statistik pertama
                              Expanded(
                                child: _buildStatistik('12', 'Pesanan'),
                              ),
                              // Container: garis pemisah tipis
                              Container(
                                width: 1,
                                height: 36,
                                color: Colors.white.withValues(alpha: 0.2),
                              ),
                              // Expanded: kolom statistik kedua
                              Expanded(
                                child: _buildStatistik('5', 'Bulan Ini'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ================= PESANAN TERAKHIR =================
              // Text: judul section
              const Text(
                'Pesanan Terakhir',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2B0000),
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 12),

              // Container: card pesanan terakhir
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6B1F1F).withValues(alpha: 0.06),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                // Row: menyusun thumbnail, info, dan badge status
                child: Row(
                  children: [
                    // Container: thumbnail produk
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDF6F0),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      clipBehavior: Clip.antiAlias,
                      // Image.asset: gambar produk
                      child: Image.asset(
                        'assets/images/Cappucino.png',
                        fit: BoxFit.cover,
                        // errorBuilder: fallback jika gambar gagal
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.coffee,
                                color: Color(0xFF6B1F1F), size: 24),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Expanded: info nama dan harga produk
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text: nama produk
                          Text(
                            'Cappuccino',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF2B0000),
                            ),
                          ),
                          SizedBox(height: 3),
                          // Text: harga produk
                          Text(
                            'Rp18.000',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF6B1F1F),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Container: badge status "Selesai"
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6B1F1F).withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      // Text: label status
                      child: const Text(
                        '✓ Selesai',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF6B1F1F),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ================= PENGATURAN =================
              // Text: judul section
              const Text(
                'Pengaturan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2B0000),
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 12),

              // Container: card menu pengaturan
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6B1F1F).withValues(alpha: 0.06),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                // Column: menyusun baris menu secara vertikal
                child: Column(
                  children: [
                    // Memanggil helper _buildMenuProfil untuk tiap baris menu
                    _buildMenuProfil(
                        icon: Icons.person_outline_rounded,
                        label: 'Edit Profil',
                        warnaIcon: const Color(0xFF6B1F1F)),
                    _buildMenuProfil(
                        icon: Icons.notifications_none_rounded,
                        label: 'Notifikasi',
                        warnaIcon: const Color(0xFFD4A574)),
                    _buildMenuProfil(
                        icon: Icons.settings_outlined,
                        label: 'Pengaturan',
                        warnaIcon: const Color(0xFF8B6F6F)),
                    _buildMenuProfil(
                        icon: Icons.help_outline_rounded,
                        label: 'Bantuan',
                        garisBawah: false, // item terakhir tanpa divider
                        warnaIcon: const Color(0xFFB5474A)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // Helper: satu kolom statistik (angka + label)
  // ============================================================
  Widget _buildStatistik(String angka, String label) {
    // Column: menyusun angka dan label secara vertikal
    return Column(
      children: [
        // Text: menampilkan angka statistik
        Text(
          angka,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 2),
        // Text: menampilkan label statistik
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.white.withValues(alpha: 0.75),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // Helper: satu baris menu pengaturan
  // Parameter garisBawah: kontrol munculnya divider
  // ============================================================
  Widget _buildMenuProfil({
    required IconData icon,
    required String label,
    required Color warnaIcon,
    bool garisBawah = true,
  }) {
    // Column: menyusun baris menu dan divider secara vertikal
    return Column(
      children: [
        // Padding: memberi jarak di sekitar baris menu
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          // Row: menyusun ikon, label, dan chevron secara horizontal
          child: Row(
            children: [
              // Container: ikon dengan background tipis
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: warnaIcon.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                // Icon: ikon menu
                child: Icon(icon, color: warnaIcon, size: 20),
              ),
              const SizedBox(width: 14),
              // Expanded: label menu mengisi ruang sisa
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2B0000),
                  ),
                ),
              ),
              // Icon: chevron kanan sebagai indikasi bisa diklik
              const Icon(Icons.chevron_right_rounded,
                  color: Color(0xFFB8A8A0)),
            ],
          ),
        ),
        // Divider kondisional: hanya tampil jika garisBawah true
        if (garisBawah)
          Divider(
            height: 1,
            thickness: 1,
            indent: 68,     // jarak dari kiri
            endIndent: 16,  // jarak dari kanan
            color: const Color(0xFF6B1F1F).withValues(alpha: 0.06),
          ),
      ],
    );
  }
}