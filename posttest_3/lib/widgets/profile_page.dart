import 'package:flutter/material.dart';

// ============================================================
// ProfilePage = HALAMAN PROFIL (StatelessWidget)
// Kegunaan: tampilkan profil user, statistik, pesanan terakhir,
//           dan menu pengaturan
// Tidak ada state lokal — semua data statis
// ============================================================
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold: kerangka halaman
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6F0),
      // SafeArea: hindari notch & status bar
      body: SafeArea(
        // SingleChildScrollView: halaman bisa discroll
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          // Column: susun anak vertikal
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Row(
                children: [
                  // Logo dengan fallback icon
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
                    // Image.asset: gambar dari assets
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
                          child: const Icon(Icons.person_rounded,
                              color: Colors.white, size: 22),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Expanded: judul + subjudul mengisi ruang sisa
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Profil',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF2B0000),
                            letterSpacing: -0.5,
                          ),
                        ),
                        Text(
                          'Akun saya',
                          style: TextStyle(
                              fontSize: 11, color: Color(0xFFB8A8A0)),
                        ),
                      ],
                    ),
                  ),
                  // Tombol settings
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6B1F1F).withOpacity(0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.settings_rounded,
                        color: Color(0xFF6B1F1F), size: 22),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // KARTU PROFIL (gradien + avatar + statistik)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
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
                // Stack: kartu + dekorasi lingkaran
                child: Stack(
                  children: [
                    // Dekorasi lingkaran buram
                    Positioned(
                      right: -40,
                      top: -40,
                      child: Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.08),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        // Avatar user (lingkaran + icon)
                        Container(
                          width: 88,
                          height: 88,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            // Border.all: garis tepi
                            border: Border.all(
                                color: const Color(0xFFD4A574), width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 16,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.person_rounded,
                              size: 48, color: Color(0xFF6B1F1F)),
                        ),
                        const SizedBox(height: 14),
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
                        // Badge "Coffee Lover"
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD4A574),
                            borderRadius: BorderRadius.circular(20),
                          ),
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
                        // Email user
                        Text(
                          'niky@kopikita.com',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.75),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Panel statistik
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: _buildStatistik('12', 'Pesanan'),
                              ),
                              // Garis pemisah tipis
                              Container(
                                width: 1,
                                height: 36,
                                color: Colors.white.withOpacity(0.2),
                              ),
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

              // PESANAN TERAKHIR
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

              // Card pesanan terakhir
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6B1F1F).withOpacity(0.06),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Thumbnail produk
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDF6F0),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset(
                        'assets/images/Cappucino.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.coffee,
                                color: Color(0xFF6B1F1F), size: 24),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Info nama + harga produk
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cappuccino',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF2B0000),
                            ),
                          ),
                          SizedBox(height: 3),
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
                    // Badge status
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6B1F1F).withOpacity(0.08),
                        borderRadius: BorderRadius.circular(20),
                      ),
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

              // PENGATURAN
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

              // Card menu pengaturan
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6B1F1F).withOpacity(0.06),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Reuse helper _buildMenuProfil untuk tiap baris
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

  // Helper: satu kolom statistik (angka + label)
  Widget _buildStatistik(String angka, String label) {
    return Column(
      children: [
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
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.white.withOpacity(0.75),
          ),
        ),
      ],
    );
  }

  // Helper: satu baris menu pengaturan
  // Parameter garisBawah: kontrol munculnya divider
  Widget _buildMenuProfil({
    required IconData icon,
    required String label,
    required Color warnaIcon,
    bool garisBawah = true,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              // Ikon dengan background tipis
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: warnaIcon.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: warnaIcon, size: 20),
              ),
              const SizedBox(width: 14),
              // Label menu
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
              // Chevron kanan (indikasi bisa diklik)
              const Icon(Icons.chevron_right_rounded,
                  color: Color(0xFFB8A8A0)),
            ],
          ),
        ),
        // Divider kondisional
        if (garisBawah)
          Divider(
            height: 1,
            thickness: 1,
            indent: 68,     // jarak dari kiri
            endIndent: 16,  // jarak dari kanan
            color: const Color(0xFF6B1F1F).withOpacity(0.06),
          ),
      ],
    );
  }
}