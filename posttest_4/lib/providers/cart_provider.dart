import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  // STATE UTAMA: list item keranjang
  // _items: menyimpan semua item yang ada di keranjang
  final List<CartItem> _items = [];

  // items: getter untuk mengakses _items sebagai list yang tidak bisa diubah
  List<CartItem> get items => List.unmodifiable(_items);

  // ---------- DERIVED STATE ----------
  // totalItems: menghitung total jumlah semua item (sum dari e.jumlah)
  int get totalItems => _items.fold(0, (s, e) => s + e.jumlah);
  // subtotal: menghitung total harga sebelum pajak (sum dari e.totalHarga)
  int get subtotal => _items.fold(0, (s, e) => s + e.totalHarga);
  // pajak: menghitung pajak 10% dari subtotal, dibulatkan ke ratusan terdekat
  int get pajak {
    if (_items.isEmpty) return 0; // Jika kosong, pajak 0
    final nilai = (subtotal * 0.10).round(); // Hitung 10% lalu bulatkan
    return (nilai ~/ 100) * 100; // Bulatkan ke ratusan terdekat
  }
  // total: subtotal + pajak
  int get total => subtotal + pajak;

  // ---------- UTILITY ----------
  // formatRupiah: mengubah integer menjadi format "Rp1.234.567"
  static String formatRupiah(int v) {
    final str = v.toString();
    final buf = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      // Tambahkan titik setiap 3 digit dari belakang
      if (i > 0 && (str.length - i) % 3 == 0) buf.write('.');
      buf.write(str[i]);
    }
    return 'Rp$buf';
  }

  // parseHarga: mengubah string harga (mis. "Rp18.000") menjadi integer 18000
  static int parseHarga(String h) =>
      int.parse(h.replaceAll(RegExp(r'[^0-9]'), ''));

  // ---------- STOK (derived) ----------
  // jumlahDiKeranjang: mengembalikan jumlah item tertentu yang ada di keranjang
  int jumlahDiKeranjang(String nama) {
    final i = _items.indexWhere((e) => e.nama == nama); // Cari index item
    return i < 0 ? 0 : _items[i].jumlah; // Jika tidak ada, kembalikan 0
  }

  // sisaStok: menghitung sisa stok setelah dikurangi jumlah di keranjang
  int sisaStok(String nama, int stokAwal) {
    final sisa = stokAwal - jumlahDiKeranjang(nama); // Stok awal - yang di keranjang
    return sisa < 0 ? 0 : sisa; // Pastikan tidak negatif
  }

  // ---------- CRUD ----------
  // addItem: menambahkan item ke keranjang, atau menambah jumlah jika sudah ada
  void addItem(CartItem item) {
    final i = _items.indexWhere((e) => e.nama == item.nama); // Cek apakah sudah ada
    if (i >= 0) {
      // Jika sudah ada, tambahkan jumlahnya
      final totalBaru = _items[i].jumlah + item.jumlah;
      final maksimal = item.stokAwal; // Batas maksimal stok
      _items[i] = _items[i].copyWith(
        jumlah: totalBaru > maksimal ? maksimal : totalBaru, // Batasi dengan stok
      );
    } else {
      // Jika belum ada, tambahkan item baru
      final aman = item.jumlah > item.stokAwal ? item.stokAwal : item.jumlah; // Batasi jumlah
      _items.add(item.copyWith(jumlah: aman));
    }
    // Modul 5: notifyListeners() → widget yang listen akan rebuild
    notifyListeners();
  }

  // changeQuantity: mengubah jumlah item tertentu
  void changeQuantity(String nama, int jumlah) {
    final i = _items.indexWhere((e) => e.nama == nama); // Cari index item
    if (i < 0) return; // Jika tidak ditemukan, keluar
    if (jumlah <= 0) {
      _items.removeAt(i); // Jika jumlah <= 0, hapus item
    } else {
      final maksimal = _items[i].stokAwal; // Stok maksimal
      final aman = jumlah > maksimal ? maksimal : jumlah; // Batasi dengan stok
      _items[i] = _items[i].copyWith(jumlah: aman);
    }
    notifyListeners(); // Beritahu listener bahwa state berubah
  }

  // removeItem: menghapus item dari keranjang berdasarkan nama
  void removeItem(String nama) {
    _items.removeWhere((e) => e.nama == nama); // Hapus semua yang namanya cocok
    notifyListeners(); // Beritahu listener
  }

  // clear: mengosongkan seluruh keranjang
  void clear() {
    _items.clear(); // Hapus semua item
    notifyListeners(); // Beritahu listener
  }
}