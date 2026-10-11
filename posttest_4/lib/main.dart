import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/home_page.dart';
import 'widgets/menu_page.dart';
import 'widgets/cart_page.dart';
import 'widgets/profile_page.dart';
import 'providers/cart_provider.dart';

void main() {
  // Modul 5: MultiProvider + ChangeNotifierProvider
  // MultiProvider: menyediakan beberapa provider sekaligus ke seluruh widget tree
  runApp(
    MultiProvider(
      providers: [
        // ChangeNotifierProvider: menyediakan instance CartProvider ke seluruh widget
        // CartProvider akan memberi tahu listener ketika data keranjang berubah
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

// MainApp: widget root aplikasi yang mengatur MaterialApp dan tema
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp: widget utama yang menyediakan konfigurasi aplikasi Material
    return MaterialApp(
      title: 'KopiKita', // Judul aplikasi
      debugShowCheckedModeBanner: false, // Menyembunyikan banner debug
      // ThemeData: mengatur tema global aplikasi
      theme: ThemeData(
        fontFamily: 'Inter', // Font default aplikasi
        useMaterial3: true, // Mengaktifkan Material 3
        // ColorScheme.fromSeed: membuat skema warna dari warna seed
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6B1F1F), // Warna dasar tema
          primary: const Color(0xFF6B1F1F), // Warna utama
          secondary: const Color(0xFFD4A574), // Warna sekunder
          surface: const Color(0xFFFDF6F0), // Warna permukaan
        ),
        scaffoldBackgroundColor: const Color(0xFFFDF6F0), // Warna latar Scaffold
      ),
      home: const NavigationPage(), // Halaman awal aplikasi
    );
  }
}


// NavigationPage = PEMBUNGKUS BOTTOM NAVIGATION
// Modul 5: Consumer<CartProvider> untuk badge keranjang

// NavigationPage: widget stateless yang menjadi pembungkus utama
// untuk menampilkan halaman dan bottom navigation
class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  // State: _currentIndex menyimpan indeks tab yang sedang aktif
  // ValueNotifier<int> membuat state reaktif tanpa perlu StatefulWidget
  static final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  // State: _halaman menyimpan daftar halaman yang akan ditampilkan
  static const List<Widget> _halaman = [
    HomePage(), // Halaman Home
    MenuPage(), // Halaman Menu
    CartPage(), // Halaman Keranjang
    ProfilePage(), // Halaman Profil
  ];

  @override
  Widget build(BuildContext context) {
    // Scaffold: kerangka dasar halaman dengan body dan bottomNavigationBar
    return Scaffold(
      extendBody: true, // Body diperluas hingga ke belakang bottom navigation
      // ValueListenableBuilder: membangun ulang widget ketika _currentIndex berubah
      body: ValueListenableBuilder<int>(
        valueListenable: _currentIndex, // State yang dipantau
        builder: (context, index, _) {
          // IndexedStack: menampilkan satu halaman berdasarkan index,
          // tetapi tetap menjaga state semua halaman di dalamnya
          return IndexedStack(index: index, children: _halaman);
        },
      ),
      // ValueListenableBuilder: membangun ulang bottom navigation saat index berubah
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _currentIndex,
        builder: (context, index, _) {
          // Modul 5: Consumer<CartProvider> → rebuild saat CartProvider berubah
          // Consumer: mendengarkan perubahan dari CartProvider
          return Consumer<CartProvider>(
            builder: (context, cart, child) {
              // State: cartCount menyimpan jumlah total item di keranjang
              final cartCount = cart.totalItems; // context via Consumer
              // Container: membungkus bottom navigation dengan margin dan dekorasi
              return Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 16), // Jarak dari tepi
                // BoxDecoration: dekorasi container (warna, sudut, bayangan)
                decoration: BoxDecoration(
                  color: Colors.white, // Warna latar container
                  borderRadius: BorderRadius.circular(24), // Sudut melengkung
                  boxShadow: [
                    // BoxShadow: efek bayangan pada container
                    BoxShadow(
                      color: const Color(0xFF6B1F1F).withValues(alpha: 0.18),
                      blurRadius: 30, // Tingkat kekaburan bayangan
                      offset: const Offset(0, 12), // Pergeseran bayangan
                    ),
                  ],
                ),
                // ClipRRect: memotong sudut child agar mengikuti borderRadius
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  // BottomNavigationBar: navigasi bawah dengan beberapa item
                  child: BottomNavigationBar(
                    backgroundColor: Colors.white, // Warna latar navigasi
                    selectedItemColor: const Color(0xFF6B1F1F), // Warna item terpilih
                    unselectedItemColor: const Color(0xFFB8A8A0), // Warna item tidak terpilih
                    currentIndex: index, // Indeks tab yang sedang aktif
                    type: BottomNavigationBarType.fixed, // Tipe tetap
                    showUnselectedLabels: true, // Menampilkan label meskipun tidak terpilih
                    elevation: 0, // Menghilangkan elevasi bawaan
                    selectedFontSize: 11, // Ukuran font label terpilih
                    unselectedFontSize: 11, // Ukuran font label tidak terpilih
                    selectedLabelStyle:
                        const TextStyle(fontWeight: FontWeight.w700), // Gaya label terpilih
                    // onTap: mengubah state _currentIndex saat item ditekan
                    onTap: (newIndex) => _currentIndex.value = newIndex,
                    items: [
                      // BottomNavigationBarItem: item navigasi untuk Home
                      const BottomNavigationBarItem(
                        icon: Icon(Icons.home_rounded),
                        label: 'Home',
                      ),
                      // BottomNavigationBarItem: item navigasi untuk Menu
                      const BottomNavigationBarItem(
                        icon: Icon(Icons.menu_book_rounded),
                        label: 'Menu',
                      ),
                      // BottomNavigationBarItem: item navigasi untuk Keranjang
                      // Icon menggunakan _CartBadgeIcon untuk menampilkan badge
                      BottomNavigationBarItem(
                        icon: _CartBadgeIcon(count: cartCount),
                        label: 'Keranjang',
                      ),
                      // BottomNavigationBarItem: item navigasi untuk Profil
                      const BottomNavigationBarItem(
                        icon: Icon(Icons.person_rounded),
                        label: 'Profil',
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// _CartBadgeIcon: widget khusus untuk menampilkan ikon keranjang dengan badge jumlah item
class _CartBadgeIcon extends StatelessWidget {
  final int count; // State: jumlah item yang ditampilkan pada badge
  const _CartBadgeIcon({required this.count});

  @override
  Widget build(BuildContext context) {
    // Stack: menumpuk beberapa widget (ikon dan badge) dalam satu area
    return Stack(
      clipBehavior: Clip.none, // Mengizinkan badge keluar dari batas Stack
      children: [
        // Icon: ikon utama keranjang
        const Icon(Icons.shopping_bag_rounded),
        // Kondisi: badge hanya ditampilkan jika count > 0
        if (count > 0)
          // Positioned: mengatur posisi badge secara relatif terhadap Stack
          Positioned(
            right: -8, // Geser ke kanan
            top: -6, // Geser ke atas
            // Container: wadah untuk badge
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2), // Padding dalam badge
              // BoxConstraints: ukuran minimum badge agar tetap terlihat
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              // BoxDecoration: dekorasi badge (gradien, sudut, border)
              decoration: BoxDecoration(
                // LinearGradient: warna gradien badge
                gradient: const LinearGradient(
                  colors: [Color(0xFF6B1F1F), Color(0xFFB5474A)],
                ),
                borderRadius: BorderRadius.circular(10), // Sudut badge melengkung
                border: Border.all(color: Colors.white, width: 1.5), // Border putih
              ),
              // Text: menampilkan jumlah item pada badge
              child: Text(
                '$count',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white, // Warna teks putih
                  fontSize: 9, // Ukuran font kecil
                  fontWeight: FontWeight.bold, // Teks tebal
                ),
              ),
            ),
          ),
      ],
    );
  }
}