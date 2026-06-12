import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/search_controller.dart';

class FilterWidget extends ConsumerStatefulWidget {
  const FilterWidget({super.key});

  @override
  ConsumerState<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends ConsumerState<FilterWidget> {
  final _minPriceController = TextEditingController();
  final _maxPriceController = TextEditingController();

  final List<Map<String, String>> _sortOptions = [
    {'value': 'terbaru', 'label': 'Terbaru'},
    {'value': 'terlama', 'label': 'Terlama'},
    {'value': 'termurah', 'label': 'Harga Terendah'},
    {'value': 'termahal', 'label': 'Harga Tertinggi'},
  ];

  @override
  void initState() {
    super.initState();
    final currentFilter = ref.read(searchFilterProvider);
    _minPriceController.text = currentFilter.priceMin ?? '';
    _maxPriceController.text = currentFilter.priceMax ?? '';
  }

  @override
  void dispose() {
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filterState = ref.watch(searchFilterProvider);
    final filterNotifier = ref.read(searchFilterProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Filter Iklan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {
              filterNotifier.clearFilter();
              _minPriceController.clear();
              _maxPriceController.clear();
            },
            child: const Text('Reset', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ⏱️ SEKSI URUTAN (SORTING)
            const Text(
              'Urutkan Berdasarkan',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              children: _sortOptions.map((opt) {
                final isSelected = filterState.sortBy == opt['value'];
                return ChoiceChip(
                  label: Text(opt['label']!),
                  selected: isSelected,
                  selectedColor: Colors.indigo.withOpacity(0.2),
                  onSelected: (_) => filterNotifier.updateSortBy(opt['value']!),
                );
              }).toList(),
            ),
            const Divider(height: 40),

            // 💰 SEKSI FILTER HARGA
            const Text(
              'Rentang Harga (Rp)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _minPriceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Minimal',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text('-'),
                ),
                Expanded(
                  child: TextField(
                    controller: _maxPriceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Maksimal',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 40),

            // 📁 SEKSI FILTER KATEGORI (SIMULASI ID)
            const Text(
              'Kategori',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(filterState.categoryName ?? 'Pilih Kategori Iklan'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Di sini Anda bisa mengarahkan ke halaman list kategori dari API.
                // Sebagai demo, kita set kategori static id 9 (Kucing Persia seperti data API Anda).
                filterNotifier.updateCategory(9, "Kucing (9)");
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              // Simpan data harga dari text controller ke state global sebelum apply
              filterNotifier.updatePriceMin(
                _minPriceController.text.isEmpty
                    ? null
                    : _minPriceController.text,
              );
              filterNotifier.updatePriceMax(
                _maxPriceController.text.isEmpty
                    ? null
                    : _maxPriceController.text,
              );

              Navigator.pop(
                context,
                true,
              ); // kembalikan nilai true untuk refresh data di search page
            },
            child: const Text(
              'Terapkan Filter',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
