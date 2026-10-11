import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../models/cart_item.dart';

// CartPage: halaman keranjang (StatelessWidget) karena state sepenuhnya dari CartProvider
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold: kerangka halaman dengan background dan body
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6F0), // Warna latar halaman
      // SafeArea: menghindari notch & status bar
      body: SafeArea(
        // Modul 5: Consumer<CartProvider> → rebuild saat state berubah
        // Consumer: mendengarkan perubahan CartProvider dan membangun ulang UI
        child: Consumer<CartProvider>(
          builder: (context, cart, _) {
            // items: daftar item di keranjang dari CartProvider
            final items = cart.items;

            // SingleChildScrollView: memungkinkan halaman discroll
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24), // Padding halaman
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
                          onTap: () => Navigator.pop(context), // Kembali
                          // Container: tombol bulat putih dengan bayangan
                          child: Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF6B1F1F).withValues(alpha: 0.08),
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
                                color: const Color(0xFF6B1F1F).withValues(alpha: 0.25),
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
                                // Icon: ikon keranjang sebagai fallback
                                child: const Icon(Icons.shopping_bag_rounded,
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
                            // Text: judul "Keranjang"
                            Text(
                              'Keranjang',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF2B0000),
                                letterSpacing: -0.5,
                              ),
                            ),
                            // Text: subjudul "Pesananmu"
                            Text(
                              'Pesananmu',
                              style: TextStyle(
                                  fontSize: 11, color: Color(0xFFB8A8A0)),
                            ),
                          ],
                        ),
                      ),
                      // Kondisi: jika ada item, tampilkan badge jumlah item
                      if (items.isNotEmpty)
                        // Container: badge jumlah item
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color:
                                const Color(0xFF6B1F1F).withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          // Text: jumlah item
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
                  const SizedBox(height: 20), // Jarak vertikal 20

                  // Kondisi: jika keranjang kosong, tampilkan empty state
                  if (items.isEmpty)
                    _buildKeranjangKosong()
                  else ...[
                    // ...items.map: menyebarkan _CartItemTile untuk setiap item
                    ...items.map((item) => _CartItemTile(item: item)),
                    const SizedBox(height: 8),

                    // RINGKASAN
                    // Container: kartu ringkasan pesanan
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color:
                                const Color(0xFF6B1F1F).withValues(alpha: 0.06),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      // Column: menyusun konten ringkasan secara vertikal
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Row: judul "Ringkasan Pesanan" dengan aksen
                          Row(
                            children: [
                              // Container: garis aksen kecil
                              Container(
                                width: 4,
                                height: 18,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF6B1F1F),
                                      Color(0xFFD4A574)
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              const SizedBox(width: 10),
                              // Text: judul ringkasan
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
                          // _barisRingkasan: helper untuk baris subtotal
                          _barisRingkasan('Subtotal',
                              CartProvider.formatRupiah(cart.subtotal)),
                          const SizedBox(height: 10),
                          // _barisRingkasan: helper untuk baris pajak
                          _barisRingkasan('Pajak (10%)',
                              CartProvider.formatRupiah(cart.pajak)),
                          const SizedBox(height: 16),
                          // Container: garis pemisah
                          Container(
                            height: 1,
                            color:
                                const Color(0xFF6B1F1F).withValues(alpha: 0.08),
                          ),
                          const SizedBox(height: 16),
                          // Row: baris total
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              // Text: label "Total"
                              const Text(
                                'Total',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF2B0000),
                                ),
                              ),
                              // Text: nilai total
                              Text(
                                CartProvider.formatRupiah(cart.total),
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

                    // TOMBOL CHECKOUT
                    // SizedBox: wadah untuk tombol checkout lebar penuh
                    SizedBox(
                      width: double.infinity,
                      // ElevatedButton: tombol checkout
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6B1F1F), // Warna latar tombol
                          foregroundColor: Colors.white, // Warna teks/ikon
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          elevation: 0, // Tanpa elevasi
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () => _showCheckoutDialog(context), // Buka dialog checkout
                        // Row: ikon dan teks tombol
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Icon: ikon gembok
                            Icon(Icons.lock_rounded, size: 18),
                            SizedBox(width: 8),
                            // Text: teks tombol
                            Text(
                              'Checkout Sekarang',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                                letterSpacing: 0.2,
                              ),
                            ),
                            SizedBox(width: 8),
                            // Icon: ikon panah
                            Icon(Icons.arrow_forward_rounded, size: 18),
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

  // Helper: baris ringkasan (label kiri, nilai kanan)
  Widget _barisRingkasan(String label, String nilai) {
    // Row: menyusun label dan nilai secara horizontal
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Text: label
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF8B6F6F),
          ),
        ),
        // Text: nilai
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

  // Helper: tampilan keranjang kosong
  Widget _buildKeranjangKosong() {
    // SizedBox: wadah untuk empty state
    return SizedBox(
      width: double.infinity,
      // Padding: memberi jarak vertikal
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100),
        // Column: menyusun konten empty state secara vertikal
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container: lingkaran latar ikon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xFF6B1F1F).withValues(alpha: 0.06),
                shape: BoxShape.circle,
              ),
              // Icon: ikon keranjang kosong
              child: const Icon(Icons.shopping_bag_outlined,
                  size: 56, color: Color(0xFF6B1F1F)),
            ),
            const SizedBox(height: 20),
            // Text: judul empty state
            const Text(
              'Keranjangmu masih kosong',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Color(0xFF2B0000),
              ),
            ),
            const SizedBox(height: 6),
            // Text: saran untuk empty state
            const Text(
              'Yuk, pilih menu favoritmu dulu!',
              style: TextStyle(fontSize: 12, color: Color(0xFF8B6F6F)),
            ),
          ],
        ),
      ),
    );
  }

  // Modul 5: context.read<CartProvider>() untuk baca state
  // dalam dialog tanpa subscribe
  // _showCheckoutDialog: menampilkan dialog konfirmasi checkout
  void _showCheckoutDialog(BuildContext context) {
    // context.read: mengambil CartProvider tanpa mendengarkan perubahan
    final cart = context.read<CartProvider>();
    // showDialog: menampilkan dialog di atas layar
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        // Padding: memberi jarak di dalam dialog
        child: Padding(
          padding: const EdgeInsets.all(24),
          // Column: menyusun konten dialog secara vertikal
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Container: ikon centang dengan gradien
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
                      color: const Color(0xFF6B1F1F).withValues(alpha: 0.35),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                // Icon: ikon centang
                child: const Icon(Icons.check_rounded,
                    color: Colors.white, size: 40),
              ),
              const SizedBox(height: 18),
              // Text: judul "Checkout Berhasil!"
              const Text(
                'Checkout Berhasil!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2B0000),
                ),
              ),
              const SizedBox(height: 6),
              // Text: pesan terima kasih
              const Text(
                'Terima kasih sudah memesan',
                style: TextStyle(fontSize: 12, color: Color(0xFF8B6F6F)),
              ),
              const SizedBox(height: 18),
              // Container: kotak total pembayaran
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDF6F0),
                  borderRadius: BorderRadius.circular(14),
                ),
                // Column: label dan nilai total
                child: Column(
                  children: [
                    // Text: label "Total Pembayaran"
                    const Text(
                      'Total Pembayaran',
                      style:
                          TextStyle(fontSize: 11, color: Color(0xFF8B6F6F)),
                    ),
                    const SizedBox(height: 4),
                    // Text: nilai total
                    Text(
                      CartProvider.formatRupiah(cart.total),
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
              // SizedBox: wadah tombol OK
              SizedBox(
                width: double.infinity,
                // ElevatedButton: tombol OK
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B1F1F),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    Navigator.pop(ctx); // Tutup dialog
                    // Modul 5: panggil method CartProvider → notifyListeners
                    context.read<CartProvider>().clear(); // Kosongkan keranjang
                  },
                  // Text: teks "OK"
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

// _CartItemTile — pakai context.read<CartProvider>() di callback

// _CartItemTile: StatefulWidget untuk setiap item di keranjang
class _CartItemTile extends StatefulWidget {
  final CartItem item; // Item keranjang
  const _CartItemTile({required this.item});

  @override
  State<_CartItemTile> createState() => _CartItemTileState();
}

class _CartItemTileState extends State<_CartItemTile> {
  // State: _qtyController mengontrol input jumlah pada TextField
  late TextEditingController _qtyController;

  // initState: inisialisasi controller dengan jumlah awal
  @override
  void initState() {
    super.initState();
    _qtyController = TextEditingController(text: '${widget.item.jumlah}');
  }

  // didUpdateWidget: memperbarui controller jika jumlah item berubah dari luar
  @override
  void didUpdateWidget(covariant _CartItemTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.item.jumlah != widget.item.jumlah &&
        _qtyController.text != '${widget.item.jumlah}') {
      _qtyController.text = '${widget.item.jumlah}';
    }
  }

  // dispose: membersihkan resource controller
  @override
  void dispose() {
    _qtyController.dispose();
    super.dispose();
  }

  // _updateQuantity: memperbarui jumlah berdasarkan input teks
  void _updateQuantity(String value) {
    final parsed = int.tryParse(value);
    if (parsed == null || parsed < 1) return; // Abaikan jika tidak valid
    final maksimal = widget.item.stokAwal; // Stok maksimal
    final aman = parsed > maksimal ? maksimal : parsed; // Batasi dengan stok
    // Modul 5: context.read → akses provider tanpa listen
    context.read<CartProvider>().changeQuantity(widget.item.nama, aman);
  }

  // _increment: menambah jumlah item
  void _increment() {
    final cart = context.read<CartProvider>();
    final jumlahBaru = widget.item.jumlah + 1;
    if (jumlahBaru > widget.item.stokAwal) {
      // ScaffoldMessenger: menampilkan SnackBar jika melebihi stok
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Stok maksimal ${widget.item.stokAwal} untuk ${widget.item.nama}',
          ),
          duration: const Duration(seconds: 1),
          backgroundColor: const Color(0xFF6B1F1F),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ),
      );
      return;
    }
    cart.changeQuantity(widget.item.nama, jumlahBaru);
  }

  // _decrement: mengurangi jumlah item
  void _decrement() {
    context
        .read<CartProvider>()
        .changeQuantity(widget.item.nama, widget.item.jumlah - 1);
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    // Container: kartu item keranjang
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B1F1F).withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      // Row: menyusun gambar, info, dan tombol hapus secara horizontal
      child: Row(
        children: [
          // Container: thumbnail produk
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFFFDF6F0),
              borderRadius: BorderRadius.circular(14),
            ),
            clipBehavior: Clip.antiAlias, // Memotong gambar
            // Image.asset: gambar produk
            child: Image.asset(
              item.gambar,
              fit: BoxFit.cover,
              // errorBuilder: fallback jika gambar gagal
              errorBuilder: (context, error, stackTrace) => Icon(item.icon,
                  color: const Color(0xFF6B1F1F), size: 28),
            ),
          ),
          const SizedBox(width: 12),
          // Expanded: info produk mengisi ruang sisa
          Expanded(
            // Column: menyusun info produk secara vertikal
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text: nama produk
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
                // Text: harga produk
                Text(
                  CartProvider.formatRupiah(item.harga),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF6B1F1F),
                  ),
                ),
                const SizedBox(height: 8),
                // Row: kontrol quantity
                Row(
                  children: [
                    // GestureDetector: tombol kurang
                    GestureDetector(
                      onTap: _decrement,
                      // Container: tombol kurang
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFDF6F0),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        // Icon: ikon minus
                        child: const Icon(Icons.remove_rounded,
                            size: 16, color: Color(0xFF6B1F1F)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // SizedBox: wadah TextField jumlah
                    SizedBox(
                      width: 42,
                      height: 30,
                      // TextField: input jumlah
                      child: TextField(
                        controller: _qtyController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly, // Hanya angka
                          LengthLimitingTextInputFormatter(2), // Maks 2 digit
                        ],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF2B0000),
                        ),
                        onChanged: _updateQuantity, // Update saat teks berubah
                        onSubmitted: _updateQuantity, // Update saat disubmit
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
                    // GestureDetector: tombol tambah
                    GestureDetector(
                      onTap: _increment,
                      // Container: tombol tambah
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF6B1F1F), Color(0xFFB5474A)],
                          ),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        // Icon: ikon plus
                        child: const Icon(Icons.add_rounded,
                            size: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // GestureDetector: tombol hapus item
          GestureDetector(
            onTap: () {
              // Modul 5: context.read untuk update
              context.read<CartProvider>().removeItem(item.nama);
              // ScaffoldMessenger: menampilkan SnackBar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${item.nama} dihapus, stok dikembalikan'),
                  duration: const Duration(seconds: 1),
                  backgroundColor: const Color(0xFF6B1F1F),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  margin: const EdgeInsets.all(16),
                ),
              );
            },
            // Container: tombol hapus
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF6B1F1F).withValues(alpha: 0.06),
                shape: BoxShape.circle,
              ),
              // Icon: ikon hapus
              child: const Icon(Icons.delete_outline_rounded,
                  color: Color(0xFF6B1F1F), size: 18),
            ),
          ),
        ],
      ),
    );
  }
}