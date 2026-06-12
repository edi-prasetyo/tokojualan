import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import '../../../core/constants/app_color.dart';

class AdDetailPage extends ConsumerWidget {
  final int
  id; // ID yang dikirim dari card untuk fetch data spesifik jika perlu

  const AdDetailPage({super.key, required this.id});

  // Fungsi helper format Rupiah
  String formatRupiah(double amount) {
    return "Rp ${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // INFO: Di dunia nyata, kamu bisa menggunakan 'id' ini untuk memanggil provider API
    // Contoh: final product = ref.watch(productDetailProvider(id));

    // Data dummy simulasi berdasarkan id yang masuk
    final String title = id == 1
        ? "Nike Air Max Berlari Cepat"
        : "Sony Headphone Bluetooth";
    final String category = id == 1 ? "Sepatu" : "Elektronik";
    final double price = id == 1 ? 1500000 : 3200000;
    final String imageUrl = id == 1
        ? "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=800&q=80"
        : "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=800&q=80";

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // 1. BANNER GAMBAR ATAS DENGAN EFEK COLLAPSING
          SliverAppBar(
            expandedHeight: 320,
            pinned: true, // Membuat header/tombol back tetap ada saat di-scroll
            backgroundColor: Colors.white,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.black.withOpacity(0.4),
                child: IconButton(
                  icon: const Icon(
                    MingCuteIcons.mgc_arrow_left_line,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.4),
                  child: IconButton(
                    icon: const Icon(
                      MingCuteIcons.mgc_share_forward_line,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(imageUrl, fit: BoxFit.cover),
            ),
          ),

          // 2. KONTEN DETAIL PRODUK / IKLAN
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badge Kategori
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: (AppColors.primaryColor ?? Colors.indigo)
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Judul Produk
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Harga Produk
                  Text(
                    formatRupiah(price),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor ?? Colors.indigo,
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(color: Color(0xFFF1F5F9), thickness: 2),
                  ),

                  // Deskripsi
                  const Text(
                    "Deskripsi Produk",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Ini adalah deskripsi lengkap dari produk atau jasa iklan komersial yang sedang kamu pilih. Produk ini dijamin asli 100% dengan garansi resmi dan kualitas terbaik yang sangat ramah di kantong konsumen cerdas.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      height: 1.5,
                    ),
                  ),

                  // Jeda Spacer bawah agar konten tidak tertutup bar tombol aksi belanja
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),

      // 3. TOMBOL PERINTAH AKSI DI BAWAH (STICKY BOTTOM ACTION BAR)
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade100)),
        ),
        child: Row(
          children: [
            // Tombol Chat / Pesan Samping
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: Icon(
                  MingCuteIcons.mgc_message_2_line,
                  color: AppColors.primaryColor,
                ),
                onPressed: () {},
              ),
            ),
            const SizedBox(width: 12),

            // Tombol Utama Transaksi
            Expanded(
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Beli & Hubungi Penjual",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
