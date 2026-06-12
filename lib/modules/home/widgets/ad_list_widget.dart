import 'package:flutter/material.dart';
import '../../../core/constants/app_color.dart';
import '../../ads/pages/ad_detail.dart';

class AdProductItem {
  final String imageUrl;
  final String category;
  final String title;
  final double price;

  AdProductItem({
    required this.imageUrl,
    required this.category,
    required this.title,
    required this.price,
  });
}

class AdListWidget extends StatelessWidget {
  const AdListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy produk iklan / jualan
    final List<AdProductItem> products = [
      AdProductItem(
        imageUrl:
            "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500&q=80",
        category: "Sepatu",
        title: "Nike Air Max Berlari Cepat",
        price: 1500000,
      ),
      AdProductItem(
        imageUrl:
            "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&q=80",
        category: "Elektronik",
        title: "Sony Headphone Bluetooth",
        price: 3200000,
      ),
      AdProductItem(
        imageUrl:
            "https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500&q=80",
        category: "Aksesoris",
        title: "Jam Tangan Minimalis Putih",
        price: 850000,
      ),
      AdProductItem(
        imageUrl:
            "https://images.unsplash.com/photo-1560343090-f0409e92791a?w=500&q=80",
        category: "Sepatu",
        title: "Sepatu Kulit Formal Premium",
        price: 1200000,
      ),
    ];

    // Fungsi helper sederhana untuk format mata uang Rupiah
    String formatRupiah(double amount) {
      return "Rp ${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Rekomendasi Produk",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),

          // GRID 2 KOLOM (KANAN - KIRI)
          GridView.builder(
            shrinkWrap: true, // Mengikuti tinggi total konten di dalamnya
            physics:
                const NeverScrollableScrollPhysics(), // Menyerahkan kontrol scroll ke ListView utama
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Membagi layar menjadi 2 kolom
              crossAxisSpacing: 12, // Jarak horizontal antar card
              mainAxisSpacing: 12, // Jarak vertikal antar card
              childAspectRatio: 0.73, // Mengatur rasio proporsi tinggi card
            ),
            itemBuilder: (context, index) {
              final product = products[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // Kirim ID (misalnya kita pakai index + 1 sebagai simulasi ID produk)
                      builder: (context) => AdDetailPage(id: index + 1),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. AREA GAMBAR & BADGE CATEGORY
                      Expanded(
                        child: Stack(
                          children: [
                            // Gambar Utama Produk
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                                child: Image.network(
                                  product.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // BADGE CATEGORY (Melayang di atas gambar)
                            Positioned(
                              top: 8,
                              left: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      (AppColors.primaryColor ?? Colors.indigo)
                                          .withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  product.category,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // 2. AREA INFORMASI TEKS (JUDUL & HARGA)
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Judul Produk
                            Text(
                              product.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: Colors.black87,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 6),
                            // Harga Produk
                            Text(
                              formatRupiah(product.price),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: AppColors.primaryColor ?? Colors.indigo,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
