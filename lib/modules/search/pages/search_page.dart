import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/search_controller.dart';
import '../widgets/ad_card_widget.dart';
import '../widgets/filter_widget.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Memantau data iklan dari API (mengembalikan AdResponseModel)
    final searchDataAsync = ref.watch(apiSearchProvider);

    // Memantau dan membaca notifier filter global
    final filterState = ref.watch(searchFilterProvider);
    final filterNotifier = ref.read(searchFilterProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xfff5f7fb),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Container(
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xfff5f7fb),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            // Mengisi kata kunci pencarian awal jika sudah ada di state
            controller: TextEditingController(text: filterState.keyword)
              ..selection = TextSelection.fromPosition(
                TextPosition(offset: filterState.keyword?.length ?? 0),
              ),
            onChanged: (val) {
              filterNotifier.updateKeyword(val);
            },
            decoration: const InputDecoration(
              hintText: 'Cari produk, merk, kategori...',
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
        actions: [
          // TOMBOL TRIGGER FILTER UTAMA (FULL PAGE)
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.tune, color: Colors.black),
                onPressed: () async {
                  // Membuka lembar Filter secara Full Page Route
                  final processFilter = await Navigator.push<bool>(
                    context,
                    MaterialPageRoute(builder: (_) => const FilterWidget()),
                  );

                  if (processFilter == true) {
                    // Refresh provider secara manual jika filter berhasil diaplikasikan
                    ref.invalidate(apiSearchProvider);
                  }
                },
              ),
              // Indikator Titik Merah jika ada filter aktif selain bawaan
              if (filterState.categoryId != null ||
                  filterState.priceMin != null ||
                  filterState.priceMax != null)
                const Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor: Colors.redAccent,
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // 📁 BAR INFORMASI FILTER AKTIF (CHIPS)
          if (filterState.categoryName != null ||
              filterState.priceMin != null ||
              filterState.priceMax != null)
            Container(
              height: 46,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  // Chip Kategori Aktif
                  if (filterState.categoryName != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Chip(
                        label: Text(
                          filterState.categoryName!,
                          style: const TextStyle(fontSize: 12),
                        ),
                        onDeleted: () {
                          filterNotifier.updateCategory(null, null);
                          ref.invalidate(apiSearchProvider);
                        },
                      ),
                    ),

                  // Chip Rentang Harga Aktif
                  if (filterState.priceMin != null ||
                      filterState.priceMax != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Chip(
                        label: Text(
                          "Rp ${filterState.priceMin ?? '0'} - Rp ${filterState.priceMax ?? '∞'}",
                          style: const TextStyle(fontSize: 12),
                        ),
                        onDeleted: () {
                          filterNotifier.updatePriceMin(null);
                          filterNotifier.updatePriceMax(null);
                          ref.invalidate(apiSearchProvider);
                        },
                      ),
                    ),
                ],
              ),
            ),

          // 📑 CONTAINER UTAMA HASIL DATA IKLAN
          Expanded(
            child: searchDataAsync.when(
              data: (responseModel) {
                final listAds = responseModel.ads;
                final meta = responseModel.meta;

                if (listAds.isEmpty) {
                  return const Center(child: Text("Tidak ada iklan ditemukan"));
                }

                return Column(
                  children: [
                    // Render List Item Iklan
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: listAds.length,
                        itemBuilder: (context, index) {
                          return AdCardWidget(ad: listAds[index]);
                        },
                      ),
                    ),

                    // 🔄 BAR PAGINATION FOOTER (Navigasi Halaman Backend)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Halaman ${meta.currentPage} dari ${meta.lastPage} (${meta.total} Iklan)",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.chevron_left),
                                onPressed: meta.currentPage > 1
                                    ? () {
                                        filterNotifier.changePage(
                                          meta.currentPage - 1,
                                        );
                                        ref.invalidate(apiSearchProvider);
                                      }
                                    : null,
                              ),
                              IconButton(
                                icon: const Icon(Icons.chevron_right),
                                onPressed: meta.hasMore
                                    ? () {
                                        filterNotifier.changePage(
                                          meta.currentPage + 1,
                                        );
                                        ref.invalidate(apiSearchProvider);
                                      }
                                    : null,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Gagal memuat iklan: $err",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
