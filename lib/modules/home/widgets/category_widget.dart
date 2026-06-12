import 'package:flutter/material.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import '../../../core/constants/app_color.dart';

// Model data sederhana untuk Item Kategori
class CategoryItem {
  final String title;
  final IconData icon;
  final Color color;

  CategoryItem({required this.title, required this.icon, required this.color});
}

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // List data kategori (Silakan sesuaikan dengan kebutuhan tokomu)
    final List<CategoryItem> categories = [
      CategoryItem(
        title: "Pakaian",
        icon: MingCuteIcons.mgc_shirt_line,
        color: Colors.blue.shade50,
      ),
      CategoryItem(
        title: "Elektronik",
        icon: MingCuteIcons.mgc_device_line,
        color: Colors.orange.shade50,
      ),
      CategoryItem(
        title: "Sepatu",
        icon: MingCuteIcons.mgc_shoe_line,
        color: Colors.green.shade50,
      ),
      CategoryItem(
        title: "Makanan",
        icon: MingCuteIcons.mgc_cookie_line,
        color: Colors.red.shade50,
      ),
    ];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Judul Seksi Kategori
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Kategori Pilihan",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Aksi ketika "Lihat Semua" diklik
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 30),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    "Lihat Semua",
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Baris Item Kategori (Horizontal)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: categories.map((item) {
              return InkWell(
                onTap: () {
                  print("Kategori ${item.title} diklik");
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 75,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      // Lingkaran Background Icon
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: item.color,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          item.icon,
                          color: AppColors
                              .primaryColor, // Menggunakan warna utama aplikasi
                          size: 26,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Teks Label Kategori
                      Text(
                        item.title,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
