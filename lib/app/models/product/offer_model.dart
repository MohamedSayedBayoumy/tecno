import 'package:customer/app/models/product/item.dart';

class OfferModel {
  int? id;
  int? itemId;
  ItemModel? item;

  OfferModel({this.id, this.itemId, this.item});

  OfferModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['item_id'];
    item = json['item'] != null ? ItemModel.fromJson(json['item']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_id'] = this.itemId;
    if (this.item != null) {
      data['item'] = this.item!.toJson();
    }
    return data;
  }
}
