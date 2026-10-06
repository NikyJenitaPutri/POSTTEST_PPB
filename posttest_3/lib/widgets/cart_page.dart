import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // FilteringTextInputFormatter

import '../state/cart_state.dart';
import '../models/cart_item.dart';

// ============================================================
// CartPage = HALAMAN KERANJANG (StatelessWidget)
//
// KONSEP: seluruh isi dalam 1 SingleChildScrollView
//         UI reaktif via ListenableBuilder ke CartState
// KEGUNAAN: menampilkan daftar item + ringkasan + tombol checkout
// ============================================================
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold: kerangka halaman (background, body)
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6F0),
      // SafeArea: hindari notch / status bar / home indicator
      body: SafeArea(
        // ListenableBuilder: mendengarkan CartState
        // Kegunaan: rebuild otomatis saat notifyListeners() dipanggil
        child: ListenableBuilder(
          listenable: CartState.instance,
          builder: (context, _) {
            final items = CartState.instance.items;

            // SingleChildScrollView: seluruh konten ikut scroll
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              // Column: menyusun anak secara vertikal
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ========================================================
                  // HEADER
                  // ========================================================
                  // Row: menyusun anak secara horizontal
                  Row(
                    children: [
                      // Kondisional: back button kalau di-push, logo kalau tab
                      if (Navigator.canPop(context))
                        // GestureDetector: mendeteksi tap (alternatif InkWell)
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          // Container: kotak dengan dekorasi (radius, shadow)
                          child: Container(
                            width: 42,
                            height: 42,
                            // BoxDecoration: warna, radius, boxShadow
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
                            // Icon: menampilkan ikon panah kembali
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
                                color: const Color(0xFF6B1F1F)
                                    .withOpacity(0.25),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          // clipBehavior: memotong anak sesuai radius
                          clipBehavior: Clip.antiAlias,
                          // Image.asset: gambar dari folder assets
                          // errorBuilder: fallback kalau gambar gagal dimuat
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 42,
                            height: 42,
                            // BoxFit.cover: gambar mengisi seluruh area
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                decoration: BoxDecoration(
                                  // LinearGradient: gradien linear warna
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF6B1F1F),
                                      Color(0xFFB5474A)
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                    Icons.shopping_bag_rounded,
                                    color: Colors.white,
                                    size: 22),
                              );
                            },
                          ),
                        ),
                      // SizedBox: memberi jarak / ukuran tetap
                      const SizedBox(width: 12),
                      // Expanded: anak mengisi ruang sisa di Row
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text: menampilkan teks judul
                            Text(
                              'Keranjang',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF2B0000),
                                letterSpacing: -0.5,
                              ),
                            ),
                            Text(
                              'Pesananmu',
                              style: TextStyle(
                                  fontSize: 11, color: Color(0xFFB8A8A0)),
                            ),
                          ],
                        ),
                      ),
                      // Badge jumlah jenis item
                      if (items.isNotEmpty)
                        Container(
                          // EdgeInsets.symmetric: padding horizontal/vertical
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6B1F1F)
                                .withOpacity(0.08),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${items.length} item',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF6B1F1F),
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // ========================================================
                  // STATE KONDISIONAL:
                  //   kosong → _buildKeranjangKosong()
                  //   ada    → daftar item + ringkasan + checkout
                  // KONSEP : spread operator ... untuk sebar list widget
                  // ========================================================
                  if (items.isEmpty)
                    _buildKeranjangKosong()
                  else ...[
                    // ...map: setiap item dirender jadi _CartItemTile
                    ...items.map((item) => _CartItemTile(item: item)),

                    const SizedBox(height: 8),

                    // ---------- RINGKASAN PESANAN ----------
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF6B1F1F).withOpacity(0.06),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              // Aksen garis gradien di kiri judul
                              Container(
                                width: 4,
                                height: 18,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF6B1F1F),
                                      Color(0xFFD4A574)
                                    ],
                                    // begin/end: arah gradien
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'Ringkasan Pesanan',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF2B0000),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Helper widget untuk baris label-nilai
                          _barisRingkasan(
                            'Subtotal',
                            CartState.formatRupiah(
                                CartState.instance.subtotal),
                          ),
                          const SizedBox(height: 10),
                          _barisRingkasan(
                            'Pajak (10%)',
                            CartState.formatRupiah(
                                CartState.instance.pajak),
                          ),
                          const SizedBox(height: 16),
                          // Divider manual (Container tipis)
                          Container(
                            height: 1,
                            color: const Color(0xFF6B1F1F)
                                .withOpacity(0.08),
                          ),
                          const SizedBox(height: 16),
                          // spaceBetween: dorong ke ujung kiri & kanan
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF2B0000),
                                ),
                              ),
                              Text(
                                CartState.formatRupiah(
                                    CartState.instance.total),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF6B1F1F),
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ======================================================
                    // TOMBOL CHECKOUT
                    // ======================================================
                    SizedBox(
                      width: double.infinity,
                      // ElevatedButton: tombol utama (aksen Material)
                      // onPressed memanggil dialog konfirmasi
                      child: ElevatedButton(
                        // ElevatedButton.styleFrom: atur style tombol
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6B1F1F),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          elevation: 0, // hilangkan shadow bawaan
                          shadowColor: Colors.transparent,
                          // RoundedRectangleBorder: bentuk tombol radius
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () => _showCheckoutDialog(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.lock_rounded, size: 18),
                            const SizedBox(width: 8),
                            const Text(
                              'Checkout Sekarang',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                                letterSpacing: 0.2,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward_rounded,
                                size: 18),
                          ],
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // Helper: baris label-nilai — dipakai berkali-kali
  Widget _barisRingkasan(String label, String nilai) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF8B6F6F),
          ),
        ),
        Text(
          nilai,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2B0000),
          ),
        ),
      ],
    );
  }

  // Helper: empty state — keranjang kosong
  Widget _buildKeranjangKosong() {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xFF6B1F1F).withOpacity(0.06),
                // BoxShape.circle: bentuk lingkaran
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.shopping_bag_outlined,
                  size: 56, color: Color(0xFF6B1F1F)),
            ),
            const SizedBox(height: 20),
            const Text(
              'Keranjangmu masih kosong',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Color(0xFF2B0000),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Yuk, pilih menu favoritmu dulu!',
              style: TextStyle(fontSize: 12, color: Color(0xFF8B6F6F)),
            ),
          ],
        ),
      ),
    );
  }

  // Konsep: showDialog = modal pop-up
  // Kegunaan: konfirmasi checkout berhasil
  void _showCheckoutDialog(BuildContext context) {
    showDialog(
      context: context,
      // builder: fungsi yang mengembalikan widget dialog
      builder: (ctx) => Dialog(
        // RoundedRectangleBorder: bentuk dialog dengan radius
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            // MainAxisSize.min: tinggi hanya sebesar konten
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6B1F1F), Color(0xFFB5474A)],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6B1F1F).withOpacity(0.35),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(Icons.check_rounded,
                    color: Colors.white, size: 40),
              ),
              const SizedBox(height: 18),
              const Text(
                'Checkout Berhasil!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2B0000),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Terima kasih sudah memesan',
                style: TextStyle(fontSize: 12, color: Color(0xFF8B6F6F)),
              ),
              const SizedBox(height: 18),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDF6F0),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Total Pembayaran',
                      style: TextStyle(
                          fontSize: 11, color: Color(0xFF8B6F6F)),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      CartState.formatRupiah(CartState.instance.total),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF6B1F1F),
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B1F1F),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    // Tutup dialog, lalu kosongkan keranjang
                    Navigator.pop(ctx);
                    CartState.instance.clear();
                  },
                  child: const Text('OK',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// _CartItemTile = WIDGET PER ITEM KERANJANG (StatefulWidget)
//
// STATE LOKAL: _qtyController (TextEditingController untuk TextField)
// LIFECYCLE (Modul 4):
//   - initState       : inisialisasi controller
//   - didUpdateWidget : sinkronkan controller saat jumlah berubah luar
//   - dispose         : bersihkan controller (hindari memory leak)
// KEGUNAAN: tampilkan gambar + nama + harga + kontrol quantity + hapus
// =====================================================================
class _CartItemTile extends StatefulWidget {
  final CartItem item;
  const _CartItemTile({required this.item});

  @override
  State<_CartItemTile> createState() => _CartItemTileState();
}

class _CartItemTileState extends State<_CartItemTile> {
  // TextEditingController: controller TextField (baca/tulis isi field)
  late TextEditingController _qtyController;

  // initState: dipanggil sekali saat widget pertama dibuat
  // Kegunaan: inisialisasi controller dengan nilai awal jumlah
  @override
  void initState() {
    super.initState();
    _qtyController = TextEditingController(text: '${widget.item.jumlah}');
  }

  // didUpdateWidget: dipanggil saat widget induk rebuild widget ini
  // Kegunaan: sinkronkan teks controller jika jumlah berubah dari luar
  @override
  void didUpdateWidget(covariant _CartItemTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.item.jumlah != widget.item.jumlah &&
        _qtyController.text != '${widget.item.jumlah}') {
      _qtyController.text = '${widget.item.jumlah}';
    }
  }

  // dispose: dipanggil saat widget dihapus dari tree
  // Kegunaan: bersihkan resource (controller)
  @override
  void dispose() {
    _qtyController.dispose();
    super.dispose();
  }

  // Kegunaan: validasi input manual TextField
  void _updateQuantity(String value) {
    final parsed = int.tryParse(value); // null kalau bukan angka
    if (parsed == null || parsed < 1) return; // tolak input tidak valid
    final maksimal = widget.item.stokAwal;
    final aman = parsed > maksimal ? maksimal : parsed; // clamp ke stok
    // Update state global (bukan setState lokal)
    CartState.instance.changeQuantity(widget.item.nama, aman);
  }

  // Kegunaan: tombol + , jika melebihi stok → SnackBar peringatan
  void _increment() {
    final jumlahBaru = widget.item.jumlah + 1;
    if (jumlahBaru > widget.item.stokAwal) {
      // ScaffoldMessenger: menampilkan SnackBar (pesan sementara)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Stok maksimal ${widget.item.stokAwal} untuk ${widget.item.nama}',
          ),
          duration: const Duration(seconds: 1),
          backgroundColor: const Color(0xFF6B1F1F),
          // SnackBarBehavior.floating: posisi mengambang
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ),
      );
      return;
    }
    CartState.instance.changeQuantity(widget.item.nama, jumlahBaru);
  }

  // Kegunaan: tombol − , jika hasil 0 → CartState hapus item
  void _decrement() => CartState.instance
      .changeQuantity(widget.item.nama, widget.item.jumlah - 1);

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return Container(
      width: double.infinity,
      // EdgeInsets.only(bottom: 12): jarak bawah saja
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B1F1F).withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          // Thumbnail gambar produk + fallback icon
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFFFDF6F0),
              borderRadius: BorderRadius.circular(14),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(
              item.gambar,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Icon(item.icon,
                  color: const Color(0xFF6B1F1F), size: 28),
            ),
          ),
          const SizedBox(width: 12),

          // Info + kontrol quantity
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.nama,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF2B0000),
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  CartState.formatRupiah(item.harga),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF6B1F1F),
                  ),
                ),
                const SizedBox(height: 8),

                Row(
                  children: [
                    // Tombol minus (GestureDetector + Container bundar)
                    GestureDetector(
                      onTap: _decrement,
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFDF6F0),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: const Icon(Icons.remove_rounded,
                            size: 16, color: Color(0xFF6B1F1F)),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // TextField quantity
                    // - keyboardType: tipe keyboard (number)
                    // - inputFormatters: batasi karakter yang boleh masuk
                    // - onChanged/onSubmitted: callback update state
                    SizedBox(
                      width: 42,
                      height: 30,
                      child: TextField(
                        controller: _qtyController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          // Hanya izinkan digit
                          FilteringTextInputFormatter.digitsOnly,
                          // Batasi panjang 2 karakter
                          LengthLimitingTextInputFormatter(2),
                        ],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF2B0000),
                        ),
                        onChanged: _updateQuantity,
                        onSubmitted: _updateQuantity,
                        // InputDecoration: dekorasi TextField
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          filled: true,
                          fillColor: const Color(0xFFFDF6F0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Tombol plus
                    GestureDetector(
                      onTap: _increment,
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF6B1F1F), Color(0xFFB5474A)],
                          ),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: const Icon(Icons.add_rounded,
                            size: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Tombol hapus item + SnackBar konfirmasi
          GestureDetector(
            onTap: () {
              CartState.instance.removeItem(item.nama);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${item.nama} dihapus, stok dikembalikan',
                  ),
                  duration: const Duration(seconds: 1),
                  backgroundColor: const Color(0xFF6B1F1F),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  margin: const EdgeInsets.all(16),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF6B1F1F).withOpacity(0.06),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.delete_outline_rounded,
                  color: Color(0xFF6B1F1F), size: 18),
            ),
          ),
        ],
      ),
    );
  }
}