// import Material: dibutuhkan untuk IconData (tipe data ikon)
import 'package:flutter/material.dart';

// CartItem: model data untuk satu item di keranjang
// Menyimpan informasi produk dan jumlah yang dibeli
class CartItem {
  final String nama;   // identitas produk, dipakai sebagai key pencarian
  final int harga;     // harga satuan, tidak berubah
  final String gambar; // path asset gambar produk
  final IconData icon; // ikon fallback jika gambar gagal dimuat

  // STATE: quantity di keranjang — satu-satunya field yang berubah
  // Kegunaan: menyimpan berapa banyak produk ini dibeli user
  int jumlah;

  // stokAwal = stok asli produk, statis
  // Sisa stok real-time dihitung CartProvider:
  //   sisaStok = stokAwal - jumlahDiKeranjang
  final int stokAwal;

  // Constructor: membuat instance CartItem
  // Parameter:
  //   nama, harga, gambar, icon (wajib)
  //   jumlah (default 1)
  //   stokAwal (default 99)
  CartItem({
    required this.nama,
    required this.harga,
    required this.gambar,
    required this.icon,
    this.jumlah = 1,
    this.stokAwal = 99,
  });

  // Getter totalHarga = DERIVED STATE
  // Kegunaan: hitung harga total untuk item ini (harga x jumlah)
  // Konsep  : nilai dihitung dari state lain, tidak disimpan
  int get totalHarga => harga * jumlah;

  // copyWith = pola immutable object
  // Kegunaan: buat salinan CartItem baru dengan field tertentu diubah
  // Konsep  : CartProvider tidak memutasi objek lama, tapi menggantinya
  // Parameter:
  //   jumlah (opsional) — jika null, gunakan nilai lama
  CartItem copyWith({int? jumlah}) {
    return CartItem(
      nama: nama,
      harga: harga,
      gambar: gambar,
      icon: icon,
      jumlah: jumlah ?? this.jumlah, // Gunakan jumlah baru atau lama
      stokAwal: stokAwal,
    );
  }
}