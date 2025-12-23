import '../product/item.dart';

class SearchResponse {
  final bool status;
  final String message;
  final SearchData data;

  SearchResponse({
    this.status = false,
    this.message = "",
    SearchData? data,
  }) : data = data ?? SearchData();

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? "",
      data: json['data'] != null
          ? SearchData.fromJson(json['data'])
          : SearchData(),
    );
  }
}

class SearchData {
  final List<ItemModel> products;
  final List<ItemModel> recommendedProducts;
  final List<String> latestSearches;
  final List<String> searchSuggestions;

  SearchData({
    this.products = const [],
    this.recommendedProducts = const [],
    this.latestSearches = const [],
    this.searchSuggestions = const [],
  });

  factory SearchData.fromJson(Map<String, dynamic> json) {
    return SearchData(
      products: (json['products'] as List? ?? [])
          .map((e) => ItemModel.fromJson(e))
          .toList(),
      recommendedProducts: (json['recommended_products'] as List? ?? [])
          .map((e) => ItemModel.fromJson(e))
          .toList(),
      latestSearches: (json['latest_searches'] as List? ?? [])
          .map((e) => e.toString())
          .toList(),
      searchSuggestions: (json['search_suggestions'] as List? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }
}
