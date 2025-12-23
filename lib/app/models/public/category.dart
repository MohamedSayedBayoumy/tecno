import '../../config/config.dart';

class CategoryModel {
  int? id;
  String? name;
  String? slug;
  String? photo;

  CategoryModel({this.id, this.name, this.slug, this.photo});
  String get image => '${Config().url}/$photo';

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['photo'] = this.photo;
    return data;
  }
}