// import 'package:customer/app/models/product/item.dart';
//
// import '../../config/config.dart';
//
// class ItemDetails {
//   ItemModel? item;
//   Reviews? reviews;
//   List<Galleries>? galleries;
//   String? video;
//   List<String>? secName;
//   List<String>? secDetails;
//   List<Attributes>? attributes;
//   List<ItemModel>? relatedItems;
//
//   ItemDetails(
//       {this.item,
//       this.reviews,
//       this.galleries,
//       this.video,
//       this.secName,
//       this.secDetails,
//       this.attributes,
//       this.relatedItems});
//
//   ItemDetails.fromJson(Map<String, dynamic> json) {
//     item = json['item'] != null ? new ItemModel.fromJson(json['item']) : null;
//     reviews =
//         json['reviews'] != null ? new Reviews.fromJson(json['reviews']) : null;
//     if (json['galleries'] != null) {
//       galleries = <Galleries>[];
//       json['galleries'].forEach((v) {
//         galleries!.add(new Galleries.fromJson(v));
//       });
//     }
//     video = json['video'];
//     secName = json['sec_name'].cast<String>();
//     secDetails = json['sec_details'].cast<String>();
//     if (json['attributes'] != null) {
//       attributes = <Attributes>[];
//       json['attributes'].forEach((v) {
//         attributes!.add(new Attributes.fromJson(v));
//       });
//     }
//     if (json['related_items'] != null) {
//       relatedItems = <ItemModel>[];
//       json['related_items'].forEach((v) {
//         relatedItems!.add( ItemModel.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.item != null) {
//       data['item'] = this.item!.toJson();
//     }
//     if (this.reviews != null) {
//       data['reviews'] = this.reviews!.toJson();
//     }
//     if (this.galleries != null) {
//       data['galleries'] = this.galleries!.map((v) => v.toJson()).toList();
//     }
//     data['video'] = this.video;
//     data['sec_name'] = this.secName;
//     data['sec_details'] = this.secDetails;
//     if (this.attributes != null) {
//       data['attributes'] = this.attributes!.map((v) => v.toJson()).toList();
//     }
//     if (this.relatedItems != null) {
//       data['related_items'] =
//           this.relatedItems!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
//
// class Category {
//   int? id;
//   String? name;
//   String? slug;
//   String? photo;
//   String? metaKeywords;
//   String? metaDescriptions;
//   int? status;
//   int? isFeature;
//   int? serial;
//
//
//   String get image => '${Config().url}/$photo';
//
//   Category(
//       {this.id,
//       this.name,
//       this.slug,
//       this.photo,
//       this.metaKeywords,
//       this.metaDescriptions,
//       this.status,
//       this.isFeature,
//       this.serial,
//       });
//
//   Category.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     slug = json['slug'];
//     photo = json['photo'];
//     metaKeywords = json['meta_keywords'];
//     metaDescriptions = json['meta_descriptions'];
//     status = json['status'];
//     isFeature = json['is_feature'];
//     serial = json['serial'];
//
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
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
//     return data;
//   }
// }
//
// class Galleries {
//   int? id;
//   int? itemId;
//   String? photo;
//
//   String get image => '${Config().url}/$photo';
//
//   Galleries({this.id, this.itemId, this.photo,});
//
//   Galleries.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     itemId = json['item_id'];
//     photo = json['photo'];
//
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['item_id'] = this.itemId;
//     data['photo'] = this.photo;
//
//     return data;
//   }
// }
//
// class Attributes {
//   int? id;
//   int? itemId;
//   String? name;
//   String? keyword;
//   List<Options>? options;
//
//   Attributes({this.id, this.itemId, this.name, this.keyword, this.options});
//
//   Attributes.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     itemId = json['item_id'];
//     name = json['name'];
//     keyword = json['keyword'];
//     if (json['options'] != null) {
//       options = <Options>[];
//       json['options'].forEach((v) {
//         options!.add(new Options.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['item_id'] = this.itemId;
//     data['name'] = this.name;
//     data['keyword'] = this.keyword;
//     if (this.options != null) {
//       data['options'] = this.options!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Options {
//   int? id;
//   int? attributeId;
//   String? name;
//   int? price;
//   String? keyword;
//   String? stock;
//
//   Options(
//       {this.id,
//       this.attributeId,
//       this.name,
//       this.price,
//       this.keyword,
//       this.stock});
//
//   Options.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     attributeId = json['attribute_id'];
//     name = json['name'];
//     price = json['price'];
//     keyword = json['keyword'];
//     stock = json['stock'];
//   }
//   factory Options.fromMap(Map<String, dynamic> map) {
//     return Options(
//       id: map['id'],
//       attributeId: map['attribute_id'],
//       name: map['name'],
//       price: map['price'],
//       keyword: map['keyword'],
//       stock: map['stock'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['attribute_id'] = this.attributeId;
//     data['name'] = this.name;
//     data['price'] = this.price;
//     data['keyword'] = this.keyword;
//     data['stock'] = this.stock;
//     return data;
//   }
// }

import 'package:customer/app/models/product/item.dart';

class ReviewItem {
  final ReviewStatistics statistics;
  final List<ReviewUser> latestReviews;
  final bool hasMore;

  ReviewItem({
    required this.statistics,
    this.latestReviews = const [],
    this.hasMore = false,
  });

  factory ReviewItem.fromJson(Map<String, dynamic> json) {
    return ReviewItem(
      statistics: ReviewStatistics.fromJson(json['statistics'] ?? {}),
      latestReviews: (json['latest_reviews'] as List<dynamic>?)
              ?.map((e) => ReviewUser.fromJson(e))
              .toList() ??
          [],
      hasMore: json['has_more'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'statistics': statistics.toJson(),
        'latest_reviews': latestReviews.map((e) => e.toJson()).toList(),
        'has_more': hasMore,
      };
}

class ReviewStatistics {
  final int totalReviews;
  final double averageRating;
  final List<RatingBreakdown> ratingBreakdown;

  ReviewStatistics({
    this.totalReviews = 0,
    this.averageRating = 0,
    this.ratingBreakdown = const [],
  });

  factory ReviewStatistics.fromJson(Map<String, dynamic> json) {
    return ReviewStatistics(
      totalReviews: json['total_reviews'] ?? 0,
      averageRating: (json['average_rating'] ?? 0).toDouble(),
      ratingBreakdown: (json['rating_breakdown'] as List<dynamic>?)
              ?.map((e) => RatingBreakdown.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'total_reviews': totalReviews,
        'average_rating': averageRating,
        'rating_breakdown': ratingBreakdown.map((e) => e.toJson()).toList(),
      };
}

class RatingBreakdown {
  final int stars;
  final double percentage;

  RatingBreakdown({this.stars = 0, this.percentage = 0});

  factory RatingBreakdown.fromJson(Map<String, dynamic> json) {
    return RatingBreakdown(
      stars: json['stars'] ?? 0,
      percentage: (json['percentage'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'stars': stars,
        'percentage': percentage,
      };
}

class ReviewUser {
  final int id;
  final ReviewUserData? user;
  final int rating;
  final String review;
  final String subject;
  final String createdAt;
  final String createdAtHuman;

  ReviewUser({
    this.id = 0,
    this.user,
    this.rating = 0,
    this.review = '',
    this.subject = '',
    this.createdAt = '',
    this.createdAtHuman = '',
  });

  factory ReviewUser.fromJson(Map<String, dynamic> json) {
    return ReviewUser(
      id: json['id'] ?? 0,
      user: json['user'] != null ? ReviewUserData.fromJson(json['user']) : null,
      rating: int.parse((json['rating'] ?? 0).toString()),
      review: json['review'] ?? '',
      subject: json['subject'] ?? '',
      createdAt: json['created_at'] ?? '',
      createdAtHuman: json['created_at_human'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user?.toJson(),
        'rating': rating,
        'review': review,
        'subject': subject,
        'created_at': createdAt,
        'created_at_human': createdAtHuman,
      };
}

class ReviewUserData {
  final String name;
  final String photo;
  final String initial;

  ReviewUserData({this.name = '', this.photo = '', this.initial = ''});

  factory ReviewUserData.fromJson(Map<String, dynamic> json) {
    return ReviewUserData(
      name: json['name'] ?? '',
      photo: json['photo'] ?? '',
      initial: json['initial'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'photo': photo,
        'initial': initial,
      };
}

class Reviews {
  int? currentPage;
  List<ReviewModel>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Reviews(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Reviews.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <ReviewModel>[];
      json['data'].forEach((v) {
        data!.add(new ReviewModel.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class ReviewModel {
  int? id;
  int? userId;
  int? itemId;
  String? review;
  String? subject;
  double? rating;
  int? status;
  String? createdAt;
  String? updatedAt;
  User? user;

  ReviewModel(
      {this.id,
      this.userId,
      this.itemId,
      this.review,
      this.subject,
      this.rating,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.user});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    itemId = json['item_id'];
    review = json['review'];
    subject = json['subject'];
    rating = double.tryParse('${json['rating']}');
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['item_id'] = this.itemId;
    data['review'] = this.review;
    data['subject'] = this.subject;
    data['rating'] = this.rating;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;

  User({this.id, this.firstName, this.lastName});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}

class Vendor {
  int? id;
  String? name;

  String? photo;

  DateTime? createdAt;

  Vendor({
    this.id,
    this.name,
    this.photo,
    this.createdAt,
  });

  Vendor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];

    photo = json['photo'];

    createdAt = DateTime.tryParse('${json['created_at']}');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['photo'] = this.photo;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}

class ItemDetails {
  ItemDetails({
    required this.item,
    required this.reviews,
    required this.galleries,
    required this.video,
    required this.secName,
    required this.secDetails,
    required this.variants,
    required this.relatedItems,
  });

  final ItemModel? item;
  final ReviewItem? reviews;
  final List<dynamic> galleries;
  final String? video;
  final List<dynamic> secName;
  final List<dynamic> secDetails;
  final List<Variant> variants;
  final List<ItemModel> relatedItems;

  factory ItemDetails.fromJson(Map<String, dynamic> json) {
    return ItemDetails(
      item: json["item"] == null ? null : ItemModel.fromJson(json["item"]),
     
      reviews:
          json["reviews"] == null ? null : ReviewItem.fromJson(json["reviews"]),
      galleries: json["galleries"] == null
          ? []
          : List<dynamic>.from(json["galleries"]!.map((x) => x)),
      video: json["video"],
      secName: json["sec_name"] == null
          ? []
          : List<dynamic>.from(json["sec_name"]!.map((x) => x)),
      secDetails: json["sec_details"] == null
          ? []
          : List<dynamic>.from(json["sec_details"]!.map((x) => x)),
      variants: json["variants"] == null
          ? []
          : List<Variant>.from(
              json["variants"]!.map((x) => Variant.fromJson(x))),
      relatedItems: json["related_items"] == null
          ? []
          : List<ItemModel>.from(
              json["related_items"]!.map((x) => ItemModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "item": item?.toJson(),
        "reviews": reviews?.toJson(),
        "galleries": galleries.map((x) => x).toList(),
        "video": video,
        "sec_name": secName.map((x) => x).toList(),
        "sec_details": secDetails.map((x) => x).toList(),
        "variants": variants.map((x) => x).toList(),
        "related_items": relatedItems.map((x) => x?.toJson()).toList(),
      };
}

class Gallery {
  Gallery({
    required this.id,
    required this.itemId,
    required this.photo,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final int? itemId;
  final String? photo;
  final dynamic createdAt;
  final dynamic updatedAt;

  factory Gallery.fromJson(Map<String, dynamic> json) {
    return Gallery(
      id: json["id"],
      itemId: json["item_id"],
      photo: json["photo"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_id": itemId,
        "photo": photo,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Variant {
  Variant({
    required this.id,
    required this.itemId,
    required this.name,
    required this.sku,
    required this.asin,
    required this.barcode,
    required this.stock,
    required this.price,
    required this.isDefault,
    required this.photo,
    required this.gallery,
  });

  final int? id;
  final int? itemId;
  final String? name;
  final String? sku;
  final String? asin;
  final String? barcode;
  final int? stock;
  final String? price;
  final int? isDefault;
  final String? photo;
  final List<String> gallery;

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      id: json["id"],
      itemId: json["item_id"],
      name: json["name"],
      sku: json["sku"],
      asin: json["asin"],
      barcode: json["barcode"],
      stock: json["stock"],
      price: json["price"],
      isDefault: json["is_default"],
      photo: json["photo"],
      gallery: json["gallery"] == null
          ? []
          : List<String>.from(json["gallery"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_id": itemId,
        "name": name,
        "sku": sku,
        "asin": asin,
        "barcode": barcode,
        "stock": stock,
        "price": price,
        "is_default": isDefault,
        "photo": photo,
        "gallery": gallery.map((x) => x).toList(),
      };
}

// class Item {
//   Item({
//     required this.id,
//     required this.name,
//     required this.slug,
//     required this.sku,
//     required this.categoryId,
//     required this.subcategoryId,
//     required this.childcategoryId,
//     required this.brandId,
//     required this.taxId,
//     required this.details,
//     required this.sortDetails,
//     required this.specificationName,
//     required this.specificationDescription,
//     required this.isSpecification,
//     required this.tags,
//     required this.video,
//     required this.photo,
//     required this.thumbnail,
//     required this.galleries,
//     required this.price,
//     required this.discountPrice,
//     required this.previousPrice,
//     required this.wholeSalePrice,
//     required this.wholeSaleQty,
//     required this.stock,
//     required this.maxOrderQty,
//     required this.metaKeywords,
//     required this.metaDescription,
//     required this.status,
//     required this.isType,
//     required this.date,
//     required this.hasVariant,
//     required this.variants,
//     required this.variantId,
//   });
//
//   final int? id;
//   final String? name;
//   final String? slug;
//   final String? sku;
//   final int? categoryId;
//   final int? subcategoryId;
//   final dynamic childcategoryId;
//   final int? brandId;
//   final int? taxId;
//   final String? details;
//   final String? sortDetails;
//   final String? specificationName;
//   final String? specificationDescription;
//   final int? isSpecification;
//   final String? tags;
//   final dynamic video;
//   final String? photo;
//   final String? thumbnail;
//   final List<String> galleries;
//   final int? price;
//   final int? discountPrice;
//   final int? previousPrice;
//   final String? wholeSalePrice;
//   final int? wholeSaleQty;
//   final int? stock;
//   final dynamic maxOrderQty;
//   final String? metaKeywords;
//   final dynamic metaDescription;
//   final int? status;
//   final String? isType;
//   final dynamic date;
//   final int? hasVariant;
//   final List<dynamic> variants;
//   final dynamic variantId;
//
//   factory Item.fromJson(Map<String, dynamic> json){
//     return Item(
//       id: json["id"],
//       name: json["name"],
//       slug: json["slug"],
//       sku: json["sku"],
//       categoryId: json["category_id"],
//       subcategoryId: json["subcategory_id"],
//       childcategoryId: json["childcategory_id"],
//       brandId: json["brand_id"],
//       taxId: json["tax_id"],
//       details: json["details"],
//       sortDetails: json["sort_details"],
//       specificationName: json["specification_name"],
//       specificationDescription: json["specification_description"],
//       isSpecification: json["is_specification"],
//       tags: json["tags"],
//       video: json["video"],
//       photo: json["photo"],
//       thumbnail: json["thumbnail"],
//       galleries: json["galleries"] == null ? [] : List<String>.from(json["galleries"]!.map((x) => x)),
//       price: json["price"],
//       discountPrice: json["discount_price"],
//       previousPrice: json["previous_price"],
//       wholeSalePrice: json["whole_sale_price"],
//       wholeSaleQty: json["whole_sale_qty"],
//       stock: json["stock"],
//       maxOrderQty: json["max_order_qty"],
//       metaKeywords: json["meta_keywords"],
//       metaDescription: json["meta_description"],
//       status: json["status"],
//       isType: json["is_type"],
//       date: json["date"],
//       hasVariant: json["has_variant"],
//       variants: json["variants"] == null ? [] : List<dynamic>.from(json["variants"]!.map((x) => x)),
//       variantId: json["variant_id"],
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "slug": slug,
//     "sku": sku,
//     "category_id": categoryId,
//     "subcategory_id": subcategoryId,
//     "childcategory_id": childcategoryId,
//     "brand_id": brandId,
//     "tax_id": taxId,
//     "details": details,
//     "sort_details": sortDetails,
//     "specification_name": specificationName,
//     "specification_description": specificationDescription,
//     "is_specification": isSpecification,
//     "tags": tags,
//     "video": video,
//     "photo": photo,
//     "thumbnail": thumbnail,
//     "galleries": galleries.map((x) => x).toList(),
//     "price": price,
//     "discount_price": discountPrice,
//     "previous_price": previousPrice,
//     "whole_sale_price": wholeSalePrice,
//     "whole_sale_qty": wholeSaleQty,
//     "stock": stock,
//     "max_order_qty": maxOrderQty,
//     "meta_keywords": metaKeywords,
//     "meta_description": metaDescription,
//     "status": status,
//     "is_type": isType,
//     "date": date,
//     "has_variant": hasVariant,
//     "variants": variants.map((x) => x).toList(),
//     "variant_id": variantId,
//   };
//
// }
