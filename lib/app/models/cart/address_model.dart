import 'package:get/get.dart';

class AddressModel {
  String? id;
  String? userId;
  String? shipFirstName;
  String? shipLastName;
  String? shipEmail;
  String? shipPhone;
  String? shipCompany;
  String? shipAddress1;
  String? shipAddress2;
  String? shipZip;
  String? shipCity;
  String? shipCountry;
  double? lat;
  double? lng;
  String? createdAt;
  String? updatedAt;

  AddressModel(
      {this.id,
      this.userId,
      this.shipFirstName,
      this.shipLastName,
      this.shipEmail,
      this.shipPhone,
      this.shipCompany,
      this.shipAddress1,
      this.shipAddress2,
      this.shipZip,
      this.shipCity,
      this.shipCountry,
      this.lat,
      this.lng,
      this.createdAt,
      this.updatedAt});

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = '${json['id']}';
    userId = '${json['user_id']}';
    shipFirstName = json['ship_first_name'];
    shipLastName = json['ship_last_name'];
    shipEmail = json['ship_email'];
    shipPhone = json['ship_phone'];
    shipCompany = json['ship_company'];
    shipAddress1 = json['ship_address1'];
    shipAddress2 = json['ship_address2'];
    shipZip = json['ship_zip'];
    shipCity = json['ship_city'];
    shipCountry = json['ship_country'];
    lat = double.tryParse('${json['lat']}');
    lng = double.tryParse('${json['lng']}');
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['ship_first_name'] = shipFirstName;
    data['ship_last_name'] = shipLastName;
    data['ship_email'] = shipEmail;
    data['ship_phone'] = shipPhone;
    data['ship_company'] = shipCompany;
    data['ship_address1'] = shipAddress1;
    data['ship_address2'] = shipAddress2;
    data['ship_zip'] = shipZip;
    data['ship_city'] = shipCity;
    data['ship_country'] = shipCountry;
    data['lat'] = lat;
    data['lng'] = lng;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class AddressResponse {
  final bool status;
  final String message;
  final List<AddressData> data;

  AddressResponse({
    this.status = false,
    this.message = "",
    this.data = const [],
  });

  factory AddressResponse.fromJson(Map<String, dynamic> json) {
    return AddressResponse(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
      data: (json["data"] as List<dynamic>?)
              ?.map((e) => AddressData.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "message": message,
      "data": data.map((e) => e.toJson()).toList(),
    };
  }
}

class AddressData {
  final int id;
  final int? cityId;
  final double? lat;
  final double? long;
  final String building;
  final String flat;
  final String floor;
  final String additionalPhone;
  final bool isDefault;
  final String createdAt;
  final String updatedAt;
  final String area;

  final String address;

  AddressData({
    this.id = 0,
    this.cityId = 0,
    this.lat,
    this.long,
    this.building = "",
    this.flat = "",
    this.floor = "",
    this.additionalPhone = "",
    this.isDefault = false,
    this.createdAt = "",
    this.updatedAt = "",
    this.address = "",
    this.area = "",
  });

  factory AddressData.fromJson(Map<String, dynamic> json) {
    final building = json["building"] ?? "";
    final flat = json["flat"] ?? "";
    final floor = json["floor"] ?? "";
    final area = json["area"] ?? "";

    return AddressData(
      id: json["id"] ?? 0,
      cityId: json["country_id"],
      lat: json["lat"] != null ? double.tryParse(json["lat"].toString()) : null,
      long: json["long"] != null
          ? double.tryParse(json["long"].toString())
          : null,
      building: building,
      flat: flat,
      floor: floor,
      additionalPhone: json["additional_phone"] ?? "",
      isDefault: json["is_default"] ?? false,
      createdAt: json["created_at"] ?? "",
      updatedAt: json["updated_at"] ?? "",
      area: json["area"] ?? "",
      address:
          "${area ?? ""}\n${"apartment_number".tr}: $building\n${"building_number".tr}: $floor\n${"floor_number".tr}: $flat",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "lat": lat,
      "long": long,
      "building": building,
      "flat": flat,
      "floor": floor,
      "cityId": cityId,
      "additional_phone": additionalPhone,
      "is_default": isDefault,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "address": address, // بقى key فعلي
    };
  }
}
