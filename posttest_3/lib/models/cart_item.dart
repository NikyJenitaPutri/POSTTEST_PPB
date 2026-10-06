// import Material: dibutuhkan untuk IconData (tipe data ikon)
import 'package:flutter/material.dart';

// ============================================================
// CartItem = MODEL DATA (bukan widget)
// Kegunaan: merepresentasikan 1 produk yang masuk keranjang
// Konsep  : immutable data class (field final) + copyWith
// ============================================================
class CartItem {
  final String nama;   // identitas produk, dipakai sebagai key pencarian
  final int harga;     // harga satuan, tidak berubah
  final String gambar; // path asset gambar produk
  final IconData icon; // ikon fallback jika gambar gagal dimuat

  // STATE: quantity di keranjang — satu-satunya field yang berubah
  // Kegunaan: menyimpan berapa banyak produk ini dibeli user
  int jumlah;

  // stokAwal = stok asli produk, statis
  // Sisa stok real-time dihitung CartState:
  //   sisaStok = stokAwal - jumlahDiKeranjang
  final int stokAwal;

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
  // Konsep  : CartState tidak memutasi objek lama, tapi menggantinya
  CartItem copyWith({int? jumlah}) {
    return CartItem(
      nama: nama,
      harga: harga,
      gambar: gambar,
      icon: icon,
      jumlah: jumlah ?? this.jumlah,
      stokAwal: stokAwal,
    );
  }
}