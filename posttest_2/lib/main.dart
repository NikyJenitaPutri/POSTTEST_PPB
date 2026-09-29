import 'package:flutter/material.dart';

import 'widgets/home_page.dart';
import 'widgets/menu_page.dart';
import 'widgets/cart_page.dart';
import 'widgets/profile_page.dart';

// Fungsi utama untuk menjalankan aplikasi Flutter
void main() {
  // runApp digunakan untuk menjalankan widget utama aplikasi
  runApp(const MainApp());
}

// StatelessWidget digunakan untuk membuat tampilan yang tidak memiliki perubahan state
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp digunakan sebagai dasar aplikasi Flutter
    return MaterialApp(
      // title digunakan untuk memberikan nama pada aplikasi
      title: 'KopiKita',

      // debugShowCheckedModeBanner digunakan untuk menghilangkan tulisan DEBUG di pojok kanan atas
      debugShowCheckedModeBanner: false,

      // ThemeData digunakan untuk mengatur tema dan tampilan aplikasi
      theme: ThemeData(
        // fontFamily digunakan untuk menentukan jenis font yang digunakan aplikasi
        fontFamily: 'Inter',

        // ColorScheme digunakan untuk mengatur kumpulan warna utama aplikasi
        colorScheme: ColorScheme.fromSeed(
          // seedColor menjadi warna dasar untuk membuat kombinasi warna
          seedColor: const Color(0xFF660000),

          // primary digunakan sebagai warna utama aplikasi
          primary: const Color(0xFF660000),

          // secondary digunakan sebagai warna pendukung aplikasi
          secondary: const Color(0xFF660000),

          // surface digunakan sebagai warna permukaan seperti background komponen
          surface: Colors.white,
        ),

        // scaffoldBackgroundColor digunakan untuk mengatur warna background Scaffold
        scaffoldBackgroundColor: Colors.white,
      ),

      // home digunakan untuk menentukan halaman pertama yang ditampilkan
      home: const NavigationPage(),
    );
  }
}

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  // ValueNotifier digunakan untuk menyimpan index halaman aktif.
  static final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  // List<Widget> digunakan untuk menyimpan semua halaman yang akan ditampilkan
  // 0 = Home, 1 = Menu, 2 = Keranjang, 3 = Profil
  static const List<Widget> _halaman = [
    // HomePage digunakan sebagai halaman utama aplikasi
    HomePage(),

    // MenuPage digunakan untuk menampilkan daftar menu KopiKita
    MenuPage(),

    // CartPage digunakan untuk menampilkan isi keranjang
    CartPage(),

    // ProfilePage digunakan untuk menampilkan halaman profil pengguna
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    // Scaffold digunakan sebagai struktur dasar halaman
    return Scaffold(

      // body digunakan untuk menampilkan isi utama halaman
      body: ValueListenableBuilder<int>(
        // valueListenable adalah sumber data yang dipantau perubahannya
        valueListenable: _currentIndex,

        // builder dijalankan ulang setiap kali value berubah
        // context = BuildContext, index = nilai _currentIndex saat ini
        builder: (context, index, _) {
          return IndexedStack(
            // index menentukan halaman mana yang sedang ditampilkan
            index: index,

            // children berisi semua halaman yang dapat ditampilkan
            children: _halaman,
          );
        },
      ),

      // BottomNavigationBar digunakan untuk navigasi di bagian bawah aplikasi
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _currentIndex,
        builder: (context, index, _) {
          return BottomNavigationBar(

            // backgroundColor digunakan untuk mengatur warna background navigasi
            backgroundColor: Colors.white,

            // selectedItemColor digunakan untuk menentukan warna item yang sedang dipilih
            selectedItemColor: const Color(0xFF660000),

            // unselectedItemColor digunakan untuk menentukan warna item yang tidak dipilih
            unselectedItemColor: const Color(0xFFCCCCCC),

            // currentIndex menunjukkan item navigasi yang sedang aktif
            currentIndex: index,

            // BottomNavigationBarType.fixed membuat semua item tetap terlihat
            type: BottomNavigationBarType.fixed,

            // elevation memberikan efek bayangan pada bagian navigasi
            elevation: 8,

            onTap: (newIndex) {
              _currentIndex.value = newIndex;
            },

            // items berisi daftar tombol yang terdapat pada BottomNavigationBar
            items: const [

              // BottomNavigationBarItem untuk tombol navigasi Home
              BottomNavigationBarItem(
                // Icon digunakan untuk menampilkan ikon rumah
                icon: Icon(Icons.home),

                // label digunakan untuk memberikan nama pada tombol
                label: 'Home',
              ),

              // BottomNavigationBarItem untuk tombol navigasi Menu
              BottomNavigationBarItem(
                // Icon digunakan untuk menampilkan ikon buku menu
                icon: Icon(Icons.menu_book),

                // label digunakan untuk memberikan nama pada tombol
                label: 'Menu',
              ),

              // BottomNavigationBarItem untuk tombol navigasi Keranjang
              BottomNavigationBarItem(
                // Icon digunakan untuk menampilkan ikon tas belanja
                icon: Icon(Icons.shopping_bag),

                // label digunakan untuk memberikan nama pada tombol
                label: 'Keranjang',
              ),

              // BottomNavigationBarItem untuk tombol navigasi Profil
              BottomNavigationBarItem(
                // Icon digunakan untuk menampilkan ikon pengguna
                icon: Icon(Icons.person),

                // label digunakan untuk memberikan nama pada tombol
                label: 'Profil',
              ),
            ],
          );
        },
      ),
    );
  }
}