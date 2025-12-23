class PageModel {
  PageModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.details,
    required this.metaKeywords,
    required this.metaDescriptions,
    required this.pos,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? title;
  final String? slug;
  final String? details;
  final dynamic metaKeywords;
  final dynamic metaDescriptions;
  final int? pos;
  final dynamic createdAt;
  final dynamic updatedAt;

  factory PageModel.fromJson(Map<String, dynamic> json){
    return PageModel(
      id: json["id"],
      title: json["title"],
      slug: json["slug"],
      details: json["details"],
      metaKeywords: json["meta_keywords"],
      metaDescriptions: json["meta_descriptions"],
      pos: json["pos"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "details": details,
    "meta_keywords": metaKeywords,
    "meta_descriptions": metaDescriptions,
    "pos": pos,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };

}