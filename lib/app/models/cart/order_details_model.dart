// import 'dart:convert';
//
// class OrderDetailsModel {
//   OrderDetailsModel({
//     required this.id,
//     required this.userId,
//     required this.cart,
//     required this.currencySign,
//     required this.currencyValue,
//     required this.discount,
//     required this.shipping,
//     required this.paymentMethod,
//     required this.txnid,
//     required this.tax,
//     required this.chargeId,
//     required this.transactionNumber,
//     required this.orderStatus,
//     required this.shippingInfo,
//     required this.billingInfo,
//     required this.paymentStatus,
//     required this.vendors,
//     required this.shippingCompanyId,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.statePrice,
//     required this.state,
//     required this.totalPrice,
//   });
//
//   final int? id;
//   final int? userId;
//   final List<Cart> cart;
//   final String? currencySign;
//   final String? currencyValue;
//   final String? discount;
//   final Shipping? shipping;
//   final String? paymentMethod;
//   final dynamic txnid;
//   final int? tax;
//   final dynamic chargeId;
//   final String? transactionNumber;
//   final String? orderStatus;
//   final ShippingInfo? shippingInfo;
//   final dynamic billingInfo;
//   final String? paymentStatus;
//   final dynamic vendors;
//   final dynamic shippingCompanyId;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final int? statePrice;
//   final dynamic state;
//   final int? totalPrice;
//
//   // factory OrderDetailsModel.fromJson(Map<String, dynamic> json){
//   //   return OrderDetailsModel(
//   //     id: json["id"],
//   //     userId: json["user_id"],
//   //     cart: json["cart"] == null ? [] : List<Cart>.from(json["cart"]!.map((x) => Cart.fromJson(x))),
//   //     currencySign: json["currency_sign"],
//   //     currencyValue: json["currency_value"],
//   //     discount: json["discount"],
//   //     shipping: json["shipping"] == null ? null : Shipping.fromJson(json["shipping"]),
//   //     paymentMethod: json["payment_method"],
//   //     txnid: json["txnid"],
//   //     tax: json["tax"],
//   //     chargeId: json["charge_id"],
//   //     transactionNumber: json["transaction_number"],
//   //     orderStatus: json["order_status"],
//   //     shippingInfo: jsonDecode(json["shipping_info"]),
//   //     billingInfo: json["billing_info"],
//   //     paymentStatus: json["payment_status"],
//   //     vendors: json["vendors"],
//   //     shippingCompanyId: json["shipping_company_id"],
//   //     createdAt: DateTime.tryParse(json["created_at"] ?? ""),
//   //     updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
//   //     statePrice: json["state_price"],
//   //     state: json["state"],
//   //     totalPrice: json["total_price"],
//   //   );
//   // }
//
//   factory OrderDetailsModel.fromJson(Map<String, dynamic> json) {
//     return OrderDetailsModel(
//       id: json["id"],
//       userId: json["user_id"],
//       cart: json["cart"] == null ? [] : List<Cart>.from(json["cart"]!.map((x) => Cart.fromJson(x))),
//       currencySign: json["currency_sign"],
//       currencyValue: json["currency_value"],
//       discount: json["discount"],
//       shipping: json["shipping"] == null ? null : Shipping.fromJson(json["shipping"]),
//       paymentMethod: json["payment_method"],
//       txnid: json["txnid"],
//       tax: json["tax"],
//       chargeId: json["charge_id"],
//       transactionNumber: json["transaction_number"],
//       orderStatus: json["order_status"],
//       shippingInfo: json["shipping_info"] != null
//           ? ShippingInfo.fromJson(jsonDecode(json["shipping_info"]))
//           : null,
//       billingInfo: json["billing_info"],
//       paymentStatus: json["payment_status"],
//       vendors: json["vendors"],
//       shippingCompanyId: json["shipping_company_id"],
//       createdAt: DateTime.tryParse(json["created_at"] ?? ""),
//       updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
//       statePrice: json["state_price"],
//       state: json["state"],
//       totalPrice: json["total_price"],
//     );
//   }
//
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "user_id": userId,
//     "cart": cart.map((x) => x?.toJson()).toList(),
//     "currency_sign": currencySign,
//     "currency_value": currencyValue,
//     "discount": discount,
//     "shipping": shipping?.toJson(),
//     "payment_method": paymentMethod,
//     "txnid": txnid,
//     "tax": tax,
//     "charge_id": chargeId,
//     "transaction_number": transactionNumber,
//     "order_status": orderStatus,
//     "shipping_info": shippingInfo,
//     "billing_info": billingInfo,
//     "payment_status": paymentStatus,
//     "vendors": vendors,
//     "shipping_company_id": shippingCompanyId,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//     "state_price": statePrice,
//     "state": state,
//     "total_price": totalPrice,
//   };
//
// }
//
// class Cart {
//   Cart({
//     required this.name,
//     required this.itemId,
//     required this.optionsId,
//     required this.attribute,
//     required this.attributePrice,
//     required this.price,
//     required this.slug,
//     required this.photo,
//     required this.qty,
//     required this.itemType,
//   });
//
//   final String? name;
//   final int? itemId;
//   final dynamic optionsId;
//   final dynamic attribute;
//   final int? attributePrice;
//   final int? price;
//   final String? slug;
//   final String? photo;
//   final dynamic qty;
//   final String? itemType;
//
//   factory Cart.fromJson(Map<String, dynamic> json){
//     return Cart(
//       name: json["name"],
//       itemId: json["item_id"],
//       optionsId: json["options_id"],
//       attribute: json["attribute"],
//       attributePrice: json["attribute_price"],
//       price: json["price"],
//       slug: json["slug"],
//       photo: json["photo"],
//       qty: json["qty"],
//       itemType: json["item_type"],
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     "name": name,
//     "item_id": itemId,
//     "options_id": optionsId,
//     "attribute": attribute,
//     "attribute_price": attributePrice,
//     "price": price,
//     "slug": slug,
//     "photo": photo,
//     "qty": qty,
//     "item_type": itemType,
//   };
//
// }
//
// class Shipping {
//   Shipping({
//     required this.id,
//     required this.title,
//     required this.price,
//     required this.minimumPrice,
//     required this.isCondition,
//     required this.status,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   final int? id;
//   final String? title;
//   final int? price;
//   final int? minimumPrice;
//   final int? isCondition;
//   final int? status;
//   final dynamic createdAt;
//   final dynamic updatedAt;
//
//   factory Shipping.fromJson(Map<String, dynamic> json){
//     return Shipping(
//       id: json["id"],
//       title: json["title"],
//       price: json["price"],
//       minimumPrice: json["minimum_price"],
//       isCondition: json["is_condition"],
//       status: json["status"],
//       createdAt: json["created_at"],
//       updatedAt: json["updated_at"],
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "title": title,
//     "price": price,
//     "minimum_price": minimumPrice,
//     "is_condition": isCondition,
//     "status": status,
//     "created_at": createdAt,
//     "updated_at": updatedAt,
//   };
//
// }
//
// class ShippingInfo {
//   ShippingInfo({
//      this.shipFirstName,
//      this.shipLastName,
//      this.shipEmail,
//      this.shipPhone,
//      this.shipAddress1,
//     this.shipAddress2,
//      this.shipCity,
//      this.shipZip,
//      this.shipCountry,
//   });
//
//   final String? shipFirstName;
//   final String? shipLastName;
//   final String? shipEmail;
//   final String? shipPhone;
//   final String? shipAddress1;
//   final String? shipAddress2;
//   final String? shipCity;
//   final String? shipZip;
//   final String? shipCountry;
//
//   // Factory method to create an instance from JSON
//   factory ShippingInfo.fromJson(Map<String, dynamic> json) {
//     return ShippingInfo(
//       shipFirstName: json['ship_first_name'],
//       shipLastName: json['ship_last_name'],
//       shipEmail: json['ship_email'],
//       shipPhone: json['ship_phone'],
//       shipAddress1: json['ship_address1'],
//       shipAddress2: json['ship_address2'],
//       shipCity: json['ship_city'],
//       shipZip: json['ship_zip'],
//       shipCountry: json['ship_country'],
//     );
//   }
//
//   // Method to convert instance to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'ship_first_name': shipFirstName,
//       'ship_last_name': shipLastName,
//       'ship_email': shipEmail,
//       'ship_phone': shipPhone,
//       'ship_address1': shipAddress1,
//       'ship_address2': shipAddress2,
//       'ship_city': shipCity,
//       'ship_zip': shipZip,
//       'ship_country': shipCountry,
//     };
//   }
// }
//

import 'dart:developer';

class OrderDetailsModel {
  OrderDetailsModel({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.totalPrice,
    required this.shippingPrice,
    required this.currencySign,
    required this.currencyValue,
    required this.transactionNumber,
    required this.paymentMethod,
    required this.txnid,
    required this.orderStatus,
    required this.paymentStatus,
    required this.shipping,
    required this.shippingInfo,
    this.rating,
    this.orderDetails = const [],
  });

  final int? id;
  final int? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? totalPrice;
  final String? shippingPrice;
  final String? currencySign;
  final String? currencyValue;
  final String? transactionNumber;
  final String? paymentMethod;
  final String? txnid;
  final String? orderStatus;
  final String? paymentStatus;
  final String? shipping;
  final ShippingInfo? shippingInfo;
  final List<OrderDetail> orderDetails;
  final Rating? rating;

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailsModel(
      id: json["id"],
      userId: json["user_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      totalPrice: json["total_price"],
      shippingPrice: json["shipping_price"],
      currencySign: json["currency_sign"],
      currencyValue: json["currency_value"],
      transactionNumber: json["transaction_number"],
      paymentMethod: json["payment_method"],
      txnid: json["txnid"],
      orderStatus: json["order_status"],
      paymentStatus: json["payment_status"] ?? "",
      shipping: json["shipping"],
      rating: json["rating"] == null ? null : Rating.fromJson(json["rating"]),
      shippingInfo: json["shipping_info"] == null
          ? null
          : ShippingInfo.fromJson(json["shipping_info"]),
      orderDetails: json["order_details"] == null
          ? []
          : List<OrderDetail>.from(
              json["order_details"]!.map((x) => OrderDetail.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "total_price": totalPrice,
        "shipping_price": shippingPrice,
        "currency_sign": currencySign,
        "currency_value": currencyValue,
        "transaction_number": transactionNumber,
        "payment_method": paymentMethod,
        "txnid": txnid,
        "order_status": orderStatus,
        "payment_status": paymentStatus,
        "shipping": shipping,
        "shipping_info": shippingInfo?.toJson(),
        "order_details": orderDetails.map((x) => x.toJson()).toList(),
      };
}

class Rating {
  int id;
  int orderId;
  int userId;
  int rating;
  String review;
  String createdAt;

  Rating({
    this.id = 0,
    this.orderId = 0,
    this.userId = 0,
    this.rating = 0,
    this.review = "",
    this.createdAt = "",
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      id: json['id'] ?? 0,
      orderId: json['order_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      rating: json['rating'] ?? 0,
      review: json['review'] ?? "",
      createdAt: json['created_at'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "order_id": orderId,
      "user_id": userId,
      "rating": rating,
      "review": review,
      "created_at": createdAt,
    };
  }
}

class OrderDetail {
  OrderDetail({
    required this.id,
    required this.orderId,
    required this.itemId,
    required this.itemName,
    required this.variantId,
    required this.variantName,
    required this.price,
    required this.quantity,
    required this.total,
    required this.photo,
    this.rating,
  });

  final int? id;
  final int? orderId;
  final int? itemId;
  final String? itemName;
  final int? variantId;
  final String? variantName;
  final String? price;
  final int? quantity;
  final String? total;
  final String? photo;
  final Rating? rating;

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    log("###### $json");

    return OrderDetail(
      id: json["id"],
      orderId: json["order_id"],
      itemId: json["item_id"],
      itemName: json["item_name"],
      variantId: json["variant_id"],
      variantName: json["variant_name"],
      price: json["price"],
      quantity: json["quantity"],
      total: json["total"],
      photo: json["photo"],
      rating: json["rating"] == null ? null : Rating.fromJson(json["rating"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "item_id": itemId,
        "item_name": itemName,
        "variant_id": variantId,
        "variant_name": variantName,
        "price": price,
        "quantity": quantity,
        "total": total,
        "photo": photo,
        "rating": rating!.toJson(),
      };
}

class ShippingInfo {
  ShippingInfo({
    required this.shipFirstName,
    required this.shipLastName,
    required this.shipEmail,
    required this.shipPhone,
    required this.shipAddress1,
    required this.shipAddress2,
    required this.shipCity,
    required this.shipZip,
    required this.shipCountry,
  });

  final dynamic? shipFirstName;
  final dynamic? shipLastName;
  final dynamic? shipEmail;
  final dynamic? shipPhone;
  final dynamic? shipAddress1;
  final dynamic? shipAddress2;
  final dynamic? shipCity;
  final dynamic? shipZip;
  final dynamic? shipCountry;

  factory ShippingInfo.fromJson(Map<String, dynamic> json) {
    return ShippingInfo(
      shipFirstName: json["ship_first_name"],
      shipLastName: json["ship_last_name"],
      shipEmail: json["ship_email"],
      shipPhone: json["ship_phone"],
      shipAddress1: json["ship_address1"],
      shipAddress2: json["ship_address2"],
      shipCity: json["ship_city"],
      shipZip: json["ship_zip"],
      shipCountry: json["ship_country"],
    );
  }

  Map<String, dynamic> toJson() => {
        "ship_first_name": shipFirstName,
        "ship_last_name": shipLastName,
        "ship_email": shipEmail,
        "ship_phone": shipPhone,
        "ship_address1": shipAddress1,
        "ship_address2": shipAddress2,
        "ship_city": shipCity,
        "ship_zip": shipZip,
        "ship_country": shipCountry,
      };
}
