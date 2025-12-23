import 'package:customer/app/models/product/item.dart';

class WishListModel {
  int? id;
  int? userId;
  int? itemId;
 
  ItemModel? item;

  WishListModel(
      {this.id,
      this.userId,
      this.itemId,
    
      this.item});

  WishListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    itemId = json['item_id'];
    item = json['item'] != null ?  ItemModel.fromJson(json['item']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['item_id'] = this.itemId;
    if (this.item != null) {
      data['item'] = this.item!.toJson();
    }
    return data;
  }
}
