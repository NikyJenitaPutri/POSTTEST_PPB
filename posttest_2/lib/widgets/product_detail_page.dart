import 'package:flutter/material.dart';

// ProductDetailPage digunakan untuk menampilkan detail dari satu produk
class ProductDetailPage extends StatelessWidget {
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

  // Menyimpan icon produk sebagai cadangan jika gambar tidak tampil
  final IconData icon;

  // Menyimpan lokasi gambar produk
  final String gambar;

  // Menentukan apakah produk memiliki label Bestseller
  final bool isBestSeller;

  // Constructor digunakan untuk menerima data produk
  const ProductDetailPage({
    super.key,
    required this.nama,
    required this.deskripsi,
    required this.harga,
    required this.rating,
    required this.ulasan,
    required this.icon,
    required this.gambar,
    required this.isBestSeller,
  });

  @override
  Widget build(BuildContext context) {
    // Scaffold digunakan sebagai struktur dasar halaman
    return Scaffold(
      // Mengatur warna background halaman menjadi putih
      backgroundColor: Colors.white,

      // ================= STACK UTAMA =================
      // Stack digunakan untuk menumpuk beberapa widget sehingga tombol kembali dan bar harga dapat berada di atas konten halaman
      body: Stack(
        children: [
          // ---------- Lapisan 1: konten yang bisa di-scroll ----------

          // SingleChildScrollView membuat seluruh isi detail produk dapat digulir ke atas dan ke bawah
          SingleChildScrollView(
            // Memberikan ruang tambahan di bagian bawah agar konten tidak tertutup bar harga
            padding: const EdgeInsets.only(bottom: 120),

            // Column menyusun isi detail produk dari atas ke bawah
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ---- Stack kedua: gambar + badge di atasnya ----

                // SizedBox digunakan untuk menentukan ukuran area gambar
                SizedBox(
                  width: double.infinity,
                  height: 320,

                  // Stack digunakan untuk menempatkan gambar dan badge Bestseller dalam satu area
                  child: Stack(
                    children: [
                      // Positioned.fill membuat widget memenuhi seluruh area Stack
                      Positioned.fill(
                        // Container digunakan sebagai tempat gambar produk
                        child: Container(
                          // BoxDecoration digunakan untuk mengatur warna background dan bentuk sudut gambar
                          decoration: const BoxDecoration(
                            color: Color(0x1A660000),

                            // Membuat sudut bawah gambar melengkung
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(28),
                            ),
                          ),

                          // Clip.antiAlias membuat gambar mengikuti bentuk sudut Container
                          clipBehavior: Clip.antiAlias,

                          // Image.asset digunakan untuk menampilkan gambar produk dari folder assets
                          child: Image.asset(
                            gambar,

                            // BoxFit.cover membuat gambar memenuhi area yang tersedia
                            fit: BoxFit.cover,

                            // errorBuilder digunakan sebagai tampilan pengganti jika gambar gagal dimuat
                            errorBuilder: (context, error, stackTrace) {
                              // Icon digunakan sebagai gambar pengganti
                              return Icon(
                                icon,
                                size: 90,
                                color: const Color(0xFF660000),
                              );
                            },
                          ),
                        ),
                      ),

                      // if digunakan untuk menampilkan badge hanya jika produk merupakan Bestseller
                      if (isBestSeller)

                        // Positioned digunakan untuk menentukan posisi badge di dalam Stack
                        Positioned(
                          // Jarak badge dari sisi kiri
                          left: 20,

                          // Jarak badge dari bagian bawah gambar
                          bottom: 20,

                          // Container digunakan sebagai background badge
                          child: Container(
                            // Memberikan jarak antara isi dan tepi badge
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),

                            // BoxDecoration digunakan untuk mengatur warna dan bentuk badge
                            decoration: BoxDecoration(
                              color: const Color(0xFF660000),
                              borderRadius: BorderRadius.circular(20),
                            ),

                            // Row menyusun icon dan teks Bestseller secara horizontal
                            child: const Row(
                              // Ukuran Row mengikuti isi di dalamnya
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Icon api digunakan sebagai tanda Bestseller
                                Icon(
                                  Icons.local_fire_department,
                                  color: Colors.white,
                                  size: 14,
                                ),

                                // SizedBox memberikan jarak antara icon dan teks
                                SizedBox(width: 4),

                                // Text menampilkan tulisan Bestseller
                                Text(
                                  'BESTSELLER',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.6,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // Padding memberikan jarak isi detail produk dari sisi layar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),

                  // Column menyusun informasi produk secara vertikal
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text digunakan untuk menampilkan nama produk
                      Text(
                        nama,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2B0000),
                        ),
                      ),

                      // SizedBox memberikan jarak antara nama dan rating
                      const SizedBox(height: 8),

                      // Row digunakan untuk menyusun icon rating, nilai rating, dan jumlah ulasan
                      Row(
                        children: [
                          // Icon digunakan untuk menampilkan simbol bintang rating
                          const Icon(
                            Icons.star_rounded,
                            color: Color(0xFF660000),
                            size: 18,
                          ),

                          // SizedBox memberikan jarak antara icon dan nilai rating
                          const SizedBox(width: 4),

                          // Text menampilkan nilai rating
                          Text(
                            rating.toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2B0000),
                            ),
                          ),

                          // SizedBox memberikan jarak
                          const SizedBox(width: 4),

                          // Text menampilkan jumlah ulasan
                          Text(
                            '($ulasan ulasan)',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF660000),
                            ),
                          ),
                        ],
                      ),

                      // SizedBox memberikan jarak sebelum harga produk
                      const SizedBox(height: 16),

                      // Text digunakan untuk menampilkan harga produk
                      Text(
                        harga,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF660000),
                        ),
                      ),

                      // SizedBox memberikan jarak sebelum bagian deskripsi
                      const SizedBox(height: 20),

                      // ---- Kartu deskripsi (BoxShadow) ----

                      // Container digunakan sebagai kartu untuk menampilkan deskripsi produk
                      Container(
                        // Lebar kartu mengikuti lebar layar
                        width: double.infinity,

                        // Memberikan jarak isi dari tepi kartu
                        padding: const EdgeInsets.all(16),

                        // BoxDecoration digunakan untuk mengatur warna, border, sudut, dan bayangan kartu
                        decoration: BoxDecoration(
                          // Background kartu berwarna putih
                          color: Colors.white,

                          // Membuat sudut kartu melengkung
                          borderRadius: BorderRadius.circular(16),

                          // Memberikan garis tepi pada kartu
                          border: Border.all(
                            color: const Color(0x33660000),
                          ),

                          // Memberikan efek bayangan pada kartu
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x1A660000),
                              blurRadius: 10,
                              offset: Offset(0, -3),
                            ),
                          ],
                        ),

                        // Column menyusun judul dan deskripsi secara vertikal
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text digunakan untuk judul bagian deskripsi
                            const Text(
                              'Deskripsi',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2B0000),
                              ),
                            ),

                            // SizedBox memberikan jarak antara judul dan isi deskripsi
                            const SizedBox(height: 8),

                            // Text menampilkan deskripsi produk
                            Text(
                              deskripsi,
                              style: const TextStyle(
                                fontSize: 14,
                                height: 1.5,
                                color: Color(0xFF660000),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ---------- Lapisan 2: tombol kembali ----------

          // SafeArea digunakan agar tombol kembali tidak tertutup oleh status bar / notch, sebagai pengganti MediaQuery
          SafeArea(
            // minimum memberikan jarak tambahan dari tepi SafeArea
            minimum: const EdgeInsets.only(top: 8, left: 16),

            // Align digunakan agar isi SafeArea hanya menempati pojok kiri atas
            child: Align(
              alignment: Alignment.topLeft,

              // GestureDetector digunakan agar Container dapat menerima aksi ketika ditekan
              child: GestureDetector(
                // onTap dijalankan ketika tombol ditekan
                onTap: () => Navigator.pop(context),

                // Navigator.pop digunakan untuk kembali ke halaman sebelumnya
                child: Container(
                  // Lebar tombol kembali
                  width: 42,

                  // Tinggi tombol kembali
                  height: 42,

                  // BoxDecoration digunakan untuk membuat tombol berbentuk lingkaran dan memberikan bayangan
                  decoration: const BoxDecoration(
                    // Warna background tombol
                    color: Colors.white,

                    // Membuat Container berbentuk lingkaran
                    shape: BoxShape.circle,

                    // Memberikan bayangan pada tombol
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x40660000),
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),

                  // Icon menampilkan tanda panah kembali
                  child: const Icon(
                    Icons.arrow_back,
                    color: Color(0xFF660000),
                    size: 22,
                  ),
                ),
              ),
            ),
          ),

          // ---------- Lapisan 3: bar harga di bawah ----------

          // Positioned digunakan untuk menempelkan bar harga di bagian bawah layar
          Positioned(
            // Menempelkan bar ke sisi kiri layar
            left: 0,

            // Menempelkan bar ke sisi kanan layar
            right: 0,

            // Menempelkan bar ke bagian bawah layar
            bottom: 0,

            // SafeArea digunakan agar bar harga tidak tertutup
            child: SafeArea(
              // top: false berarti bagian atas tidak diberi jarak aman, hanya bagian bawah saja
              top: false,

              // Container digunakan sebagai bar harga
              child: Container(
                // Memberikan jarak isi bar dari tepi
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),

                // BoxDecoration digunakan untuk mengatur warna, sudut, dan bayangan bar
                decoration: const BoxDecoration(
                  // Background bar berwarna putih
                  color: Colors.white,

                  // Membuat sudut bagian atas melengkung
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),

                  // Memberikan bayangan pada bagian atas bar
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x26660000),
                      blurRadius: 10,
                      offset: Offset(0, -3),
                    ),
                  ],
                ),

                // Row menyusun harga dan tombol secara horizontal
                child: Row(
                  children: [
                    // Column digunakan untuk menampilkan tulisan Harga dan nilai harga
                    Column(
                      // Ukuran Column mengikuti isi
                      mainAxisSize: MainAxisSize.min,

                      // Isi Column dimulai dari kiri
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text menampilkan label Harga
                        const Text(
                          'Harga',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF660000),
                          ),
                        ),

                        // Text menampilkan harga produk
                        Text(
                          harga,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2B0000),
                          ),
                        ),
                      ],
                    ),

                    // SizedBox memberikan jarak antara harga dan tombol keranjang
                    const SizedBox(width: 20),

                    // Expanded membuat tombol menggunakan sisa ruang yang tersedia
                    Expanded(
                      // ElevatedButton.icon digunakan untuk membuat tombol dengan icon dan teks
                      child: ElevatedButton.icon(
                        // styleFrom digunakan untuk mengatur tampilan tombol
                        style: ElevatedButton.styleFrom(
                          // Warna background tombol
                          backgroundColor: const Color(0xFF660000),

                          // Warna teks dan icon tombol
                          foregroundColor: Colors.white,

                          // Memberikan jarak atas dan bawah tombol
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),

                          // Membuat sudut tombol melengkung
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),

                        // onPressed menentukan aksi ketika tombol ditekan
                        onPressed: () {},

                        // Icon shopping bag pada tombol
                        icon: const Icon(
                          Icons.shopping_bag,
                          size: 18,
                        ),

                        // Text menampilkan tulisan pada tombol
                        label: const Text(
                          'Tambah ke Keranjang',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}