class GovernorateModel {
  GovernorateModel({
    required this.id,
    required this.name,
    required this.shippingPrice,
  });

  final int? id;
  final String? name;
  final String? shippingPrice;

  factory GovernorateModel.fromJson(Map<String, dynamic> json){
    return GovernorateModel(
      id: json["id"],
      name: json["name"],
      shippingPrice: json["shipping_price"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "shipping_price": shippingPrice,
  };

}