import '../../config/config.dart';

class PaymentMethod {
  int? id;
  String? name;
  String? uniqueKeyword;
  String? photo;
  String? text;

  PaymentMethod({this.id, this.name, this.uniqueKeyword, this.photo,this.text});
  String get image => '${Config().url}/$photo';

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    uniqueKeyword = json['unique_keyword'];
    photo = json['photo'];
    text = json['text'];
  }
  factory PaymentMethod.fromMap(Map<String, dynamic> map) {
    return PaymentMethod(
      id: map['id'],
      name: map['name'],
      uniqueKeyword: map['uniqueKeyword'],
      photo: map['photo'],
      text: map['text']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['unique_keyword'] = this.uniqueKeyword;
    data['photo'] = this.photo;
    data['text'] = this.text;
    return data;
  }
}
