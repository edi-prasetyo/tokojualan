import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/network_service.dart'; // Sesuaikan path dioProvider Anda
import '../models/search_model.dart';

/// ==========================================
/// 1. SEARCH FILTER STATE & NOTIFIER (FIXED)
/// ==========================================
class SearchFilterState {
  final String? keyword;
  final int? categoryId;
  final String? categoryName;
  final String? priceMin;
  final String? priceMax;
  final String sortBy;
  final int page;

  SearchFilterState({
    this.keyword,
    this.categoryId,
    this.categoryName,
    this.priceMin,
    this.priceMax,
    this.sortBy = 'terbaru',
    this.page = 1,
  });

  SearchFilterState copyWith({
    String? keyword,
    int? categoryId,
    String? categoryName,
    String? priceMin,
    String? priceMax,
    String? sortBy,
    int? page,
  }) {
    return SearchFilterState(
      keyword: keyword ?? this.keyword,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      priceMin: priceMin ?? this.priceMin,
      priceMax: priceMax ?? this.priceMax,
      sortBy: sortBy ?? this.sortBy,
      page: page ?? this.page,
    );
  }

  SearchFilterState reset() => SearchFilterState();
}

// 🛠️ FIX: Mengubah dari StateNotifier ke Notifier bawaan Riverpod 2.x
class SearchFilterNotifier extends Notifier<SearchFilterState> {
  @override
  SearchFilterState build() {
    return SearchFilterState(); // Menentukan nilai awal state
  }

  void updateKeyword(String? val) =>
      state = state.copyWith(keyword: val, page: 1);
  void updateCategory(int? id, String? name) =>
      state = state.copyWith(categoryId: id, categoryName: name, page: 1);
  void updatePriceMin(String? val) =>
      state = state.copyWith(priceMin: val, page: 1);
  void updatePriceMax(String? val) =>
      state = state.copyWith(priceMax: val, page: 1);
  void updateSortBy(String val) => state = state.copyWith(sortBy: val, page: 1);
  void changePage(int page) => state = state.copyWith(page: page);
  void clearFilter() => state = state.reset();
}

// 🛠️ FIX: Mengubah provider dari StateNotifierProvider ke NotifierProvider
final searchFilterProvider =
    NotifierProvider<SearchFilterNotifier, SearchFilterState>(() {
      return SearchFilterNotifier();
    });

/// ==========================================
/// 2. API SEARCH CONTROLLER (FUTURE PROVIDER)
/// ==========================================
final apiSearchProvider = FutureProvider.autoDispose<AdResponseModel>((
  ref,
) async {
  // Mengambil state filter terbaru secara reaktif
  final filter = ref.watch(searchFilterProvider);

  // Mengambil instance dio dari core service Anda
  final dio = ref.read(dioProvider);

  // Susun query parameters secara dinamis
  final Map<String, dynamic> queryParams = {
    if (filter.keyword != null && filter.keyword!.isNotEmpty)
      'keyword': filter.keyword,
    if (filter.categoryId != null) 'category_id': filter.categoryId,
    if (filter.priceMin != null && filter.priceMin!.isNotEmpty)
      'price_min': filter.priceMin,
    if (filter.priceMax != null && filter.priceMax!.isNotEmpty)
      'price_max': filter.priceMax,
    'sort_by': filter.sortBy,
    'page': filter.page,
  };

  final response = await dio.get('/search', queryParameters: queryParams);

  if (response.data['status'] == 'success') {
    final List<dynamic> rawAds = response.data['data'] ?? [];
    final List<AdModel> adsList = rawAds
        .map((json) => AdModel.fromJson(json))
        .toList();
    final MetaModel metaData = MetaModel.fromJson(response.data['meta']);

    return AdResponseModel(ads: adsList, meta: metaData);
  } else {
    throw Exception(response.data['message'] ?? 'Gagal memuat data iklan');
  }
});
