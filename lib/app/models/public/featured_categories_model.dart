import 'package:customer/app/models/public/home_model.dart';

class FeaturedCategoriesModel {
  FeaturedCategoriesModel({
    required this.data,
    required this.links,
    required this.meta,
  });

  final List<FeaturedCategories> data;
  final Links? links;
  final Meta? meta;

  factory FeaturedCategoriesModel.fromJson(Map<String, dynamic> json){
    return FeaturedCategoriesModel(
      data: json["data"] == null ? [] : List<FeaturedCategories>.from(json["data"]!.map((x) => FeaturedCategories.fromJson(x))),
      links: json["links"] == null ? null : Links.fromJson(json["links"]),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data.map((x) => x?.toJson()).toList(),
    "links": links?.toJson(),
    "meta": meta?.toJson(),
  };

}

class Links {
  Links({
    required this.first,
    required this.last,
    required this.prev,
    required this.next,
  });

  final String? first;
  final String? last;
  final dynamic prev;
  final String? next;

  factory Links.fromJson(Map<String, dynamic> json){
    return Links(
      first: json["first"],
      last: json["last"],
      prev: json["prev"],
      next: json["next"],
    );
  }

  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };

}

class Meta {
  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  final int? currentPage;
  final int? from;
  final int? lastPage;
  final String? path;
  final int? perPage;
  final int? to;
  final int? total;

  factory Meta.fromJson(Map<String, dynamic> json){
    return Meta(
      currentPage: json["current_page"],
      from: json["from"],
      lastPage: json["last_page"],
      path: json["path"],
      perPage: json["per_page"],
      to: json["to"],
      total: json["total"],
    );
  }

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };

}