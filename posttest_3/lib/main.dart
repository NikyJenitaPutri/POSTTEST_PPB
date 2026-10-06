import 'package:flutter/material.dart';

import 'widgets/home_page.dart';
import 'widgets/menu_page.dart';
import 'widgets/cart_page.dart';
import 'widgets/profile_page.dart';
import 'state/cart_state.dart';

void main() {
  // runApp: titik masuk aplikasi Flutter
  runApp(const MainApp());
}

// ============================================================
// MainApp = root aplikasi
// KONSEP:
//   - MaterialApp : widget root yang menyediakan tema + navigasi
//   - ThemeData   : konfigurasi tema global
// KEGUNAAN: mengatur tema + halaman home
// ============================================================
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp: wrapper utama app
    return MaterialApp(
      title: 'KopiKita',
      debugShowCheckedModeBanner: false,
      // ThemeData: konfigurasi tema global
      theme: ThemeData(
        fontFamily: 'Inter',
        useMaterial3: true, // aktifkan Material 3
        // ColorScheme.fromSeed: bikin skema warna dari 1 warna
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6B1F1F),
          primary: const Color(0xFF6B1F1F),
          secondary: const Color(0xFFD4A574),
          surface: const Color(0xFFFDF6F0),
        ),
        scaffoldBackgroundColor: const Color(0xFFFDF6F0),
      ),
      // home: halaman pertama yang ditampilkan
      home: const NavigationPage(),
    );
  }
}

// ============================================================
// NavigationPage = PEMBUNGKUS BOTTOM NAVIGATION
//
// STATE GLOBAL RINGAN: _currentIndex (ValueNotifier<int>)
// KONSEP:
//   - ValueNotifier          : state ringan non-widget
//   - ValueListenableBuilder : rebuild saat nilai berubah
//   - IndexedStack           : tampilkan 1 anak, yang lain tetap hidup
//   - ListenableBuilder      : pantau CartState untuk badge keranjang
// ============================================================
class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  // STATE: index tab aktif (0=Home, 1=Menu, 2=Keranjang, 3=Profil)
  // Kegunaan: menentukan tab yang sedang aktif
  static final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  // Daftar halaman yang akan ditampilkan
  // IndexedStack: state tiap halaman tetap hidup saat pindah tab
  static const List<Widget> _halaman = [
    HomePage(),
    MenuPage(),
    CartPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    // Scaffold: kerangka halaman
    return Scaffold(
      // extendBody: body extend ke belakang bottom nav
      extendBody: true,
      // ValueListenableBuilder: rebuild body saat _currentIndex berubah
      body: ValueListenableBuilder<int>(
        valueListenable: _currentIndex,
        builder: (context, index, _) {
          // IndexedStack: hanya tampil 1, semua tetap hidup
          return IndexedStack(index: index, children: _halaman);
        },
      ),
      // BottomNavigationBar: bar navigasi bawah
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _currentIndex,
        builder: (context, index, _) {
          // ListenableBuilder: pantau CartState untuk badge
          return ListenableBuilder(
            listenable: CartState.instance,
            builder: (context, _) {
              final cartCount = CartState.instance.totalItems;

              // Container pembungkus nav bar (radius + shadow)
              return Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6B1F1F).withOpacity(0.18),
                      blurRadius: 30,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                // ClipRRect: memotong anak sesuai radius
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  // BottomNavigationBar: bar navigasi bawaan Material
                  child: BottomNavigationBar(
                    backgroundColor: Colors.white,
                    selectedItemColor: const Color(0xFF6B1F1F),
                    unselectedItemColor: const Color(0xFFB8A8A0),
                    currentIndex: index,
                    // fixed: semua tab punya lebar sama
                    type: BottomNavigationBarType.fixed,
                    showUnselectedLabels: true,
                    elevation: 0,
                    selectedFontSize: 11,
                    unselectedFontSize: 11,
                    selectedLabelStyle:
                        const TextStyle(fontWeight: FontWeight.w700),
                    // onTap: ubah nilai _currentIndex → rebuild
                    onTap: (newIndex) => _currentIndex.value = newIndex,
                    items: [
                      const BottomNavigationBarItem(
                        icon: Icon(Icons.home_rounded),
                        label: 'Home',
                      ),
                      const BottomNavigationBarItem(
                        icon: Icon(Icons.menu_book_rounded),
                        label: 'Menu',
                      ),
                      BottomNavigationBarItem(
                        // Ikon keranjang + badge count
                        icon: _CartBadgeIcon(count: cartCount),
                        label: 'Keranjang',
                      ),
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

// ============================================================
// _CartBadgeIcon = ikon keranjang + badge count
// KONSEP: Stack + Positioned untuk overlay badge
// KEGUNAAN: tampilkan jumlah item di atas ikon keranjang
// ============================================================
class _CartBadgeIcon extends StatelessWidget {
  final int count;
  const _CartBadgeIcon({required this.count});

  @override
  Widget build(BuildContext context) {
    // Stack: tumpuk ikon + badge
    // clipBehavior none: izinkan badge keluar batas Stack
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const Icon(Icons.shopping_bag_rounded),
        // Badge hanya muncul kalau ada item (count > 0)
        if (count > 0)
          // Positioned: atur posisi badge di pojok kanan atas
          Positioned(
            right: -8,
            top: -6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              // BoxConstraints: batas ukuran minimum
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6B1F1F), Color(0xFFB5474A)],
                ),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white, width: 1.5),
              ),
              child: Text(
                '$count',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}