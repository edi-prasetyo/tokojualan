import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryPage extends ConsumerWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF8FAFC,
      ), // Warna bg sedikit abu-abu agar card putih stand out
      appBar: AppBar(
        title: const Text("Pilih Kategori"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Text('data'),
    );
  }
}
