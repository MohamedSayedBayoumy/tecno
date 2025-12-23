import 'dart:convert';

import 'package:customer/app/models/product/item.dart';

import 'cart_options_model.dart';
import 'payment_method.dart';

class CartData {
  List<CartItem>? items;
  List<PaymentMethod>? paymentMethods;
  double? totalPrice;
  double? deliveryFee;
  double? taxes;
  double? total;
  DateTime? deliveryTime;

  CartData(
      {this.items,
      this.totalPrice,
      this.deliveryFee,
      this.taxes,
      this.total,
      this.paymentMethods,
      this.deliveryTime});

  CartData.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <CartItem>[];
      json['items'].forEach((v) {
        items!.add(CartItem.fromJson(v));
      });
    }
    if (json['payment_methods'] != null) {
      paymentMethods = <PaymentMethod>[];
      json['payment_methods'].forEach((v) {
        paymentMethods!.add(PaymentMethod.fromJson(v));
      });
    }
    totalPrice = double.tryParse('${json['total_price']}');
    deliveryFee = double.tryParse('${json['delivery_fee']}');
    taxes = double.tryParse('${json['taxes']}');
    total = double.tryParse('${json['total']}');
    deliveryTime = DateTime.tryParse('${json['delivery_by']}');
  }
  factory CartData.fromMap(Map<String, dynamic> map) {
    return CartData(
      items: map['items'],
      paymentMethods: map['payment_methods'],
      totalPrice: map['total_price'],
      deliveryFee: map['delivery_fee'],
      taxes: map['taxes'],
      total: map['total'],
      deliveryTime: map['delivery_by'],

    );
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['total_price'] = this.totalPrice;
    data['delivery_fee'] = this.deliveryFee;
    data['taxes'] = this.taxes;
    data['total'] = this.total;
    return data;
  }
}

class CartItem {
  int? id;
  int? itemId;
  int? userId;
  Map<String, dynamic>? options;
  int? qty;
  String? createdAt;
  String? updatedAt;
  ItemModel? item;
  CartOptions get cartOptions => CartOptions.fromJson(options ?? {});
  CartItem(
      {this.id,
      this.itemId,
      this.userId,
      this.options,
      this.qty,
      this.createdAt,
      this.updatedAt,
      this.item});

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['item_id'];
    userId = json['user_id'];
    options = json['options'];
    qty = json['qty'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    item = json['item'] != null ? ItemModel.fromJson(json['item']) : null;
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'],
      itemId: map['item_id'],
      userId: map['user_id'],
      options: jsonDecode(map['options']),
      qty: map['qty'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      item: map['item'] != null ? ItemModel.fromJson(map['item']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_id'] = this.itemId;
    data['user_id'] = this.userId;
    data['options'] = this.options;
    data['qty'] = this.qty;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.item != null) {
      data['item'] = this.item!.toJson();
    }
    return data;
  }
}
