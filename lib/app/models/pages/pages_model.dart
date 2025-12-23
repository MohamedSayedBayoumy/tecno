class PagesModel {
  PagesModel({
    required this.id,
    required this.title,
    required this.slug,
  });

  final int? id;
  final String? title;
  final String? slug;

  factory PagesModel.fromJson(Map<String, dynamic> json){
    return PagesModel(
      id: json["id"],
      title: json["title"],
      slug: json["slug"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
  };

}