// import Material untuk ChangeNotifier
import 'package:flutter/material.dart';
// import model CartItem
import '../models/cart_item.dart';

// ============================================================
// CartState = STATE GLOBAL KERANJANG
//
// KONSEP:
//   - ChangeNotifier : kelas bawaan Flutter untuk state reaktif
//   - Singleton      : satu instance untuk seluruh app
//   - Derived state  : nilai dihitung dari state lain
//
// KEGUNAAN:
//   - Menyimpan daftar item keranjang di satu tempat
//   - Menyediakan CRUD (add, change, remove, clear)
//   - Memvalidasi stok (tidak boleh melebihi stokAwal)
//   - Memberi tahu UI via notifyListeners() saat berubah
// ============================================================
class CartState extends ChangeNotifier {
  // Singleton pattern: instance tunggal untuk seluruh app
  static final CartState instance = CartState._internal();
  CartState._internal();

  // STATE UTAMA: list item keranjang
  // Kegunaan: menyimpan semua CartItem yang sudah ditambahkan
  final List<CartItem> _items = [];

  // Getter read-only — kegunaan: cegah list dimutasi dari luar
  List<CartItem> get items => List.unmodifiable(_items);

  // ---------- DERIVED STATE ----------
  // Konsep: nilai dihitung ulang saat diakses, tidak disimpan

  // total quantity semua item — kegunaan: badge keranjang
  int get totalItems => _items.fold(0, (s, e) => s + e.jumlah);

  // subtotal sebelum pajak — kegunaan: baris ringkasan pesanan
  int get subtotal => _items.fold(0, (s, e) => s + e.totalHarga);

  // pajak 10% dibulatkan ke ratusan — kegunaan: baris ringkasan
  int get pajak {
    if (_items.isEmpty) return 0;
    final nilai = (subtotal * 0.10).round();
    return (nilai ~/ 100) * 100;
  }

  // total akhir — kegunaan: angka besar di ringkasan & dialog
  int get total => subtotal + pajak;

  // ---------- UTILITY (static helper) ----------
  // Kegunaan: format int → "Rp18.000"
  static String formatRupiah(int v) {
    final str = v.toString();
    final buf = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) buf.write('.');
      buf.write(str[i]);
    }
    return 'Rp$buf';
  }

  // Kegunaan: parse "Rp18.000" → 18000 (hapus non-digit)
  static int parseHarga(String h) =>
      int.parse(h.replaceAll(RegExp(r'[^0-9]'), ''));

  // ================================================================
  // STOK (derived state)
  // ================================================================

  // Kegunaan: cek berapa quantity produk tertentu di keranjang
  // Konsep  : indexWhere = cari index item berdasarkan predikat
  int jumlahDiKeranjang(String nama) {
    final i = _items.indexWhere((e) => e.nama == nama);
    return i < 0 ? 0 : _items[i].jumlah;
  }

  // Kegunaan: hitung sisa stok = stokAwal - jumlahDiKeranjang
  // Konsep  : di-clamp ke 0 supaya tidak negatif
  int sisaStok(String nama, int stokAwal) {
    final sisa = stokAwal - jumlahDiKeranjang(nama);
    return sisa < 0 ? 0 : sisa;
  }

  // ================================================================
  // CRUD KERANJANG (dengan validasi stok)
  // ================================================================

  // Kegunaan: tambah item ke keranjang
  // Konsep  : kalau sudah ada → gabung quantity (clamp ke stok)
  //           kalau belum → tambah sebagai item baru
  void addItem(CartItem item) {
    final i = _items.indexWhere((e) => e.nama == item.nama);
    if (i >= 0) {
      final totalBaru = _items[i].jumlah + item.jumlah;
      final maksimal = item.stokAwal;
      _items[i] = _items[i].copyWith(
        jumlah: totalBaru > maksimal ? maksimal : totalBaru,
      );
    } else {
      final aman = item.jumlah > item.stokAwal ? item.stokAwal : item.jumlah;
      _items.add(item.copyWith(jumlah: aman));
    }
    // notifyListeners: beri tahu UI agar rebuild
    notifyListeners();
  }

  // Kegunaan: ubah quantity item
  // Konsep  : jika ≤ 0 → hapus item; jika > stok → clamp ke stok
  void changeQuantity(String nama, int jumlah) {
    final i = _items.indexWhere((e) => e.nama == nama);
    if (i < 0) return;
    if (jumlah <= 0) {
      _items.removeAt(i);
    } else {
      final maksimal = _items[i].stokAwal;
      final aman = jumlah > maksimal ? maksimal : jumlah;
      _items[i] = _items[i].copyWith(jumlah: aman);
    }
    notifyListeners();
  }

  // Kegunaan: hapus item berdasarkan nama
  void removeItem(String nama) {
    _items.removeWhere((e) => e.nama == nama);
    notifyListeners();
  }

  // Kegunaan: kosongkan keranjang (setelah checkout)
  void clear() {
    _items.clear();
    notifyListeners();
  }
}