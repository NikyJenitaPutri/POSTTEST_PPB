import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String nama;
  final String deskripsi;
  final String harga;
  final double rating;
  final int ulasan;
  final IconData icon;
  final bool isBestSeller;

  const ProductCard({
    super.key,
    required this.nama,
    required this.deskripsi,
    required this.harga,
    required this.rating,
    required this.ulasan,
    required this.icon,
    required this.isBestSeller,
  });

  @override
  Widget build(BuildContext context) {
    // Container digunakan untuk membuat tampilan kartu produk
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.brown.shade100,
          width: 1,
        ),
      ),

      // Row digunakan untuk menyusun gambar dan informasi produk secara horizontal
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Container digunakan sebagai area tampilan gambar atau ikon produk
          Container(
            width: 95,
            height: 95,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFE8DCD3),
                  Color(0xFFD7C4B7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),

            // Icon digunakan untuk menampilkan ikon sesuai jenis produk
            child: Icon(
              icon,
              size: 42,
              color: Colors.brown.shade400,
            ),
          ),

          // SizedBox digunakan untuk memberikan jarak antara gambar dan informasi produk
          const SizedBox(width: 14),

          // Expanded digunakan agar informasi produk menyesuaikan ruang yang tersedia
          Expanded(
            // Column digunakan untuk menyusun informasi produk secara vertikal
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row digunakan untuk menampilkan nama produk dan badge (jika best seller)
                Row(
                  children: [
                    // Expanded agar nama produk tidak overflow ketika badge muncul
                    Expanded(
                      child: Text(
                        nama,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3E2723),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    // Kondisi ini digunakan untuk menampilkan badge jika produk Best Seller
                    if (isBestSeller) ...[
                      const SizedBox(width: 6),
                      _buildBadge(
                        text: 'BESTSELLER',
                        color: const Color(0xFFE65100),
                        icon: Icons.local_fire_department,
                      ),
                    ],
                  ],
                ),

                // SizedBox digunakan untuk memberikan jarak antara nama dan deskripsi produk
                const SizedBox(height: 4),

                // Text digunakan untuk menampilkan deskripsi singkat produk
                Text(
                  deskripsi,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                // SizedBox digunakan untuk memberikan jarak sebelum informasi rating
                const SizedBox(height: 6),

                // _buildRating digunakan untuk menampilkan rating dan jumlah ulasan produk
                _buildRating(
                  rating: rating,
                  ulasan: ulasan,
                ),

                // SizedBox digunakan untuk memberikan jarak sebelum harga dan tombol tambah
                const SizedBox(height: 8),

                // Row digunakan untuk menempatkan harga dan tombol tambah secara horizontal
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text digunakan untuk menampilkan harga produk
                    Text(
                      harga,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6F4E37),
                      ),
                    ),

                    // Container digunakan untuk membuat area tombol tambah produk
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6F4E37),
                        borderRadius: BorderRadius.circular(9),
                      ),

                      // Icon digunakan untuk menunjukkan fungsi menambahkan produk
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge({
    required String text,
    required Color color,
    IconData? icon,
  }) {
    // Container digunakan untuk membuat tampilan badge informasi produk
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),

      // Row digunakan untuk menyusun ikon dan teks badge secara horizontal
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Kondisi ini digunakan untuk menampilkan ikon jika tersedia
          if (icon != null) ...[
            // Icon digunakan untuk memperjelas informasi pada badge
            Icon(
              icon,
              color: Colors.white,
              size: 10,
            ),

            // SizedBox digunakan untuk memberikan jarak antara ikon dan teks badge
            const SizedBox(width: 3),
          ],

          // Text digunakan untuk menampilkan tulisan pada badge
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRating({
    required double rating,
    int? ulasan,
    double size = 13,
  }) {
    // Row digunakan untuk menyusun bintang, nilai rating, dan jumlah ulasan
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Icon digunakan untuk menampilkan simbol rating berupa bintang
        Icon(
          Icons.star_rounded,
          color: const Color(0xFFFFB300),
          size: size,
        ),

        // SizedBox digunakan untuk memberikan jarak antara bintang dan nilai rating
        const SizedBox(width: 3),

        // Text digunakan untuk menampilkan nilai rating produk
        Text(
          rating.toStringAsFixed(1),
          style: TextStyle(
            fontSize: size - 1,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF3E2723),
          ),
        ),

        // Kondisi ini digunakan untuk menampilkan jumlah ulasan jika tersedia
        if (ulasan != null) ...[
          // SizedBox digunakan untuk memberikan jarak sebelum jumlah ulasan
          const SizedBox(width: 3),

          // Text digunakan untuk menampilkan jumlah ulasan produk
          Text(
            '($ulasan)',
            style: TextStyle(
              fontSize: size - 2,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }
}