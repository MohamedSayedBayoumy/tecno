import 'dart:convert';

import 'package:customer/app/models/cart/address_model.dart';

import '../product/item.dart';

class OrderModel {
  int? id;
  int? userId;
  List<Cart>? cart;
  String? currencySign;
  String? currencyValue;
  String? discount;
  Shipping? shipping;
  String? paymentMethod;
  String? txnid;
  int? tax;
  int? chargeId;
  String? transactionNumber;
  String? orderStatus;
  String? shippingInfo;
  String? billingInfo;
  String? paymentStatus;
  String? createdAt;
  String? updatedAt;
  int? statePrice;
  String? state;

  OrderModel(
      {this.id,
      this.userId,
      this.cart,
      this.currencySign,
      this.currencyValue,
      this.discount,
      this.shipping,
      this.paymentMethod,
      this.txnid,
      this.tax,
      this.chargeId,
      this.transactionNumber,
      this.orderStatus,
      this.shippingInfo,
      this.billingInfo,
      this.paymentStatus,
      this.createdAt,
      this.updatedAt,
      this.statePrice,
      this.state});

  AddressModel get addressFormatted =>
      AddressModel.fromJson(jsonDecode(shippingInfo ?? "{}"));

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    if (json['cart'] != null) {
      cart = <Cart>[];
      json['cart'].forEach((v) {
        cart!.add(new Cart.fromJson(v));
      });
    }
    currencySign = json['currency_sign'];
    currencyValue = json['currency_value'];
    discount = json['discount'];
    shipping = Shipping.fromJson(json['shipping']);
    paymentMethod = json['payment_method'];
    txnid = json['txnid'];
    tax = json['tax'];
    chargeId = json['charge_id'];
    transactionNumber = json['transaction_number'];
    orderStatus = json['order_status'];
    shippingInfo = json['shipping_info'];
    billingInfo = json['billing_info'];
    paymentStatus = json['payment_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    statePrice = json['state_price'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    if (this.cart != null) {
      data['cart'] = this.cart!.map((v) => v.toJson()).toList();
    }
    data['currency_sign'] = this.currencySign;
    data['currency_value'] = this.currencyValue;
    data['discount'] = this.discount;
    data['shipping'] = this.shipping;
    data['payment_method'] = this.paymentMethod;
    data['txnid'] = this.txnid;
    data['tax'] = this.tax;
    data['charge_id'] = this.chargeId;
    data['transaction_number'] = this.transactionNumber;
    data['order_status'] = this.orderStatus;
    data['shipping_info'] = this.shippingInfo;
    data['billing_info'] = this.billingInfo;
    data['payment_status'] = this.paymentStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['state_price'] = this.statePrice;
    data['state'] = this.state;
    return data;
  }
}

class Cart {
  int? id;
  int? itemId;
  int? userId;
  int? orderId;
  int? vendorId;
  Map<String, dynamic>? options;
  dynamic? qty;
  int? confirmed;
  int? delivered;
  int? paid;
  int? canceled;
  String? cancelReason;
  String? createdAt;
  String? updatedAt;
  ItemModel? item;

  Cart(
      {this.id,
      this.itemId,
      this.userId,
      this.orderId,
      this.vendorId,
      this.options,
      this.qty,
      this.confirmed,
      this.delivered,
      this.paid,
      this.canceled,
      this.cancelReason,
      this.createdAt,
      this.updatedAt,
      this.item});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['item_id'];
    userId = json['user_id'];
    orderId = json['order_id'];
    vendorId = json['vendor_id'];
    options = json['options'];
    qty = json['qty'];
    confirmed = json['confirmed'];
    delivered = json['delivered'];
    paid = json['paid'];
    canceled = json['canceled'];
    cancelReason = json['cancel_reason'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    item = json['item'] != null ? ItemModel.fromJson(json['item']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_id'] = this.itemId;
    data['user_id'] = this.userId;
    data['order_id'] = this.orderId;
    data['vendor_id'] = this.vendorId;
    data['options'] = this.options;
    data['qty'] = this.qty;
    data['confirmed'] = this.confirmed;
    data['delivered'] = this.delivered;
    data['paid'] = this.paid;
    data['canceled'] = this.canceled;
    data['cancel_reason'] = this.cancelReason;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.item != null) {
      data['item'] = this.item!.toJson();
    }
    return data;
  }
}

class Shipping {
  Shipping({
    required this.id,
    required this.title,
    required this.price,
    required this.minimumPrice,
    required this.isCondition,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? title;
  final int? price;
  final int? minimumPrice;
  final int? isCondition;
  final int? status;
  final dynamic createdAt;
  final dynamic updatedAt;

  factory Shipping.fromJson(Map<String, dynamic> json){
    return Shipping(
      id: json["id"],
      title: json["title"],
      price: json["price"],
      minimumPrice: json["minimum_price"],
      isCondition: json["is_condition"],
      status: json["status"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "minimum_price": minimumPrice,
    "is_condition": isCondition,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };

}

