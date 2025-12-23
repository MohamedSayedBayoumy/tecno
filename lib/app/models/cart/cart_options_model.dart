import 'dart:convert';

class CartOptions {
  List<int>? optionsId;
  Attribute? attribute;
  int? attributeId;
  double? attributePrice;
  String? name;
  String? slug;
  String? qty;
  double? price;
  // double? mainPrice;
  String? photo;
  String? type;
  String? itemType;

  CartOptions(
      {this.optionsId,
      this.attribute,
      this.attributeId,
      this.attributePrice,
      this.name,
      this.slug,
      this.qty,
      this.price,
      // this.mainPrice,
      this.photo,
      this.type,
      this.itemType});

  CartOptions.fromJson(Map<String, dynamic> json) {
    optionsId = json['options_id'].cast<int>();
    attribute = json['attribute'] != null
        ? new Attribute.fromJson(json['attribute'])
        : null;
    attributeId = json['attribute_id'];
    attributePrice = json['attribute_price'];
    name = json['name'];
    slug = json['slug'];
    qty = json['qty'];
    price = json['price'];
    // mainPrice = json['main_price'];
    photo = json['photo'];
    type = json['type'];
    itemType = json['item_type'];
  }

  factory CartOptions.fromMap(Map<String, dynamic> map) {
    return CartOptions(
      optionsId: map['options_id'] != null
          ? List<int>.from(map['options_id'])
          : null,
      attribute:
          map['attribute'] != null ? Attribute.fromMap(map['attribute']) : null,
      attributeId: map['attribute_id'],
      attributePrice: (map['attributePrice'] as num?)?.toDouble(),
      name: map['name'],
      slug: map['slug'],
      photo: map['photo'],
      price: (map['price'] as num?)?.toDouble(),
      // mainPrice: (map['mainPrice'] as num?)?.toDouble(),
      itemType: map['itemType'],
      qty: map['qty'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['options_id'] = optionsId as List;
    if (attribute != null) {
      data['attribute'] = attribute!.toJson();
    }
    data['attribute_id'] = attributeId;
    data['attribute_price'] = attributePrice;
    data['name'] = name;
    data['slug'] = slug;
    data['qty'] = qty;
    data['price'] = price;
    // data['main_price'] = mainPrice;
    data['photo'] = photo;
    data['type'] = type;
    data['item_type'] = itemType;
    return data;
  }
}

class Attribute {
  List<dynamic>? names;
  List<dynamic>? optionId;
  List<dynamic>? optionName;
  List<dynamic>? optionPrice;

  Attribute({
    this.names,
    this.optionName,
    this.optionPrice,
    this.optionId,
  });

  Attribute.fromJson(Map<String, dynamic> json) {
    names = json['names'].cast<String>();
    optionId = json['option_id'].cast<int>();
    optionName = json['option_name'].cast<String>();
    optionPrice = json['option_price'].cast<double>();
  }

  factory Attribute.fromMap(Map<String, dynamic> map) {
    return Attribute(
      names: map['names'],
      optionId: map['option_id'],
      optionName: map['option_name'],
      optionPrice: map['option_price'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['names'] = (names?.toList() ?? []);
    data['option_id'] = (optionId?.toList() ?? []);
    data['option_name'] = (optionName?.toList() ?? []);
    data['option_price'] = (optionPrice?.toList() ?? []);
    return data;
  }
}
