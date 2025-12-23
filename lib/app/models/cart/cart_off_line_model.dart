import 'dart:convert';

import 'package:customer/app/models/cart/cart_options_model.dart';
import 'package:customer/app/models/product/item_details_model.dart';

class CartOffLineModel {
  int? id;
  int? itemId;
  int? variantId;
  String? name;
  String? price;
  String? shippingPrice;
  String? image;
  int? quantity;
  int? stock;
  CartOptions? options;

  CartOffLineModel({
    this.id,
    this.itemId,
    this.variantId,
    this.name,
    this.price,
    this.stock,
    this.image,
    this.quantity,
  required  this.shippingPrice,
    this.options,
  });

  /// Factory constructor to create an instance from JSON
  factory CartOffLineModel.fromJson(Map<String, dynamic> json) {
    return CartOffLineModel(
        id: json['id'],
        itemId: json['item_id'],
        variantId: json["variant_id"],
        name: json['name'],
        price: json['price'],
        shippingPrice: json['shippingPrice'],
        stock: json['stock'],
        image: json['image'],
        quantity: json['quantity'],
        options: json['options']);
  }

  /// Factory constructor to create an instance from a Map
  factory CartOffLineModel.fromMap(Map<String, dynamic> map) {
    return CartOffLineModel(
        id: map['id'],
        itemId: map['item_id'],
        variantId: map["variant_id"],
        name: map['name'],
        price: map['price'],
        stock: map['stock'],
        image: map['image'],
        shippingPrice: map['shippingPrice'],
        quantity: map['quantity'],
        // options: map['options'] != null
        //     ? (map['options'] is List
        //     ? List<CartOptions>.from(map['options'].map((item) => CartOptions.fromMap(item)))
        //     : map['options'] is Map
        //     ? map['options'].entries.map((entry) => CartOptions.fromMap(entry.value)).toList()
        //     : null)
        //     : null,
        options: CartOptions.fromMap(jsonDecode(map['options'])));
  }

  /// Method to convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'item_id': itemId,
      'variant_id': variantId,
      'shippingPrice': shippingPrice,
      'name': name,
      'stock': stock,
      'price': price,
      'image': image,
      'quantity': quantity,
      'options': options,
    };
  }
}
