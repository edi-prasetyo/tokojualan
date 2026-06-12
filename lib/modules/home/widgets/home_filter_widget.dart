import 'package:flutter/material.dart';
import '../../../core/constants/app_color.dart';
import '../../search/pages/search_page.dart';
import '../../search/widgets/filter_widget.dart';

class HomeFilterWidget extends StatelessWidget {
  const HomeFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: InkWell(
        onTap: () async {
          // 1. Langsung buka halaman Filter Full Page
          final isApplied = await Navigator.push<bool>(
            context,
            MaterialPageRoute(builder: (context) => const FilterWidget()),
          );

          // 2. Jika user menekan "Terapkan Filter" (mengembalikan nilai true)
          if (isApplied == true && context.mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchPage()),
            );
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.search, color: Colors.grey, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Buka Filter & Pencarian...",
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: (AppColors.primaryColor).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  Icons.tune,
                  color: AppColors.primaryColor,
                  size: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
