import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'product_card.dart';
import 'cart_page.dart';
import '../providers/cart_provider.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  // State: _searchQuery menyimpan kata kunci pencarian yang sedang aktif
  String _searchQuery = '';
  // State: _searchController mengontrol input teks pada TextField pencarian
  final TextEditingController _searchController = TextEditingController();

  // dispose: membersihkan resource controller saat widget dihancurkan
  @override
  void dispose() {
    _searchController.dispose(); // Membebaskan memori controller
    super.dispose();
  }

 
  // filter HANYA berdasarkan kata kunci pencarian
  // Produk habis tetap tampil dengan label "HABIS" dari ProductCard
 
  // _filter: menyaring daftar produk berdasarkan _searchQuery
  List<_DataProduk> _filter(List<_DataProduk> produk, CartProvider cart) {
    return produk.where((p) {
      // cocok: true jika pencarian kosong atau nama produk mengandung kata kunci
      final cocok = _searchQuery.isEmpty ||
          p.nama.toLowerCase().contains(_searchQuery.toLowerCase());
      return cocok;
    }).toList();
  }

  // _bukaKeranjang: navigasi ke halaman CartPage
  void _bukaKeranjang() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CartPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // context.watch: mengambil CartProvider dan mendengarkan perubahannya
    final cart = context.watch<CartProvider>();

    // ---------- DATA PRODUK STATIS ----------
    // coffeeList: daftar produk kategori Coffee
    const coffeeList = [
      _DataProduk(
        nama: 'Cappuccino',
        deskripsi: 'Espresso dengan busa susu lembut',
        harga: 'Rp18.000',
        rating: 4.9,
        ulasan: 245,
        icon: Icons.coffee,
        gambar: 'assets/images/Cappucino.png',
        isBestSeller: true,
        stokAwal: 15,
      ),
      _DataProduk(
        nama: 'Caffe Latte',
        deskripsi: 'Espresso dengan susu steamed',
        harga: 'Rp20.000',
        rating: 4.8,
        ulasan: 180,
        icon: Icons.coffee_maker,
        gambar: 'assets/images/CoffeLatte.png',
        isBestSeller: true,
        stokAwal: 8,
      ),
      _DataProduk(
        nama: 'Espresso',
        deskripsi: 'Kopi murni pekat khas Italia',
        harga: 'Rp15.000',
        rating: 4.7,
        ulasan: 120,
        icon: Icons.emoji_food_beverage,
        gambar: 'assets/images/Espresso.png',
        isBestSeller: false,
        stokAwal: 20,
      ),
    ];

    // nonCoffeeList: daftar produk kategori Non-Coffee
    const nonCoffeeList = [
      _DataProduk(
        nama: 'Matcha Latte',
        deskripsi: 'Matcha premium dengan susu segar',
        harga: 'Rp20.000',
        rating: 4.8,
        ulasan: 150,
        icon: Icons.emoji_food_beverage,
        gambar: 'assets/images/MatchaLatte.png',
        isBestSeller: true,
        stokAwal: 12,
      ),
      _DataProduk(
        nama: 'Chocolate',
        deskripsi: 'Cokelat manis dengan whipped cream',
        harga: 'Rp18.000',
        rating: 4.7,
        ulasan: 130,
        icon: Icons.local_drink,
        gambar: 'assets/images/Chocolate.png',
        isBestSeller: false,
        stokAwal: 10,
      ),
    ];

    // snackList: daftar produk kategori Snack
    const snackList = [
      _DataProduk(
        nama: 'Croissant',
        deskripsi: 'Pastry butter yang renyah di luar',
        harga: 'Rp15.000',
        rating: 4.8,
        ulasan: 90,
        icon: Icons.bakery_dining,
        gambar: 'assets/images/Croissant.png',
        isBestSeller: false,
        stokAwal: 6,
      ),
      _DataProduk(
        nama: 'French Fries',
        deskripsi: 'Kentang goreng gurih dan hangat',
        harga: 'Rp13.000',
        rating: 4.6,
        ulasan: 75,
        icon: Icons.lunch_dining,
        gambar: 'assets/images/FrenchFries.png',
        isBestSeller: false,
        stokAwal: 9,
      ),
    ];

    // ---------- DERIVED STATE ----------
    // filteredCoffee: hasil filter kategori Coffee berdasarkan pencarian
    final filteredCoffee = _filter(coffeeList, cart);
    // filteredNonCoffee: hasil filter kategori Non-Coffee berdasarkan pencarian
    final filteredNonCoffee = _filter(nonCoffeeList, cart);
    // filteredSnack: hasil filter kategori Snack berdasarkan pencarian
    final filteredSnack = _filter(snackList, cart);
    // total: jumlah total produk yang lolos filter
    final total = filteredCoffee.length +
        filteredNonCoffee.length +
        filteredSnack.length;

    // ---------- UI ----------
    // Scaffold: kerangka halaman dengan background dan body
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6F0), // Warna latar halaman
      // SafeArea: menghindari notch dan status bar
      body: SafeArea(
        // SingleChildScrollView: memungkinkan halaman discroll
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16), // Padding halaman
          // Column: menyusun anak secara vertikal
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Anak rata kiri
            children: [

              // HEADER
              // Row: menyusun anak secara horizontal
              Row(
                children: [
                  // Kondisi: jika bisa pop, tampilkan tombol back
                  if (Navigator.canPop(context))
                    // GestureDetector: mendeteksi tap pada tombol back
                    GestureDetector(
                      onTap: () => Navigator.pop(context), // Kembali ke halaman sebelumnya
                      // Container: tombol bulat putih dengan bayangan
                      child: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF6B1F1F)
                                  .withValues(alpha: 0.08),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        // Icon: ikon panah kembali
                        child: const Icon(Icons.arrow_back_rounded,
                            color: Color(0xFF6B1F1F), size: 22),
                      ),
                    )
                  else
                    // Container: logo aplikasi jika tidak bisa pop
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF6B1F1F)
                                .withValues(alpha: 0.25),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      clipBehavior: Clip.antiAlias, // Memotong gambar
                      // Image.asset: menampilkan logo dari assets
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 42,
                        height: 42,
                        fit: BoxFit.cover,
                        // errorBuilder: fallback jika gambar gagal
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
                            child: const Icon(Icons.menu_book_rounded,
                                color: Colors.white, size: 22),
                          );
                        },
                      ),
                    ),
                  const SizedBox(width: 12), // Jarak horizontal 12
                  // Expanded: judul dan subjudul mengisi ruang sisa
                  const Expanded(
                    // Column: menyusun judul dan subjudul secara vertikal
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text: judul "Menu"
                        Text(
                          'Menu',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF2B0000),
                            letterSpacing: -0.5,
                          ),
                        ),
                        // Text: subjudul "Pilih favoritmu"
                        Text(
                          'Pilih favoritmu',
                          style: TextStyle(
                              fontSize: 11, color: Color(0xFFB8A8A0)),
                        ),
                      ],
                    ),
                  ),
                  // GestureDetector: tombol keranjang dengan badge
                  GestureDetector(
                    onTap: _bukaKeranjang, // Buka halaman keranjang
                    // Stack: menumpuk ikon keranjang dan badge jumlah item
                    child: Stack(
                      clipBehavior: Clip.none, // Badge bisa keluar dari Stack
                      children: [
                        // Container: tombol keranjang
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF6B1F1F)
                                    .withValues(alpha: 0.08),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          // Icon: ikon keranjang
                          child: const Icon(Icons.shopping_bag_rounded,
                              color: Color(0xFF6B1F1F), size: 22),
                        ),
                        // Jika ada item di keranjang, tampilkan badge
                        if (cart.totalItems > 0)
                          // Positioned: mengatur posisi badge
                          Positioned(
                            right: -4,
                            top: -4,
                            // Container: badge jumlah item
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              constraints: const BoxConstraints(
                                  minWidth: 18, minHeight: 18),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF6B1F1F),
                                    Color(0xFFB5474A)
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.white, width: 2),
                              ),
                              // Text: jumlah total item
                              child: Text(
                                '${cart.totalItems}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20), // Jarak vertikal 20

              // BANNER
              // Container: banner promosi dengan gradien
              Container(
                height: 130,
                width: double.infinity,
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
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color:
                          const Color(0xFF6B1F1F).withValues(alpha: 0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                // Stack: menumpuk dekorasi ikon dan teks banner
                child: Stack(
                  children: [
                    // Positioned: dekorasi ikon cangkir di pojok kanan atas
                    Positioned(
                      right: -20,
                      top: -20,
                      child: Icon(Icons.local_cafe_rounded,
                          size: 140,
                          color: Colors.white.withValues(alpha: 0.08)),
                    ),
                    // Padding: memberi jarak untuk konten banner
                    Padding(
                      padding: const EdgeInsets.all(20),
                      // Column: menyusun konten banner secara vertikal
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Container: badge "MENU LENGKAP"
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD4A574),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            // Text: teks badge
                            child: const Text(
                              'MENU LENGKAP',
                              style: TextStyle(
                                color: Color(0xFF2B0000),
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Text: judul banner "Semua Menu"
                          const Text(
                            'Semua Menu',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          // Text: deskripsi banner
                          Text(
                            'Temukan minuman dan makanan favoritmu',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.85),
                              fontSize: 11.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20), // Jarak vertikal 20

              // SEARCH BAR
              // Container: pembungkus search bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color:
                          const Color(0xFF6B1F1F).withValues(alpha: 0.08),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                // TextField: input pencarian
                child: TextField(
                  controller: _searchController, // Controller untuk teks
                  onChanged: (v) => setState(() => _searchQuery = v), // Update state saat teks berubah
                  // InputDecoration: dekorasi TextField
                  decoration: InputDecoration(
                    hintText: 'Cari menu favoritmu...', // Placeholder
                    hintStyle: const TextStyle(
                        color: Color(0xFFB8A8A0), fontSize: 14),
                    // prefixIcon: ikon pencarian di kiri
                    prefixIcon: const Icon(Icons.search_rounded,
                        color: Color(0xFF6B1F1F), size: 22),
                    // suffixIcon: tombol clear jika ada teks
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.close_rounded,
                                color: Color(0xFF6B1F1F), size: 20),
                            onPressed: () {
                              _searchController.clear(); // Hapus teks
                              setState(() => _searchQuery = ''); // Reset state
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              const SizedBox(height: 24), // Jarak vertikal 24

              // EMPTY STATE (hanya muncul kalau hasil PENCARIAN kosong)
              if (total == 0)
                // SizedBox: wadah untuk empty state
                SizedBox(
                  width: double.infinity,
                  // Padding: memberi jarak vertikal
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 60),
                    // Column: menyusun konten empty state secara vertikal
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Container: lingkaran latar ikon
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: const Color(0xFF6B1F1F)
                                .withValues(alpha: 0.08),
                            shape: BoxShape.circle,
                          ),
                          // Icon: ikon search off
                          child: const Icon(Icons.search_off_rounded,
                              size: 46, color: Color(0xFF6B1F1F)),
                        ),
                        const SizedBox(height: 20),
                        // Text: judul empty state
                        const Text(
                          'Menu tidak ditemukan',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF2B0000),
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 6),
                        // Text: saran untuk empty state
                        const Text(
                          'Coba cari dengan kata kunci lain',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12, color: Color(0xFF8B6F6F)),
                        ),
                      ],
                    ),
                  ),
                ),


              // SECTION PER KATEGORI
              // Produk habis TETAP tampil, ProductCard yang handle labelnya
            
              // Section Coffee: tampil jika ada produk yang lolos filter
              if (filteredCoffee.isNotEmpty)
                _buildSection(judul: 'Coffee', produk: filteredCoffee),
              // Jarak antar section jika keduanya ada
              if (filteredCoffee.isNotEmpty && filteredNonCoffee.isNotEmpty)
                const SizedBox(height: 24),
              // Section Non-Coffee: tampil jika ada produk yang lolos filter
              if (filteredNonCoffee.isNotEmpty)
                _buildSection(
                    judul: 'Non-Coffee', produk: filteredNonCoffee),
              // Jarak antar section jika keduanya ada
              if (filteredNonCoffee.isNotEmpty && filteredSnack.isNotEmpty)
                const SizedBox(height: 24),
              // Section Snack: tampil jika ada produk yang lolos filter
              if (filteredSnack.isNotEmpty)
                _buildSection(judul: 'Snack', produk: filteredSnack),

              const SizedBox(height: 24), // Jarak vertikal akhir
            ],
          ),
        ),
      ),
    );
  }

  // Helper: bangun satu section kategori
  Widget _buildSection({
    required String judul,
    required List<_DataProduk> produk,
  }) {
    // Column: menyusun judul section dan daftar produk secara vertikal
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row: judul section dan jumlah produk
        Row(
          children: [
            // Container: garis aksen kecil di kiri judul
            Container(
              width: 4,
              height: 20,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6B1F1F), Color(0xFFD4A574)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 10),
            // Text: judul kategori
            Text(
              judul,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: Color(0xFF2B0000),
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(width: 6),
            // Text: jumlah produk dalam kategori
            Text(
              '(${produk.length})',
              style:
                  const TextStyle(fontSize: 12, color: Color(0xFFB8A8A0)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // ...produk.map: menyebarkan daftar ProductCard ke dalam Column
        ...produk.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            // ProductCard: kartu produk untuk setiap item
            child: ProductCard(
              nama: item.nama,
              deskripsi: item.deskripsi,
              harga: item.harga,
              rating: item.rating,
              ulasan: item.ulasan,
              icon: item.icon,
              gambar: item.gambar,
              isBestSeller: item.isBestSeller,
              stokAwal: item.stokAwal,
            ),
          ),
        ),
      ],
    );
  }
}

// Model data produk internal
class _DataProduk {
  final String nama;          // Nama produk
  final String deskripsi;     // Deskripsi produk
  final String harga;         // Harga dalam format string
  final double rating;        // Rating produk
  final int ulasan;           // Jumlah ulasan
  final IconData icon;        // Ikon fallback
  final String gambar;        // Path gambar produk
  final bool isBestSeller;    // Status best seller
  final int stokAwal;         // Stok awal produk

  const _DataProduk({
    required this.nama,
    required this.deskripsi,
    required this.harga,
    required this.rating,
    required this.ulasan,
    required this.icon,
    required this.gambar,
    required this.isBestSeller,
    this.stokAwal = 10,
  });
}