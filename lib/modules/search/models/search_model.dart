class AdModel {
  final int id;
  final String code;
  final int userId;
  final int categoryId;
  final String condition;
  final String adStatus;
  final String title;
  final String slug;
  final int views;
  final String description;
  final int negotiable;
  final int price;
  final String priceType;
  final String location;
  final String status;
  final DateTime createdAt;

  AdModel({
    required this.id,
    required this.code,
    required this.userId,
    required this.categoryId,
    required this.condition,
    required this.adStatus,
    required this.title,
    required this.slug,
    required this.views,
    required this.description,
    required this.negotiable,
    required this.price,
    required this.priceType,
    required this.location,
    required this.status,
    required this.createdAt,
  });

  factory AdModel.fromJson(Map<String, dynamic> json) {
    return AdModel(
      id: json['id'] ?? 0,
      code: json['code'] ?? '',
      userId: json['user_id'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      condition: json['condition'] ?? 'second',
      adStatus: json['ad_status'] ?? 'sale',
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      views: json['views'] ?? 0,
      description: json['description'] ?? '',
      negotiable: json['negotiable'] ?? 0,
      price: json['price'] ?? 0,
      priceType: json['price_type'] ?? '',
      location: json['location'] ?? 'Indonesia',
      status: json['status'] ?? 'active',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }
}

class MetaModel {
  final int currentPage;
  final int lastPage;
  final int total;
  final bool hasMore;

  MetaModel({
    required this.currentPage,
    required this.lastPage,
    required this.total,
    required this.hasMore,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      currentPage: json['current_page'] ?? 1,
      lastPage: json['last_page'] ?? 1,
      total: json['total'] ?? 0,
      hasMore: json['has_more'] ?? false,
    );
  }
}

// Wrapper untuk menyatukan list data iklan dan metadata pagination
class AdResponseModel {
  final List<AdModel> ads;
  final MetaModel meta;

  AdResponseModel({required this.ads, required this.meta});
}
