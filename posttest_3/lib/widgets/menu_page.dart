import 'package:flutter/material.dart';

import 'product_card.dart';
import 'cart_page.dart';
import '../state/cart_state.dart';

// ============================================================
// MenuPage = HALAMAN MENU (StatefulWidget)
//
// STATE LOKAL:
//   - _searchQuery      : String kata kunci pencarian
//   - _searchController : TextEditingController untuk TextField
// LIFECYCLE:
//   - dispose : bersihkan controller agar tidak memory leak
//
// KONSEP: setState untuk update _searchQuery → UI rebuild
// ============================================================
class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  // STATE: kata kunci pencarian user
  // Kegunaan: filter produk yang ditampilkan
  String _searchQuery = '';

  // STATE: controller TextField
  // Kegunaan: baca/tulis isi field + clear input
  final TextEditingController _searchController = TextEditingController();

  // dispose: bersihkan controller saat widget dihapus
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Kegunaan: filter produk (stok > 0 DAN cocok dengan query)
  // Konsep  : where = filter list berdasarkan predikat
  List<_DataProduk> _filter(List<_DataProduk> produk) {
    return produk.where((p) {
      final sisa = CartState.instance.sisaStok(p.nama, p.stokAwal);
      final adaStok = sisa > 0;
      final cocok = _searchQuery.isEmpty ||
          p.nama.toLowerCase().contains(_searchQuery.toLowerCase());
      return adaStok && cocok;
    }).toList();
  }

  // Kegunaan: navigasi ke halaman keranjang
  void _bukaKeranjang() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CartPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Data produk statis
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

    // Derived state: hasil filter per kategori
    final filteredCoffee = _filter(coffeeList);
    final filteredNonCoffee = _filter(nonCoffeeList);
    final filteredSnack = _filter(snackList);
    final total =
        filteredCoffee.length + filteredNonCoffee.length + filteredSnack.length;

    // Scaffold: kerangka halaman
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6F0),
      // SafeArea: hindari notch & status bar
      body: SafeArea(
        // SingleChildScrollView: halaman bisa discroll
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Row(
                children: [
                  // Navigasi kondisional
                  if (Navigator.canPop(context))
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF6B1F1F)
                                  .withOpacity(0.08),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.arrow_back_rounded,
                            color: Color(0xFF6B1F1F), size: 22),
                      ),
                    )
                  else
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color:
                                const Color(0xFF6B1F1F).withOpacity(0.25),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      clipBehavior: Clip.antiAlias,
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
                            child: const Icon(Icons.menu_book_rounded,
                                color: Colors.white, size: 22),
                          );
                        },
                      ),
                    ),
                  const SizedBox(width: 12),
                  // Expanded: teks mengisi ruang sisa
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Menu',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF2B0000),
                            letterSpacing: -0.5,
                          ),
                        ),
                        Text(
                          'Pilih favoritmu',
                          style: TextStyle(
                              fontSize: 11, color: Color(0xFFB8A8A0)),
                        ),
                      ],
                    ),
                  ),
                  // ListenableBuilder: pantau CartState → badge keranjang
                  ListenableBuilder(
                    listenable: CartState.instance,
                    builder: (context, _) {
                      final count = CartState.instance.totalItems;
                      return GestureDetector(
                        onTap: _bukaKeranjang,
                        // Stack: tumpuk badge di atas ikon
                        child: Stack(
                          // Clip.none: izinkan anak keluar batas Stack
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF6B1F1F)
                                        .withOpacity(0.08),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                  Icons.shopping_bag_rounded,
                                  color: Color(0xFF6B1F1F),
                                  size: 22),
                            ),
                            // Badge count di pojok kanan atas
                            if (count > 0)
                              Positioned(
                                right: -4,
                                top: -4,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  // BoxConstraints: batas ukuran minimum
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
                                  child: Text(
                                    '$count',
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
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // BANNER
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
                      color: const Color(0xFF6B1F1F).withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -20,
                      top: -20,
                      child: Icon(Icons.local_cafe_rounded,
                          size: 140,
                          color: Colors.white.withOpacity(0.08)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD4A574),
                              borderRadius: BorderRadius.circular(20),
                            ),
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
                          Text(
                            'Temukan minuman dan makanan favoritmu',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 11.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // SEARCH — TextField + setState
              // KONSEP: onChanged → setState → rebuild → filter ulang
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6B1F1F).withOpacity(0.08),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                // TextField: input teks dari user
                child: TextField(
                  controller: _searchController,
                  // onChanged: dipicu setiap user mengetik
                  onChanged: (v) => setState(() => _searchQuery = v),
                  // InputDecoration: dekorasi + ikon
                  decoration: InputDecoration(
                    hintText: 'Cari menu favoritmu...',
                    hintStyle: const TextStyle(
                        color: Color(0xFFB8A8A0), fontSize: 14),
                    // prefixIcon: ikon di kiri
                    prefixIcon: const Icon(Icons.search_rounded,
                        color: Color(0xFF6B1F1F), size: 22),
                    // suffixIcon: ikon di kanan (tombol clear)
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.close_rounded,
                                color: Color(0xFF6B1F1F), size: 20),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchQuery = '');
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Empty state pencarian (kondisional jika total == 0)
              if (total == 0)
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 60),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color:
                                const Color(0xFF6B1F1F).withOpacity(0.08),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.search_off_rounded,
                              size: 46, color: Color(0xFF6B1F1F)),
                        ),
                        const SizedBox(height: 20),
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

              // Section per kategori (hanya yang lolos filter)
              if (filteredCoffee.isNotEmpty)
                _buildSection(judul: 'Coffee', produk: filteredCoffee),
              if (filteredCoffee.isNotEmpty && filteredNonCoffee.isNotEmpty)
                const SizedBox(height: 24),
              if (filteredNonCoffee.isNotEmpty)
                _buildSection(judul: 'Non-Coffee', produk: filteredNonCoffee),
              if (filteredNonCoffee.isNotEmpty && filteredSnack.isNotEmpty)
                const SizedBox(height: 24),
              if (filteredSnack.isNotEmpty)
                _buildSection(judul: 'Snack', produk: filteredSnack),

              const SizedBox(height: 24),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Aksen garis gradien
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
            Text(
              '(${produk.length})',
              style:
                  const TextStyle(fontSize: 12, color: Color(0xFFB8A8A0)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Render tiap produk pakai ProductCard reusable
        // ... = spread operator untuk menyebar list widget
        ...produk.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
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

// Model data produk internal untuk halaman menu
class _DataProduk {
  final String nama;
  final String deskripsi;
  final String harga;
  final double rating;
  final int ulasan;
  final IconData icon;
  final String gambar;
  final bool isBestSeller;
  final int stokAwal;

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