import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_color.dart';
import '../widgets/ad_highlight_widget.dart';
import '../widgets/header_widget.dart';
import '../widgets/category_widget.dart';
import '../widgets/ad_list_widget.dart';
import '../widgets/home_filter_widget.dart'; // <--- IMPORT WIDGET AD LIST BARU

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBody,
      body: SafeArea(
        child: ListView(
          children: [
            // 1. Header Aplikasi
            const HeaderWidget(),

            const SizedBox(height: 8),

            const HomeFilterWidget(),

            const SizedBox(height: 8),

            // 2. Widget Kategori
            const CategoryWidget(),

            const AdHighlightWidget(),

            // 3. DAFTAR IKLAN (KARTU VERTIKAL DOWN)
            const AdListWidget(),

            // 4. Konten Produk/Lainnya
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Produk Terbaru",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text("Data produk akan tampil di sini..."),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
