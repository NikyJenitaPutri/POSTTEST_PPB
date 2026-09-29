import 'package:flutter/material.dart';
// Import Material digunakan untuk menggunakan widget Flutter
// seperti Container, Row, Column, Text, Icon, GestureDetector, dan lainnya

import 'product_detail_page.dart';
// Import ProductDetailPage digunakan untuk membuka halaman detail produk

// ProductCard digunakan untuk menampilkan informasi satu produk
class ProductCard extends StatelessWidget {
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

  // Menyimpan lokasi gambar produk
  final String gambar;

  // Menentukan apakah produk merupakan Best Seller
  final bool isBestSeller;

  // Menyimpan fungsi yang dijalankan ketika ProductCard ditekan
  final VoidCallback? onTap;

  // Constructor untuk menerima data produk
  const ProductCard({
    super.key,
    required this.nama,
    required this.deskripsi,
    required this.harga,
    required this.rating,
    required this.ulasan,
    required this.icon,
    required this.gambar,
    required this.isBestSeller,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // GestureDetector digunakan agar seluruh ProductCard
    // dapat menerima sentuhan atau ketukan
    return GestureDetector(
      // Jika onTap diberikan dari luar, gunakan fungsi tersebut.
      // Jika tidak diberikan, buka halaman detail produk
      // menggunakan Navigator.push
      onTap: onTap ??
          () {
            // Navigator.push digunakan untuk berpindah
            // dari ProductCard ke halaman detail produk
            Navigator.push(
              context,

              // MaterialPageRoute digunakan untuk menentukan
              // halaman yang akan dibuka
              MaterialPageRoute(
                // ProductDetailPage menerima data dari ProductCard
                builder: (context) => ProductDetailPage(
                  // Mengirim nama produk
                  nama: nama,

                  // Mengirim deskripsi produk
                  deskripsi: deskripsi,

                  // Mengirim harga produk
                  harga: harga,

                  // Mengirim rating produk
                  rating: rating,

                  // Mengirim jumlah ulasan
                  ulasan: ulasan,

                  // Mengirim icon produk
                  icon: icon,

                  // Mengirim lokasi gambar produk
                  gambar: gambar,

                  // Mengirim status Best Seller
                  isBestSeller: isBestSeller,
                ),
              ),
            );
          },

      // Container digunakan sebagai kotak utama ProductCard
      child: Container(
        // Lebar ProductCard mengikuti ruang yang tersedia
        width: double.infinity,

        // Memberikan jarak isi dari tepi ProductCard
        padding: const EdgeInsets.all(14),

        // BoxDecoration digunakan untuk mengatur
        // warna, border, sudut, dan bayangan ProductCard
        decoration: BoxDecoration(
          // Warna background ProductCard
          color: Colors.white,

          // Membuat sudut ProductCard melengkung
          borderRadius: BorderRadius.circular(16),

          // Memberikan garis tepi ProductCard
          border: Border.all(
            color: const Color(0x33660000),
            width: 1,
          ),

          // Memberikan efek bayangan pada ProductCard
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A660000),
              blurRadius: 10,
              offset: Offset(0, -3),
            ),
          ],
        ),

        // Row digunakan untuk menyusun gambar dan
        // informasi produk secara horizontal
        child: Row(
          // Menempatkan isi Row di tengah secara vertikal
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            // Container digunakan sebagai tempat gambar produk
            Container(
              // Lebar area gambar
              width: 95,

              // Tinggi area gambar
              height: 95,

              // BoxDecoration digunakan untuk membuat
              // background dan sudut gambar
              decoration: BoxDecoration(
                // Warna background area gambar
                color: Colors.white,

                // Membuat sudut gambar melengkung
                borderRadius: BorderRadius.circular(12),
              ),

              // Membuat gambar mengikuti bentuk sudut Container
              clipBehavior: Clip.antiAlias,

              // Image.asset digunakan untuk menampilkan
              // gambar produk dari folder assets
              child: Image.asset(
                // Lokasi gambar produk
                gambar,

                // Menentukan lebar gambar
                width: 95,

                // Menentukan tinggi gambar
                height: 95,

                // Membuat gambar memenuhi area yang tersedia
                fit: BoxFit.cover,

                // errorBuilder digunakan jika gambar
                // tidak berhasil dimuat
                errorBuilder: (context, error, stackTrace) {
                  // Menampilkan icon sebagai pengganti gambar
                  return Icon(
                    icon,
                    size: 42,
                    color: const Color(0xFF660000),
                  );
                },
              ),
            ),

            // SizedBox memberikan jarak antara gambar
            // dan informasi produk
            const SizedBox(width: 14),

            // Expanded membuat informasi produk menggunakan
            // sisa ruang yang tersedia
            Expanded(
              // Column menyusun informasi produk
              // dari atas ke bawah
              child: Column(
                // Isi Column dimulai dari sisi kiri
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  // Row digunakan untuk menyusun nama produk
                  // dan badge Bestseller secara horizontal
                  Row(
                    children: [
                      // Expanded membuat nama produk menggunakan
                      // ruang yang tersedia
                      Expanded(
                        // Text digunakan untuk menampilkan nama produk
                        child: Text(
                          nama,

                          // Mengatur tampilan nama produk
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2B0000),
                          ),

                          // Nama produk maksimal satu baris
                          maxLines: 1,

                          // Jika nama terlalu panjang,
                          // akan diganti dengan tanda ...
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      // if digunakan untuk menampilkan badge
                      // hanya jika produk merupakan Bestseller
                      if (isBestSeller) ...[
                        // Memberikan jarak antara nama dan badge
                        const SizedBox(width: 6),

                        // Membuat badge Bestseller
                        _buildBadge(
                          // Tulisan pada badge
                          text: 'BESTSELLER',

                          // Warna background badge
                          color: const Color(0xFF660000),

                          // Icon yang digunakan pada badge
                          icon: Icons.local_fire_department,
                        ),
                      ],
                    ],
                  ),

                  // SizedBox memberikan jarak setelah nama produk
                  const SizedBox(height: 4),

                  // Text digunakan untuk menampilkan deskripsi produk
                  Text(
                    deskripsi,

                    // Mengatur tampilan deskripsi
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF660000),
                    ),

                    // Deskripsi maksimal dua baris
                    maxLines: 2,

                    // Jika deskripsi terlalu panjang,
                    // akan dipotong dengan tanda ...
                    overflow: TextOverflow.ellipsis,
                  ),

                  // SizedBox memberikan jarak
                  const SizedBox(height: 6),

                  // Memanggil widget rating untuk menampilkan
                  // bintang, nilai rating, dan jumlah ulasan
                  _buildRating(
                    rating: rating,
                    ulasan: ulasan,
                  ),

                  // SizedBox memberikan jarak sebelum harga
                  const SizedBox(height: 8),

                  // Row digunakan untuk menyusun harga
                  // dan tombol tambah secara horizontal
                  Row(
                    // Harga berada di kiri dan tombol + di kanan
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      // Text digunakan untuk menampilkan harga produk
                      Text(
                        harga,

                        // Mengatur tampilan harga
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF660000),
                        ),
                      ),

                      // Tombol + (belum berfungsi).
                      // GestureDetector digunakan untuk menangkap
                      // ketukan agar tidak ikut membuka halaman detail
                      GestureDetector(
                        // onTap masih kosong karena tombol
                        // belum memiliki fungsi
                        onTap: () {},

                        // Container digunakan sebagai background
                        // tombol tambah
                        child: Container(
                          // Lebar tombol
                          width: 32,

                          // Tinggi tombol
                          height: 32,

                          // BoxDecoration digunakan untuk mengatur
                          // warna dan bentuk tombol
                          decoration: BoxDecoration(
                            // Warna tombol
                            color: const Color(0xFF660000),

                            // Membuat sudut tombol melengkung
                            borderRadius: BorderRadius.circular(9),
                          ),

                          // Icon digunakan untuk menampilkan tanda +
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= WIDGET BADGE =================

  // Fungsi ini digunakan untuk membuat badge
  // seperti tulisan BESTSELLER
  Widget _buildBadge({
    // Tulisan yang akan ditampilkan pada badge
    required String text,

    // Warna background badge
    required Color color,

    // Icon pada badge bersifat opsional
    IconData? icon,
  }) {
    // Container digunakan sebagai kotak badge
    return Container(
      // Memberikan jarak antara isi dan tepi badge
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 3,
      ),

      // BoxDecoration digunakan untuk mengatur
      // warna dan bentuk badge
      decoration: BoxDecoration(
        // Warna background badge
        color: color,

        // Membuat badge berbentuk lonjong
        borderRadius: BorderRadius.circular(20),
      ),

      // Row menyusun icon dan teks secara horizontal
      child: Row(
        // Ukuran Row mengikuti isi di dalamnya
        mainAxisSize: MainAxisSize.min,

        children: [
          // if digunakan untuk menampilkan icon
          // hanya jika icon tidak bernilai null
          if (icon != null) ...[
            // Icon yang ditampilkan pada badge
            Icon(
              icon,
              color: Colors.white,
              size: 10,
            ),

            // Jarak antara icon dan teks
            const SizedBox(width: 3),
          ],

          // Text digunakan untuk menampilkan tulisan badge
          Text(
            text,

            // Mengatur tampilan tulisan badge
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

  // ================= WIDGET RATING =================

  // Fungsi ini digunakan untuk membuat tampilan rating produk
  Widget _buildRating({
    // Nilai rating produk
    required double rating,

    // Jumlah ulasan bersifat opsional
    int? ulasan,

    // Ukuran icon dan teks rating
    double size = 13,
  }) {
    // Row digunakan untuk menyusun
    // icon bintang, rating, dan jumlah ulasan
    return Row(
      // Ukuran Row mengikuti isi yang ada
      mainAxisSize: MainAxisSize.min,

      children: [
        // Icon bintang digunakan untuk menunjukkan rating
        Icon(
          Icons.star_rounded,
          color: const Color(0xFF660000),
          size: size,
        ),

        // Jarak antara bintang dan nilai rating
        const SizedBox(width: 3),

        // Text digunakan untuk menampilkan nilai rating
        Text(
          // Membatasi rating menjadi satu angka di belakang koma
          rating.toStringAsFixed(1),

          // Mengatur tampilan nilai rating
          style: TextStyle(
            // Ukuran teks mengikuti ukuran icon
            fontSize: size - 1,

            // Membuat nilai rating lebih tebal
            fontWeight: FontWeight.w700,

            // Warna teks rating
            color: const Color(0xFF2B0000),
          ),
        ),

        // Jika jumlah ulasan tersedia,
        // tampilkan jumlah ulasan
        if (ulasan != null) ...[
          // Jarak antara rating dan jumlah ulasan
          const SizedBox(width: 3),

          // Text digunakan untuk menampilkan jumlah ulasan
          Text(
            '($ulasan)',

            // Mengatur tampilan jumlah ulasan
            style: TextStyle(
              // Ukuran teks sedikit lebih kecil dari rating
              fontSize: size - 2,

              // Warna teks ulasan
              color: const Color(0xFF660000),

              // Ketebalan teks ulasan
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }
}