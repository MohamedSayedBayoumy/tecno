import 'package:customer/app/models/product/item.dart';

import 'item_details_model.dart';

class VendorDetails {
  Venodr? venodr;
  List<ReviewModel>? reviews;

  VendorDetails({this.venodr, this.reviews});

  VendorDetails.fromJson(Map<String, dynamic> json) {
    venodr = json['venodr'] != null ? Venodr.fromJson(json['venodr']) : null;
    if (json['reviews'] != null) {
      reviews = <ReviewModel>[];
      json['reviews'].forEach((v) {
        reviews!.add(ReviewModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.venodr != null) {
      data['venodr'] = this.venodr!.toJson();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Venodr {
  int? id;
  String? name;

  DateTime createdAt = DateTime.now();
  String? updatedAt;
  List<ItemModel>? items;

  Venodr(
      {this.id,
      this.name,
      required this.createdAt,
      this.updatedAt,
      this.items});

  Venodr.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];

    createdAt = DateTime.tryParse('${json['created_at']}') ?? DateTime.now();
    updatedAt = json['updated_at'];
    if (json['items'] != null) {
      items = <ItemModel>[];
      json['items'].forEach((v) {
        items!.add(new ItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;

    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

