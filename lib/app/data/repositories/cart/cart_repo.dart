import 'dart:convert';

import 'package:customer/app/data/local/local_data_base.dart';
import 'package:customer/app/data/online/DioRequest.dart';
import 'package:customer/app/data/online/end_points.dart';
import 'package:customer/app/models/cart/cart_data.dart';
import 'package:customer/app/models/cart/cart_off_line_model.dart';
import 'package:flutter/material.dart';

import '../../../models/cart/cart_options_model.dart';

class CartRepo {
  LocalDataBase localDataBase = LocalDataBase();

  Future<bool> addToCart({
    required int itemId,
    required int qty,
    required CartOptions options,
  }) async {
    final data = {
      'item_id': itemId,
      'qty': qty,
      'options': options.toJson(),
    };
    final response = await postRequest(
        requiredToken: true,
        urlExt: EndPoints().addToCart,
        isJson: true,
        data: data);
    return response.data['status'];
  }

  void addToCartLocal({
    required String productId,
    String? variantId,
    required String productName,
    required String productPrice,
    required String productImage,
    required String productStock,
    required String quantity,
    required CartOptions options,
    String? shippingPrice,
  }) async {
    try {
      // Use parameterized queries to avoid SQL injection
      int response = await localDataBase.insertData(
          "INSERT INTO productCart (item_id, variant_id, name, price, image, stock, quantity, options, shippingPrice) "
          "VALUES ($productId, $variantId, '$productName', '$productPrice', '$productImage', '$productStock', '$quantity', '${jsonEncode(options)}', '$shippingPrice');");
      print("response of add to cart = $response");

      List<Map> responseGet =
          await localDataBase.readData("SELECT * From productCart");
      print("responseGet = ${responseGet.last}");
    } catch (error) {
      print("Error in addToCart: $error");
    }
  }

  Future<CartData> getCartItems() async {
    final response =
        await getRequest(urlExt: EndPoints().getCart, requireToken: true);

    return CartData.fromJson(response.data['data']);
  }

  Future<List<CartOffLineModel>> getOffLineCarts() async {
    List<CartOffLineModel> products = <CartOffLineModel>[];
    List<Map> response = await localDataBase.readData('''
          SELECT * FROM productCart;
        ''');
    products =
        (response as List).map((e) => CartOffLineModel.fromMap(e)).toList();
    // print(products[0].options?.optionsId);
    return products;
  }

  Future<void> clearCartTable() async {
    await localDataBase.deleteData('''
    DELETE FROM productCart;
  ''');
  }

  Future<bool> deleteCartItem({required int id}) async {
    final response = await getRequest(
        urlExt: EndPoints().deleteCartItem,
        params: {'id': id},
        requireToken: true);

    return response.data['status'];
  }

  Future<int> deleteCartItemLocal({required int id}) async {
    final response = await localDataBase
        .deleteData("DELETE FROM productCart WHERE id = $id;");

    return response;
  }

  Future<bool> updateCartItem({
    required CartItem item,
  }) async {
    final response = await putRequest(
        urlExt: EndPoints().updateCartItem,
        data: item.toJson(),
        requiredToken: true);
    return response.data['status'];
  }

  Future<bool> updateCartItemOffLine(
      {required int id, required int quantity}) async {
    final response = await localDataBase.updateData(
        "UPDATE productCart SET quantity = $quantity WHERE id = $id;");

    return response == 1 ? true : false;
  }

  Future<CartOffLineModel?> findOfflineCartItem({
    required String productId,
    String? variantId,
    required String optionsJson,
  }) async {
    final query = '''
    SELECT * FROM productCart 
    WHERE item_id = $productId
    AND variant_id ${variantId == null ? 'IS NULL' : '= $variantId'}
    AND options = '$optionsJson'
  ''';

    final result = await localDataBase.readData(query);
    if (result.isNotEmpty) {
      return CartOffLineModel.fromMap(result.first);
    }
    return null;
  }
}
