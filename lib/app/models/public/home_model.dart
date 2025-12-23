// import 'package:customer/app/models/product/item.dart';
// import 'package:customer/app/models/public/category.dart';
// import 'package:customer/app/models/public/meta_keywords_model.dart';
//
// import '../../config/config.dart';
//
// class HomeModel {
//   List<Brands>? brands;
//   List<Sliders>? sliders;
//   List<CategoryModel>? categories;
//   List<FeaturedProducts>? featuredProducts;
//   List<FeaturedCategories>? featuredCategories;
//
//   HomeModel(
//       {this.brands,
//       this.sliders,
//       this.categories,
//       this.featuredProducts,
//       this.featuredCategories});
//
//   HomeModel.fromJson(Map<String, dynamic> json) {
//     if (json['brands'] != null) {
//       brands = <Brands>[];
//       json['brands'].forEach((v) {
//         brands!.add(Brands.fromJson(v));
//       });
//     }
//     if (json['sliders'] != null) {
//       sliders = <Sliders>[];
//       json['sliders'].forEach((v) {
//         sliders!.add(Sliders.fromJson(v));
//       });
//     }
//     if (json['categories'] != null) {
//       categories = <CategoryModel>[];
//       json['categories'].forEach((v) {
//         categories!.add(CategoryModel.fromJson(v));
//       });
//     }
//     if (json['featured_products'] != null) {
//       featuredProducts = <FeaturedProducts>[];
//       json['featured_products'].forEach((v) {
//         featuredProducts!.add(FeaturedProducts.fromJson(v));
//       });
//     }
//     if (json['featuredCategories'] != null) {
//       featuredCategories = <FeaturedCategories>[];
//       json['featuredCategories'].forEach((v) {
//         featuredCategories!.add(FeaturedCategories.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     if (this.brands != null) {
//       data['brands'] = this.brands!.map((v) => v.toJson()).toList();
//     }
//     if (this.sliders != null) {
//       data['sliders'] = this.sliders!.map((v) => v.toJson()).toList();
//     }
//     if (this.categories != null) {
//       data['categories'] = this.categories!.map((v) => v.toJson()).toList();
//     }
//     if (this.featuredProducts != null) {
//       data['featured_products'] =
//           this.featuredProducts!.map((v) => v.toJson()).toList();
//     }
//     if (this.featuredCategories != null) {
//       data['featuredCategories'] =
//           this.featuredCategories!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Brands {
//   int? id;
//   String? name;
//   String? slug;
//   String? photo;
//   int? status;
//   int? isPopular;
//
//
//   Brands(
//       {this.id,
//       this.name,
//       this.slug,
//       this.photo,
//       this.status,
//       this.isPopular,
//     });
//   String get image => '${Config().url}/$photo';
//
//   Brands.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     slug = json['slug'];
//     photo = json['photo'];
//     status = json['status'];
//     isPopular = json['is_popular'];
//
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['slug'] = this.slug;
//     data['photo'] = this.photo;
//     data['status'] = this.status;
//     data['is_popular'] = this.isPopular;
//
//     return data;
//   }
// }
//
// class Sliders {
//   int? id;
//   String? photo;
//   String? title;
//   String? link;
//   String? logo;
//   String? details;
//
//   String? homePage;
//   String get image => '${Config().url}/$photo';
//
//   Sliders(
//       {this.id,
//       this.photo,
//       this.title,
//       this.link,
//       this.logo,
//       this.details,
//
//       this.homePage});
//
//   Sliders.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     photo = json['photo'];
//     title = json['title'];
//     link = json['link'];
//     logo = json['logo'];
//     details = json['details'];
//
//     homePage = json['home_page'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['id'] = this.id;
//     data['photo'] = this.photo;
//     data['title'] = this.title;
//     data['link'] = this.link;
//     data['logo'] = this.logo;
//     data['details'] = this.details;
//
//     data['home_page'] = this.homePage;
//     return data;
//   }
// }
//
// class FeaturedProducts {
//   int? id;
//   int? itemId;
//   int? status;
//   int? isFeature;
//
//   ItemModel? item;
//
//   FeaturedProducts(
//       {this.id,
//       this.itemId,
//       this.status,
//       this.isFeature,
//
//       this.item});
//
//   FeaturedProducts.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     itemId = json['item_id'];
//     status = json['status'];
//     isFeature = json['is_feature'];
//
//     item = json['item'] != null ? ItemModel.fromJson(json['item']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['id'] = this.id;
//     data['item_id'] = this.itemId;
//     data['status'] = this.status;
//     data['is_feature'] = this.isFeature;
//
//     if (this.item != null) {
//       data['item'] = this.item!.toJson();
//     }
//     return data;
//   }
// }
//
//
// class FeaturedCategories {
//   int? id;
//   String? name;
//   String? slug;
//   String? photo;
//   List<MetaKeywordsModel>? metaKeywords;
//   String? metaDescriptions;
//   int? status;
//   int? isFeature;
//   int? serial;
//   List<ItemModel>? items;
//
//   FeaturedCategories(
//       {this.id,
//       this.name,
//       this.slug,
//       this.photo,
//       this.metaKeywords,
//       this.metaDescriptions,
//       this.status,
//       this.isFeature,
//       this.serial,
//
//       this.items});
//
//   FeaturedCategories.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     slug = json['slug'];
//     photo = json['photo'];
//     metaKeywords = json["meta_keywords"] == null ? [] : List<MetaKeywordsModel>.from(json["meta_keywords"]!.map((x) => MetaKeywordsModel.fromJson(x)));
//     metaDescriptions = json['meta_descriptions'];
//     status = json['status'];
//     isFeature = json['is_feature'];
//     serial = json['serial'];
//
//     if (json['items'] != null) {
//       items = <ItemModel>[];
//       json['items'].forEach((v) {
//         items!.add( ItemModel.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['slug'] = this.slug;
//     data['photo'] = this.photo;
//     data['meta_keywords'] = this.metaKeywords;
//     data['meta_descriptions'] = this.metaDescriptions;
//     data['status'] = this.status;
//     data['is_feature'] = this.isFeature;
//     data['serial'] = this.serial;
//
//     if (this.items != null) {
//       data['items'] = this.items!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//


import 'package:customer/app/models/product/item.dart';
import 'package:customer/app/models/public/meta_keywords_model.dart';

class HomeModel {
  HomeModel({
    required this.brands,
    required this.sliders,
    required this.categories,
    required this.featuredProducts,
    // required this.featuredCategories,
  });

  final List<Brand> brands;
  final List<Slider> sliders;
  final List<Category> categories;
  final List<ItemModel> featuredProducts;
  // final List<FeaturedCategories> featuredCategories;

  factory HomeModel.fromJson(Map<String, dynamic> json){
    return HomeModel(
      brands: json["brands"] == null ? [] : List<Brand>.from(json["brands"]!.map((x) => Brand.fromJson(x))),
      sliders: json["sliders"] == null ? [] : List<Slider>.from(json["sliders"]!.map((x) => Slider.fromJson(x))),
      categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
      featuredProducts: json["featured_products"] == null ? [] : List<ItemModel>.from(json["featured_products"]!.map((x) => ItemModel.fromJson(x))),
      // featuredCategories: json["featuredCategories"] == null ? [] : List<FeaturedCategories>.from(json["featuredCategories"]!.map((x) => FeaturedCategories.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "brands": brands.map((x) => x?.toJson()).toList(),
    "sliders": sliders.map((x) => x?.toJson()).toList(),
    "categories": categories.map((x) => x?.toJson()).toList(),
    "featured_products": featuredProducts.map((x) => x?.toJson()).toList(),
    // "featuredCategories": featuredCategories.map((x) => x?.toJson()).toList(),
  };

}

class Brand {
  Brand({
    required this.id,
    required this.name,
    required this.slug,
    required this.photo,
    required this.status,
    required this.isPopular,
  });

  final int? id;
  final String? name;
  final String? slug;
  final String? photo;
  final int? status;
  final int? isPopular;

  factory Brand.fromJson(Map<String, dynamic> json){
    return Brand(
      id: json["id"],
      name: json["name"],
      slug: json["slug"],
      photo: json["photo"],
      status: json["status"],
      isPopular: json["is_popular"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "photo": photo,
    "status": status,
    "is_popular": isPopular,
  };

}

class Category {
  Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.photo,
    required this.metaKeywords,
    required this.metaDescriptions,
    required this.status,
    required this.isFeature,
    required this.serial,
  });

  final int? id;
  final String? name;
  final String? slug;
  final String? photo;
  final List<MetaKeyword> metaKeywords;
  final String? metaDescriptions;
  final bool? status;
  final bool? isFeature;
  final int? serial;

  factory Category.fromJson(Map<String, dynamic> json){
    return Category(
      id: json["id"],
      name: json["name"],
      slug: json["slug"],
      photo: json["photo"],
      metaKeywords: json["meta_keywords"] == null ? [] : List<MetaKeyword>.from(json["meta_keywords"]!.map((x) => MetaKeyword.fromJson(x))),
      metaDescriptions: json["meta_descriptions"],
      status: json["status"],
      isFeature: json["is_feature"],
      serial: json["serial"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "photo": photo,
    "meta_keywords": metaKeywords.map((x) => x?.toJson()).toList(),
    "meta_descriptions": metaDescriptions,
    "status": status,
    "is_feature": isFeature,
    "serial": serial,
  };

}

class MetaKeyword {
  MetaKeyword({
    required this.value,
  });

  final String? value;

  factory MetaKeyword.fromJson(Map<String, dynamic> json){
    return MetaKeyword(
      value: json["value"],
    );
  }

  Map<String, dynamic> toJson() => {
    "value": value,
  };

}

class FeaturedProduct {
  FeaturedProduct({
    required this.id,
    required this.name,
    required this.slug,
    required this.sku,
    required this.categoryId,
    required this.subcategoryId,
    required this.childcategoryId,
    required this.brandId,
    required this.taxId,
    required this.details,
    required this.sortDetails,
    required this.specificationName,
    required this.specificationDescription,
    required this.isSpecification,
    required this.tags,
    required this.video,
    required this.photo,
    required this.thumbnail,
    required this.galleries,
    required this.price,
    required this.discountPrice,
    required this.previousPrice,
    required this.wholeSalePrice,
    required this.wholeSaleQty,
    required this.stock,
    required this.maxOrderQty,
    required this.metaKeywords,
    required this.metaDescription,
    required this.status,
    required this.isType,
    required this.date,
    required this.hasVariant,
    required this.variants,
    required this.variantId,
  });

  final int? id;
  final String? name;
  final String? slug;
  final String? sku;
  final int? categoryId;
  final int? subcategoryId;
  final dynamic childcategoryId;
  final int? brandId;
  final int? taxId;
  final dynamic details;
  final String? sortDetails;
  final String? specificationName;
  final String? specificationDescription;
  final int? isSpecification;
  final String? tags;
  final dynamic video;
  final String? photo;
  final String? thumbnail;
  final List<String> galleries;
  final int? price;
  final int? discountPrice;
  final int? previousPrice;
  final String? wholeSalePrice;
  final int? wholeSaleQty;
  final int? stock;
  final dynamic maxOrderQty;
  final String? metaKeywords;
  final dynamic metaDescription;
  final int? status;
  final String? isType;
  final dynamic date;
  final int? hasVariant;
  final List<dynamic> variants;
  final dynamic variantId;

  factory FeaturedProduct.fromJson(Map<String, dynamic> json){
    return FeaturedProduct(
      id: json["id"],
      name: json["name"],
      slug: json["slug"],
      sku: json["sku"],
      categoryId: json["category_id"],
      subcategoryId: json["subcategory_id"],
      childcategoryId: json["childcategory_id"],
      brandId: json["brand_id"],
      taxId: json["tax_id"],
      details: json["details"],
      sortDetails: json["sort_details"],
      specificationName: json["specification_name"],
      specificationDescription: json["specification_description"],
      isSpecification: json["is_specification"],
      tags: json["tags"],
      video: json["video"],
      photo: json["photo"],
      thumbnail: json["thumbnail"],
      galleries: json["galleries"] == null ? [] : List<String>.from(json["galleries"]!.map((x) => x)),
      price: json["price"],
      discountPrice: json["discount_price"],
      previousPrice: json["previous_price"],
      wholeSalePrice: json["whole_sale_price"],
      wholeSaleQty: json["whole_sale_qty"],
      stock: json["stock"],
      maxOrderQty: json["max_order_qty"],
      metaKeywords: json["meta_keywords"],
      metaDescription: json["meta_description"],
      status: json["status"],
      isType: json["is_type"],
      date: json["date"],
      hasVariant: json["has_variant"],
      variants: json["variants"] == null ? [] : List<dynamic>.from(json["variants"]!.map((x) => x)),
      variantId: json["variant_id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "sku": sku,
    "category_id": categoryId,
    "subcategory_id": subcategoryId,
    "childcategory_id": childcategoryId,
    "brand_id": brandId,
    "tax_id": taxId,
    "details": details,
    "sort_details": sortDetails,
    "specification_name": specificationName,
    "specification_description": specificationDescription,
    "is_specification": isSpecification,
    "tags": tags,
    "video": video,
    "photo": photo,
    "thumbnail": thumbnail,
    "galleries": galleries.map((x) => x).toList(),
    "price": price,
    "discount_price": discountPrice,
    "previous_price": previousPrice,
    "whole_sale_price": wholeSalePrice,
    "whole_sale_qty": wholeSaleQty,
    "stock": stock,
    "max_order_qty": maxOrderQty,
    "meta_keywords": metaKeywords,
    "meta_description": metaDescription,
    "status": status,
    "is_type": isType,
    "date": date,
    "has_variant": hasVariant,
    "variants": variants.map((x) => x).toList(),
    "variant_id": variantId,
  };

}

class Slider {
  Slider({
    required this.id,
    required this.title,
    required this.link,
    required this.details,
    required this.photo,
    required this.logo,
  });

  final int? id;
  final String? title;
  final String? link;
  final String? details;
  final String? photo;
  final String? logo;

  factory Slider.fromJson(Map<String, dynamic> json){
    return Slider(
      id: json["id"],
      title: json["title"],
      link: json["link"],
      details: json["details"],
      photo: json["photo"],
      logo: json["logo"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "link": link,
    "details": details,
    "photo": photo,
    "logo": logo,
  };

}


class FeaturedCategories {
  int? id;
  String? name;
  String? slug;
  String? photo;
  List<MetaKeywordsModel>? metaKeywords;
  String? metaDescriptions;
  bool? status;
  bool? isFeature;
  int? serial;
  List<ItemModel>? items;

  FeaturedCategories(
      {this.id,
      this.name,
      this.slug,
      this.photo,
      this.metaKeywords,
      this.metaDescriptions,
      this.status,
      this.isFeature,
      this.serial,

      this.items});

  FeaturedCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    photo = json['photo'];
    metaKeywords = json["meta_keywords"] == null ? [] : List<MetaKeywordsModel>.from(json["meta_keywords"]!.map((x) => MetaKeywordsModel.fromJson(x)));
    metaDescriptions = json['meta_descriptions'];
    status = json['status'];
    isFeature = json['is_feature'];
    serial = json['serial'];

    if (json['items'] != null) {
      items = <ItemModel>[];
      json['items'].forEach((v) {
        items!.add( ItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['photo'] = this.photo;
    data['meta_keywords'] = this.metaKeywords;
    data['meta_descriptions'] = this.metaDescriptions;
    data['status'] = this.status;
    data['is_feature'] = this.isFeature;
    data['serial'] = this.serial;

    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

