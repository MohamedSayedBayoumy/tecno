class PlaceOrder {
  PlaceOrder({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final Data? data;

  factory PlaceOrder.fromJson(Map<String, dynamic> json){
    return PlaceOrder(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };

}

class Data {
  Data({
    required this.status,
    required this.paymentUrl,
    required this.order,
    required this.totalAmount,
  });

  final bool? status;
  final String? paymentUrl;
  final Order? order;
  final int? totalAmount;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      status: json["status"],
      paymentUrl: json["payment_url"],
      order: json["order"] == null ? null : Order.fromJson(json["order"]),
      totalAmount: json["total_amount"],
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "payment_url": paymentUrl,
    "order": order?.toJson(),
    "total_amount": totalAmount,
  };

}

class Order {
  Order({
    required this.discount,
    required this.shipping,
    required this.tax,
    required this.shippingInfo,
    required this.billingInfo,
    required this.paymentMethod,
    required this.userId,
    required this.transactionNumber,
    required this.currencySign,
    required this.currencyValue,
    required this.paymentStatus,
    required this.orderStatus,
  });

  final String? discount;
  final String? shipping;
  final int? tax;
  final String? shippingInfo;
  final String? billingInfo;
  final String? paymentMethod;
  final int? userId;
  final String? transactionNumber;
  final String? currencySign;
  final int? currencyValue;
  final String? paymentStatus;
  final String? orderStatus;

  factory Order.fromJson(Map<String, dynamic> json){
    return Order(
      discount: json["discount"],
      shipping: json["shipping"],
      tax: json["tax"],
      shippingInfo: json["shipping_info"],
      billingInfo: json["billing_info"],
      paymentMethod: json["payment_method"],
      userId: json["user_id"],
      transactionNumber: json["transaction_number"],
      currencySign: json["currency_sign"],
      currencyValue: json["currency_value"],
      paymentStatus: json["payment_status"],
      orderStatus: json["order_status"],
    );
  }

  Map<String, dynamic> toJson() => {
    "discount": discount,
    "shipping": shipping,
    "tax": tax,
    "shipping_info": shippingInfo,
    "billing_info": billingInfo,
    "payment_method": paymentMethod,
    "user_id": userId,
    "transaction_number": transactionNumber,
    "currency_sign": currencySign,
    "currency_value": currencyValue,
    "payment_status": paymentStatus,
    "order_status": orderStatus,
  };

}
