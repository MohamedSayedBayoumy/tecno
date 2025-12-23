// // import 'package:customer/app/config/config.dart';
// //
// // import 'item_details_model.dart';
// //
// // class ItemModel {
// //   int? id;
// //   String? name;
// //   String? slug;
// //   String? sku;
// //   int? categoryId;
// //   int? subcategoryId;
// //   int? childcategoryId;
// //   int? brandId;
// //   int? taxId;
// //   String? tags;
// //   String? video;
// //   String? sortDetails;
// //   String? specificationName;
// //   String? specificationDescription;
// //   int? isSpecification;
// //   String? details;
// //   String? photo;
// //   double? discountPrice;
// //   double? previousPrice;
// //   int? stock;
// //   String? metaKeywords;
// //   String? metaDescription;
// //   int? status;
// //   String? isType;
// //   String? date;
// //   String? file;
// //   String? link;
// //   String? fileType;
// //   String? createdAt;
// //   String? updatedAt;
// //   String? licenseName;
// //   String? licenseKey;
// //   String? itemType;
// //   String? thumbnail;
// //   String? affiliateLink;
// //   Vendor? vendor;
// //   String? wholeSalePrice;
// //   String? unitValue;
// //   int? maxOrderQty;
// //   ItemModel(
// //       {this.id,
// //       this.categoryId,
// //       this.subcategoryId,
// //       this.childcategoryId,
// //       this.taxId,
// //       this.brandId,
// //       this.name,
// //       this.slug,
// //       this.sku,
// //       this.tags,
// //       this.video,
// //       this.sortDetails,
// //       this.specificationName,
// //       this.specificationDescription,
// //       this.isSpecification,
// //       this.details,
// //       this.photo,
// //       this.discountPrice,
// //       this.previousPrice,
// //       this.stock,
// //       this.metaKeywords,
// //       this.metaDescription,
// //       this.status,
// //       this.isType,
// //       this.date,
// //       this.file,
// //       this.link,
// //       this.fileType,
// //       this.createdAt,
// //       this.updatedAt,
// //       this.licenseName,
// //       this.licenseKey,
// //       this.itemType,
// //       this.thumbnail,
// //       this.vendor,
// //       this.affiliateLink,
// //         this.wholeSalePrice,
// //         this.unitValue,
// //         this.maxOrderQty
// //       });
// //   String get image => '${Config().url}/$photo';
// //   ItemModel.fromJson(Map<String, dynamic> json) {
// //     id = json['id'];
// //     categoryId = json['category_id'];
// //     subcategoryId = json['subcategory_id'];
// //     childcategoryId = json['childcategory_id'];
// //     taxId = json['tax_id'];
// //     brandId = json['brand_id'];
// //     name = json['name'];
// //     slug = json['slug'];
// //     sku = json['sku'];
// //     tags = json['tags'];
// //     video = json['video'];
// //     sortDetails = json['sort_details'];
// //     specificationName = json['specification_name'];
// //     specificationDescription = json['specification_description'];
// //     isSpecification = json['is_specification'];
// //     details = json['details'];
// //     photo = json['photo'];
// //     discountPrice = double.tryParse('${json['discount_price']}');
// //     previousPrice = double.tryParse('${json['previous_price']}');
// //     stock = json['stock'];
// //     metaKeywords = json['meta_keywords'];
// //     metaDescription = json['meta_description'];
// //     status = json['status'];
// //     isType = json['is_type'];
// //     date = json['date'];
// //     file = json['file'];
// //     link = json['link'];
// //     fileType = json['file_type'];
// //     createdAt = json['created_at'];
// //     updatedAt = json['updated_at'];
// //     licenseName = json['license_name'];
// //     licenseKey = json['license_key'];
// //     itemType = json['item_type'];
// //     thumbnail = json['thumbnail'];
// //     affiliateLink = json['affiliate_link'];
// //     vendor =
// //         json['vendor'] != null ? new Vendor.fromJson(json['vendor']) : null;
// //     wholeSalePrice = json['whole_sale_price'];
// //     maxOrderQty = json['max_order_qty'];
// //     unitValue = json['unit_value'];
// //   }
// //   factory ItemModel.fromMap(Map<String, dynamic> map) {
// //     return ItemModel(
// //       id: map['id'],
// //       categoryId: map['category_id'],
// //       subcategoryId: map['subcategory_id'],
// //       childcategoryId: map['childcategory_id'],
// //       taxId: map['tax_id'],
// //       brandId: map['brand_id'],
// //       name: map['name'],
// //       slug: map['slug'],
// //       sku: map['sku'],
// //       tags: map['tags'],
// //       video: map['video'],
// //       sortDetails: map['sort_details'],
// //       specificationName: map['specification_name'],
// //       specificationDescription: map['specification_description'],
// //       isSpecification: map['is_specification'],
// //       details: map['details'],
// //       photo: map['photo'],
// //       discountPrice: double.tryParse('${map['discount_price']}'),
// //       previousPrice: double.tryParse('${map['previous_price']}'),
// //       stock: map['stock'],
// //       metaKeywords: map['meta_keywords'],
// //       metaDescription: map['meta_description'],
// //       status: map['status'],
// //       isType: map['is_type'],
// //       date: map['date'],
// //       file: map['file'],
// //       link: map['link'],
// //       fileType: map['file_type'],
// //       createdAt: map['created_at'],
// //       updatedAt: map['updated_at'],
// //       licenseName: map['license_name'],
// //       licenseKey: map['license_key'],
// //       itemType: map['item_type'],
// //       thumbnail: map['thumbnail'],
// //       affiliateLink: map['affiliate_link'],
// //       vendor: map['vendor'] != null ? Vendor.fromJson(map['vendor']) : null,
// //       wholeSalePrice: map['whole_sale_price'],
// //       maxOrderQty: map['max_order_qty'],
// //       unitValue: map['unit_value'],
// //     );
// //   }
// //
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['id'] = this.id;
// //     data['category_id'] = this.categoryId;
// //     data['subcategory_id'] = this.subcategoryId;
// //     data['childcategory_id'] = this.childcategoryId;
// //     data['tax_id'] = this.taxId;
// //     data['brand_id'] = this.brandId;
// //     data['name'] = this.name;
// //     data['slug'] = this.slug;
// //     data['sku'] = this.sku;
// //     data['tags'] = this.tags;
// //     data['video'] = this.video;
// //     data['sort_details'] = this.sortDetails;
// //     data['specification_name'] = this.specificationName;
// //     data['specification_description'] = this.specificationDescription;
// //     data['is_specification'] = this.isSpecification;
// //     data['details'] = this.details;
// //     data['photo'] = this.photo;
// //     data['discount_price'] = this.discountPrice;
// //     data['previous_price'] = this.previousPrice;
// //     data['stock'] = this.stock;
// //     data['meta_keywords'] = this.metaKeywords;
// //     data['meta_description'] = this.metaDescription;
// //     data['status'] = this.status;
// //     data['is_type'] = this.isType;
// //     data['date'] = this.date;
// //     data['file'] = this.file;
// //     data['link'] = this.link;
// //     data['file_type'] = this.fileType;
// //     data['created_at'] = this.createdAt;
// //     data['updated_at'] = this.updatedAt;
// //     data['license_name'] = this.licenseName;
// //     data['license_key'] = this.licenseKey;
// //     data['item_type'] = this.itemType;
// //     data['thumbnail'] = this.thumbnail;
// //     data['affiliate_link'] = this.affiliateLink;
// //     data['whole_sale_price'] = this.wholeSalePrice;
// //     data['unit_value'] = this.unitValue;
// //     data['max_order_qty'] = this.maxOrderQty;
// //     return data;
// //   }
// // }
// class ItemModel {
//   ItemModel({
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
//   final dynamic details;
//   final String? sortDetails;
//   final String? specificationName;
//   final String? specificationDescription;
//   final int? isSpecification;
//   final String? tags;
//   final dynamic video;
//   final String? photo;
//   final String? thumbnail;
//   final List<String> galleries;
//   final dynamic price;
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
//   factory ItemModel.fromJson(Map<String, dynamic> json){
//     return ItemModel(
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
//

import 'package:customer/app/models/product/item_details_model.dart';

class ItemModel {
  ItemModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.sku,
    required this.barcode,
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
    required this.shippingPrice,
  });

  final int? id;
  final String? name;
  final String? slug;
  final String? sku;
  final String? barcode;
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
  final dynamic price;
  final dynamic? discountPrice;
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
  final List<Variant> variants;
  final dynamic variantId;
  double? shippingPrice;

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json["id"],
      name: json["name"] ?? "",
      slug: json["slug"],
      sku: json["sku"],
      barcode: json["bar_code"],
      categoryId: json["category_id"],
      subcategoryId: json["subcategory_id"],
      childcategoryId: json["childcategory_id"],
      brandId: json["brand_id"],
      shippingPrice: json["shipping_price"] == null
          ? 0.0
          : double.parse(json["shipping_price"]),
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
      galleries: json["galleries"] == null
          ? []
          : List<String>.from(json["galleries"]!.map((x) => x)),
      price: json["price"],
      discountPrice: json["discount_price"],
      previousPrice: json["previous_price"] ?? 0, 
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
      variants: json["variants"] == null
          ? []
          : List<Variant>.from(
              json["variants"]!.map((x) => Variant.fromJson(x))),
      variantId: json["variant_id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "bar_code": barcode,
        "sku": sku,
        "category_id": categoryId,
        "subcategory_id": subcategoryId,
        "shipping_price": shippingPrice,
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
