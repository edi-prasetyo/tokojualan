import 'package:flutter/material.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import '../../../core/constants/app_color.dart';
import '../../ads/pages/ad_detail.dart';

class AdHighlightItem {
  final int id;
  final String imageUrl;
  final String category;
  final String title;
  final String description;
  final double price;

  AdHighlightItem({
    required this.id,
    required this.imageUrl,
    required this.category,
    required this.title,
    required this.description,
    required this.price,
  });
}

class AdHighlightWidget extends StatelessWidget {
  const AdHighlightWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<AdHighlightItem> products = [
      AdHighlightItem(
        id: 1,
        imageUrl:
            "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500&q=80",
        category: "Sepatu",
        title: "Nike Air Max Berlari Cepat",
        description:
            "Bantalan empuk, ringan, cocok untuk marathon maupun harian.",
        price: 1500000,
      ),
      AdHighlightItem(
        id: 2,
        imageUrl:
            "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&q=80",
        category: "Elektronik",
        title: "Sony Headphone Bluetooth",
        description:
            "Fitur peredam suara bising terbaik untuk kenyamanan musik Anda.",
        price: 3200000,
      ),
      AdHighlightItem(
        id: 3,
        imageUrl:
            "https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500&q=80",
        category: "Aksesoris",
        title: "Jam Tangan Minimalis Putih",
        description:
            "Desain elegan nan mewah, tahan air dan goresan kaca safir.",
        price: 850000,
      ),
    ];

    String formatRupiah(double amount) {
      return "Rp ${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Judul Seksi dengan Icon Star
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: (AppColors.primaryColor ?? Colors.indigo).withOpacity(
                    0.1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  MingCuteIcons.mgc_star_fill,
                  color: AppColors.primaryColor ?? Colors.indigo,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                "Iklan Highlight",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),

        // List View Horizontal
        SizedBox(
          height: 275,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];

              return Container(
                width: 180,
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdDetailPage(id: product.id),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      // 1. MENGGANTI BACKGROUND MENJADI WARNA SOFT CREAM MODERN
                      color: AppColors.primaryColor.withValues(alpha: 0.07),
                      borderRadius: BorderRadius.circular(12),
                      // 2. MODIFIKASI BORDER AGAR SENADA DENGAN WARNA CREAM
                      // border: Border.all(color: const Color(0xFFF5EFE0)),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: const Color(0xFFD6CBB3).withOpacity(0.15),
                      //     blurRadius: 6,
                      //     offset: const Offset(0, 3),
                      //   ),
                      // ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Area Gambar & Badge
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFDFBF7),
                                  borderRadius: BorderRadius.only(
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
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                ),
                              ),
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
                                        (AppColors.primaryColor ??
                                                Colors.indigo)
                                            .withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    product.category,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Area Informasi Teks
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                product.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors
                                      .grey
                                      .shade600, // Sedikit digelapkan agar kontras di atas warna cream
                                  height: 1.3,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                formatRupiah(product.price),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color:
                                      AppColors.primaryColor ?? Colors.indigo,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
