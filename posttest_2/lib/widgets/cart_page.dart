import 'package:flutter/material.dart';

// services.dart digunakan untuk mengakses TextInputFormatter
// seperti FilteringTextInputFormatter dan LengthLimitingTextInputFormatter
import 'package:flutter/services.dart';

// StatelessWidget digunakan karena halaman keranjang ini tidak memiliki state yang berubah secara langsung
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  // List digunakan untuk menyimpan data barang yang ada di keranjang
  // Map digunakan untuk menyimpan data setiap produk seperti nama, harga, jumlah, dan gambar
  static const List<Map<String, dynamic>> _items = [
    {
      'nama': 'Cappuccino',
      'harga': 'Rp18.000',
      'jumlah': 1,
      'icon': Icons.coffee,
      'gambar': 'assets/images/Cappucino.png',
    },
    {
      'nama': 'Caffe Latte',
      'harga': 'Rp20.000',
      'jumlah': 2,
      'icon': Icons.coffee_maker,
      'gambar': 'assets/images/CoffeLatte.png',
    },
    {
      'nama': 'Croissant',
      'harga': 'Rp15.000',
      'jumlah': 1,
      'icon': Icons.bakery_dining,
      'gambar': 'assets/images/Croissant.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Scaffold digunakan sebagai struktur dasar halaman yang menyediakan area body
    return Scaffold(
      // Mengatur warna background halaman menjadi putih
      backgroundColor: Colors.white,

      // SafeArea digunakan agar isi halaman tidak tertutup oleh status bar atau bagian layar lainnya
      body: SafeArea(
        // Column digunakan untuk menyusun widget secara vertikal
        child: Column(
          children: [
            // Expanded membuat bagian daftar keranjang memenuhi ruang yang tersedia
            Expanded(
              // SingleChildScrollView membuat isi halaman dapat digulir jika kontennya terlalu panjang
              child: SingleChildScrollView(
                // Padding memberikan jarak isi dari tepi layar
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),

                // Column menyusun isi keranjang dari atas ke bawah
                child: Column(
                  // Membuat isi Column rata kiri
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    // ================= HEADER =================

                    // Row digunakan untuk menampilkan ikon dan judul halaman di bagian atas
                    Row(
                      children: [
                        // Icon menampilkan ikon tas belanja pada header
                        const Icon(
                          Icons.shopping_bag,
                          color: Color(0xFF660000),
                          size: 24,
                        ),

                        // SizedBox memberikan jarak antara ikon dan judul
                        const SizedBox(width: 12),

                        // Expanded membuat judul menggunakan sisa ruang yang tersedia
                        const Expanded(
                          // Text menampilkan judul halaman
                          child: Text(
                            'Keranjang',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2B0000),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // SizedBox memberikan jarak setelah header
                    const SizedBox(height: 20),

                    // Text digunakan untuk menampilkan judul bagian
                    const Text(
                      'Pesananmu',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2B0000),
                      ),
                    ),

                    // SizedBox digunakan untuk memberikan jarak vertikal
                    const SizedBox(height: 4),

                    // Text menampilkan jumlah jenis item yang ada di keranjang
                    Text(
                      '${_items.length} item dalam keranjang',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF660000),
                      ),
                    ),

                    // SizedBox memberikan jarak sebelum daftar produk
                    const SizedBox(height: 16),

                    // List.generate digunakan untuk membuat widget berdasarkan jumlah data yang terdapat pada _items
                    ...List.generate(_items.length, (index) {
                      // Memanggil fungsi untuk membuat tampilan setiap item yang ada di keranjang
                      return _buildItemKeranjang(_items[index]);
                    }),

                    // Memberikan jarak sebelum bagian ringkasan
                    const SizedBox(height: 10),

                    // Text digunakan untuk menampilkan judul ringkasan pesanan
                    const Text(
                      'Ringkasan Pesanan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2B0000),
                      ),
                    ),

                    // Memberikan jarak antara judul dan container ringkasan
                    const SizedBox(height: 12),

                    // Container digunakan sebagai kotak pembungkus ringkasan
                    Container(
                      // Membuat Container memenuhi lebar yang tersedia
                      width: double.infinity,

                      // Padding memberikan jarak antara isi dengan batas Container
                      padding: const EdgeInsets.all(16),

                      // BoxDecoration digunakan untuk mengatur background, border, sudut, dan bayangan Container
                      decoration: BoxDecoration(
                        // Warna background Container
                        color: Colors.white,

                        // Membuat sudut Container melengkung
                        borderRadius: BorderRadius.circular(16),

                        // Memberikan garis tepi pada Container
                        border: Border.all(
                          color: const Color(0x33660000),
                        ),

                        // BoxShadow memberikan efek bayangan
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x1A660000),
                            blurRadius: 10,
                            offset: Offset(0, -3),
                          ),
                        ],
                      ),

                      // Column menyusun baris ringkasan secara vertikal
                      child: Column(
                        children: [
                          // Menampilkan baris subtotal
                          _buildBarisRingkasan(
                            'Subtotal',
                            'Rp73.000',
                          ),

                          // Memberikan jarak antar baris
                          const SizedBox(height: 8),

                          // Menampilkan biaya layanan
                          _buildBarisRingkasan(
                            'Biaya layanan',
                            'Rp2.000',
                          ),

                          // Memberikan jarak sebelum garis pembatas
                          const SizedBox(height: 12),

                          // Divider digunakan sebagai garis pemisah
                          const Divider(
                            color: Color(0x33660000),
                            height: 1,
                          ),

                          // Memberikan jarak sebelum total
                          const SizedBox(height: 12),

                          // Menampilkan total pembayaran dengan teks tebal
                          _buildBarisRingkasan(
                            'Total',
                            'Rp75.000',
                            tebal: true,
                          ),
                        ],
                      ),
                    ),

                    // Memberikan jarak di bagian bawah daftar
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Container digunakan untuk membuat area tombol Checkout
            Container(
              // Memberikan jarak antara tombol dengan batas Container
              padding: const EdgeInsets.all(20),

              // BoxDecoration digunakan untuk memberikan warna, sudut, dan bayangan pada area tombol
              decoration: const BoxDecoration(
                color: Colors.white,

                // Membuat bagian atas Container melengkung
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),

                // BoxShadow memberikan bayangan pada bagian atas Container
                boxShadow: [
                  BoxShadow(
                    color: Color(0x26660000),
                    blurRadius: 10,
                    offset: Offset(0, -3),
                  ),
                ],
              ),

              // SizedBox digunakan untuk membuat tombol memenuhi lebar yang tersedia
              child: SizedBox(
                width: double.infinity,

                // ElevatedButton.icon digunakan untuk membuat tombol Checkout yang memiliki ikon dan teks
                child: ElevatedButton.icon(
                  // styleFrom digunakan untuk mengatur tampilan tombol
                  style: ElevatedButton.styleFrom(
                    // Mengatur warna background tombol
                    backgroundColor: const Color(0xFF660000),

                    // Mengatur warna teks dan ikon tombol
                    foregroundColor: Colors.white,

                    // Memberikan jarak vertikal pada isi tombol
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ),

                    // RoundedRectangleBorder membuat sudut tombol melengkung
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),

                  // onPressed dijalankan ketika tombol Checkout ditekan
                  onPressed: () {},

                  // Icon digunakan untuk menampilkan ikon pada tombol
                  icon: const Icon(
                    Icons.shopping_bag,
                    size: 18,
                  ),

                  // Text digunakan untuk menampilkan tulisan Checkout
                  label: const Text(
                    'Checkout',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi ini digunakan untuk membuat tampilan satu item keranjang
  Widget _buildItemKeranjang(Map<String, dynamic> item) {
    // Container digunakan sebagai kotak pembungkus setiap produk
    return Container(
      // width double.infinity membuat kotak memenuhi lebar yang tersedia
      width: double.infinity,

      // margin memberikan jarak antar item
      margin: const EdgeInsets.only(bottom: 14),

      // padding memberikan jarak isi dengan batas Container
      padding: const EdgeInsets.all(14),

      // BoxDecoration digunakan untuk mengatur background, border, sudut, dan bayangan
      decoration: BoxDecoration(
        // Warna background item
        color: Colors.white,

        // Membuat sudut item melengkung
        borderRadius: BorderRadius.circular(16),

        // Memberikan garis tepi
        border: Border.all(
          color: const Color(0x33660000),
          width: 1,
        ),

        // BoxShadow memberikan efek bayangan
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A660000),
            blurRadius: 10,
            offset: Offset(0, -3),
          ),
        ],
      ),

      // Row digunakan untuk menyusun gambar, informasi produk, dan tombol hapus secara horizontal
      child: Row(
        // Membuat isi Row berada di bagian atas
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          // Container digunakan sebagai tempat gambar produk
          Container(
            width: 56,
            height: 56,

            // BoxDecoration digunakan untuk memberikan background dan sudut pada area gambar
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),

            // Clip.antiAlias digunakan agar gambar mengikuti bentuk sudut Container
            clipBehavior: Clip.antiAlias,

            // Image.asset digunakan untuk mengambil gambar dari folder assets aplikasi
            child: Image.asset(
              item['gambar'],
              width: 56,
              height: 56,

              // BoxFit.cover membuat gambar memenuhi area
              fit: BoxFit.cover,

              // errorBuilder digunakan jika gambar tidak ditemukan
              errorBuilder: (context, error, stackTrace) {
                // Icon menjadi gambar pengganti jika asset gagal dimuat
                return Icon(
                  item['icon'],
                  color: const Color(0xFF660000),
                  size: 26,
                );
              },
            ),
          ),

          // SizedBox memberikan jarak antara gambar dan informasi produk
          const SizedBox(width: 14),

          // Expanded membuat informasi produk menggunakan ruang yang tersisa
          Expanded(
            // Column menyusun informasi produk secara vertikal
            child: Column(
              // Membuat isi Column rata kiri
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                // Text menampilkan nama produk
                Text(
                  item['nama'],
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2B0000),
                  ),
                ),

                // Memberikan jarak setelah nama produk
                const SizedBox(height: 4),

                // Text menampilkan harga produk
                Text(
                  item['harga'],
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF660000),
                  ),
                ),

                // Memberikan jarak sebelum kontrol jumlah
                const SizedBox(height: 10),

                // Row digunakan untuk menyusun tombol minus, kolom input jumlah, dan tombol plus secara horizontal
                Row(
                  children: [
                    // Container digunakan sebagai tombol minus
                    Container(
                      width: 28,
                      height: 28,

                      // BoxDecoration memberikan border dan sudut tombol
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0x33660000),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),

                      // Icon menampilkan simbol minus
                      child: const Icon(
                        Icons.remove,
                        size: 16,
                        color: Color(0xFF660000),
                      ),
                    ),

                    // Memberikan jarak antara tombol minus dan kolom jumlah
                    const SizedBox(width: 8),

                    // SizedBox menentukan ukuran kolom input jumlah
                    SizedBox(
                      width: 44,
                      height: 32,

                      // TextField digunakan agar pengguna bisa mengetik jumlah produk
                      child: TextField(
                        // controller menyimpan nilai awal jumlah produk
                        controller: TextEditingController(
                          text: '${item['jumlah']}',
                        ),

                        // keyboardType menampilkan keyboard angka
                        keyboardType: TextInputType.number,

                        // inputFormatters membatasi input hanya angka dan maksimal 2 digit
                        inputFormatters: [
                          // digitsOnly menolak karakter selain angka
                          FilteringTextInputFormatter.digitsOnly,

                          // LengthLimitingTextInputFormatter membatasi panjang input
                          LengthLimitingTextInputFormatter(2),
                        ],

                        // textAlign membuat angka berada di tengah
                        textAlign: TextAlign.center,

                        // style mengatur tampilan angka yang diketik
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2B0000),
                        ),

                        // InputDecoration mengatur tampilan kolom input
                        decoration: InputDecoration(
                          // contentPadding dibuat nol agar angka pas di dalam kotak kecil
                          contentPadding: EdgeInsets.zero,

                          // border ketika kolom tidak dipilih
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0x33660000),
                            ),
                          ),

                          // border ketika kolom sedang digunakan
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFF660000),
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Memberikan jarak antara kolom jumlah dan tombol plus
                    const SizedBox(width: 8),

                    // Container digunakan sebagai tombol tambah
                    Container(
                      width: 28,
                      height: 28,

                      // BoxDecoration memberikan warna dan sudut tombol
                      decoration: BoxDecoration(
                        color: const Color(0xFF660000),
                        borderRadius: BorderRadius.circular(8),
                      ),

                      // Icon menampilkan simbol tambah
                      child: const Icon(
                        Icons.add,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // IconButton digunakan untuk membuat tombol hapus produk
          const IconButton(
            // onPressed null membuat tombol tidak aktif
            onPressed: null,

            // Icon menampilkan ikon tempat sampah
            icon: Icon(
              Icons.delete_outline,
              color: Color(0xFF660000),
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi ini digunakan untuk membuat satu baris pada ringkasan pesanan
  Widget _buildBarisRingkasan(
    String label,
    String nilai, {
    bool tebal = false,
  }) {
    // Row digunakan untuk menempatkan label di kiri dan nilai harga di kanan
    return Row(
      // Membuat kedua bagian berada di sisi yang berlawanan
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        // Text digunakan untuk menampilkan nama ringkasan seperti Subtotal, Biaya layanan, dan Total
        Text(
          label,
          style: TextStyle(
            // Ukuran teks berubah jika tebal bernilai true
            fontSize: tebal ? 15 : 13,

            // FontWeight mengatur ketebalan tulisan
            fontWeight: tebal ? FontWeight.bold : FontWeight.normal,

            color: const Color(0xFF2B0000),
          ),
        ),

        // Text digunakan untuk menampilkan nilai harga
        Text(
          nilai,
          style: TextStyle(
            // Ukuran teks total dibuat lebih besar
            fontSize: tebal ? 16 : 13,

            // Membuat total lebih tebal
            fontWeight: tebal ? FontWeight.bold : FontWeight.w600,

            // Warna total dibuat lebih menonjol
            color: tebal ? const Color(0xFF660000) : const Color(0xFF2B0000),
          ),
        ),
      ],
    );
  }
}