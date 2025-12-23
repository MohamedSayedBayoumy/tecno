class SubcategoryModel {
  int? id;
  String? name;
  String? slug;
  List<Childcategory>? childcategory;

  SubcategoryModel(
      {this.id, this.name, this.slug, this.childcategory = const []});

  SubcategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    if (json['childcategory'] != null) {
      childcategory = <Childcategory>[];
      (json['childcategory'] ?? []).forEach((v) {
        childcategory!.add(new Childcategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    if (this.childcategory != null) {
      data['childcategory'] =
          this.childcategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Childcategory {
  int? id;
  String? name;
  String? slug;

  Childcategory({this.id, this.name, this.slug});

  Childcategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    return data;
  }
}
