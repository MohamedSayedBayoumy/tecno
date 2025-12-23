// import '../../config/config.dart';
//
// class ProfileModel {
//   int? id;
//   String? firstName;
//   String? lastName;
//   String? phone;
//   String? email;
//   String? photo;
//   String? emailToken;
//   String? shipAddress1;
//   String? shipAddress2;
//   String? shipZip;
//   String? shipCity;
//   String? shipCountry;
//   String? shipCompany;
//   String? billAddress1;
//   String? billAddress2;
//   String? billZip;
//   String? billCity;
//   String? billCountry;
//   String? billCompany;
//   String? createdAt;
//   String? updatedAt;
//   int? stateId;
//   String? emailVerifiedAt;
//
//   String get image => photo != null
//       ? '${Config().url}/$photo'
//       : 'https://as2.ftcdn.net/v2/jpg/01/07/43/45/1000_F_107434511_iarF2z88c6Ds6AlgtwotHSAktWCdYOn7.jpg';
//
//   ProfileModel(
//       this.id,
//       this.firstName,
//       this.lastName,
//       this.phone,
//       this.email,
//       this.photo,
//       this.emailToken,
//       this.shipAddress1,
//       this.shipAddress2,
//       this.shipZip,
//       this.shipCity,
//       this.shipCountry,
//       this.shipCompany,
//       this.billAddress1,
//       this.billAddress2,
//       this.billZip,
//       this.billCity,
//       this.billCountry,
//       this.billCompany,
//       this.createdAt,
//       this.updatedAt,
//       this.stateId,
//       this.emailVerifiedAt);
//
//   ProfileModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     phone = json['phone'];
//     email = json['email'];
//     photo = json['photo'] ?? '';
//     emailToken = json['email_token'];
//     shipAddress1 = json['ship_address1'];
//     shipAddress2 = json['ship_address2'];
//     shipZip = json['ship_zip'];
//     shipCity = json['ship_city'];
//     shipCountry = json['ship_country'];
//     shipCompany = json['ship_company'];
//     billAddress1 = json['bill_address1'];
//     billAddress2 = json['bill_address2'];
//     billZip = json['bill_zip'];
//     billCity = json['bill_city'];
//     billCountry = json['bill_country'];
//     billCompany = json['bill_company'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     stateId = json['state_id'];
//     emailVerifiedAt = json['email_verified_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['first_name'] = firstName;
//     data['last_name'] = lastName;
//     data['phone'] = phone;
//     data['email'] = email;
//     data['photo'] = photo;
//     data['email_token'] = emailToken;
//     data['ship_address1'] = shipAddress1;
//     data['ship_address2'] = shipAddress2;
//     data['ship_zip'] = shipZip;
//     data['ship_city'] = shipCity;
//     data['ship_country'] = shipCountry;
//     data['ship_company'] = shipCompany;
//     data['bill_address1'] = billAddress1;
//     data['bill_address2'] = billAddress2;
//     data['bill_zip'] = billZip;
//     data['bill_city'] = billCity;
//     data['bill_country'] = billCountry;
//     data['bill_company'] = billCompany;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     data['state_id'] = stateId;
//     data['email_verified_at'] = emailVerifiedAt;
//     return data;
//   }
// }

import '../cart/address_model.dart';

class ProfileModel {
  ProfileModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final ProfileDataModel? data;

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      status: json["status"],
      message: json["message"],
      data:
          json["data"] == null ? null : ProfileDataModel.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class ProfileDataModel {
  ProfileDataModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.photo,
    required this.emailToken,
    required this.shipAddress1,
    required this.shipAddress2,
    required this.shipZip,
    required this.shipCity,
    required this.shipCityName,
    required this.shipCountry,
    required this.shipCountryName,
    required this.shipCompany,
    required this.createdAt,
    required this.updatedAt,
    required this.stateId,
    required this.emailVerifiedAt,
    this.addressData,
    required this.verificationToken,
  });

  final int? id;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? email;
  final String? photo;
  final String? emailToken;
  final String? shipAddress1;
  final String? shipAddress2;
  final String? shipZip;
  final String? shipCity;
  final String? shipCityName;
  final String? shipCountry;
  final String? shipCountryName;
  final String? shipCompany;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic stateId;
  final dynamic emailVerifiedAt;
  final String? verificationToken;
  final AddressData? addressData;

  factory ProfileDataModel.fromJson(Map<String, dynamic> json) {
    return ProfileDataModel(
      id: json["id"],
      firstName: json["first_name"] ?? "",
      lastName: json["last_name"] ?? "",
      phone: json["phone"] ?? "",
      email: json["email"] ?? "",
      photo: json["photo"],
      emailToken: json["email_token"],
      shipAddress1: json["ship_address1"] ?? "",
      shipAddress2: json["ship_address2"] ?? "",
      shipZip: json["ship_zip"] ?? "",
      shipCity: json["ship_city"] ?? "",
      shipCityName: json["ship_city_name"] ?? "",
      shipCountry: json["ship_country"] ?? "",
      shipCountryName: json["ship_country_name"] ?? "",
      shipCompany: json["ship_company"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      stateId: json["state_id"],
      emailVerifiedAt: json["email_verified_at"],
      verificationToken: json["verification_token"],
      addressData: json["address"] == null
          ? null
          : AddressData.fromJson(json["address"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "email": email,
        "photo": photo,
        "email_token": emailToken,
        "ship_address1": shipAddress1,
        "ship_address2": shipAddress2,
        "ship_zip": shipZip,
        "ship_city": shipCity,
        "ship_city_name": shipCityName,
        "ship_country": shipCountry,
        "ship_country_name": shipCountryName,
        "ship_company": shipCompany,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "state_id": stateId,
        "email_verified_at": emailVerifiedAt,
        "verification_token": verificationToken,
      };
}
