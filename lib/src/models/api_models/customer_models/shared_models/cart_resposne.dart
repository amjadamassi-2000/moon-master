import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:moonapp/src/controllers/api_controllers/customer_controllers/shared_controllers/products_controller.dart';
import 'package:moonapp/src/models/api_models/base_response.dart';
import 'package:moonapp/src/models/api_models/sub_models/addition.dart';
import 'package:moonapp/src/models/api_models/sub_models/product.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/utils/enums.dart';
import 'package:moonapp/src/utils/helpers.dart';

CartResponse cartResponseFromJson(String str) =>
    CartResponse.fromJson(json.decode(str));

String cartResponseToJson(CartResponse data) => json.encode(data.toJson());

class CartResponse extends BaseResponse {
  CartResponse({
    status,
    code,
    message,
    this.cart,
  }) : super(message: message, code: code, status: status);

  List<Cart> cart;

  factory CartResponse.fromJson(Map<String, dynamic> json) => CartResponse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        cart: List<Cart>.from(json["cart"].map((x) => Cart.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "cart": List<dynamic>.from(cart.map((x) => x.toJson())),
      };
}

class Cart with ChangeNotifier {
  Cart({
    this.id,
    this.productId,
    this.sizeId,
    this.quantity,
    this.type,
    this.userId,
    this.fcmToken,
    this.createdAt,
    this.product,
    this.additions,
  }) {
    _productsController = ProductsController.instance;
  }

  int id;
  int productId;
  int sizeId;
  //||.. notifiable ..||
  int quantity;
  int type;
  int userId;
  String fcmToken;
  DateTime createdAt;
  Product product;
  List<Addition> additions;

  //\\... private vars ...||
  ProductsController _productsController;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        productId: json["product_id"],
        sizeId: json["size_id"],
        quantity: json["quantity"],
        type: json["type"],
        userId: json["user_id"],
        fcmToken: json["fcmToken"],
        createdAt: DateTime.parse(json["created_at"]),
        product: Product.fromJson(json["product"]),
        additions: List<Addition>.from(
            json["additions"].map((x) => Addition.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "size_id": sizeId,
        "quantity": quantity,
        "type": type,
        "user_id": userId,
        "fcmToken": fcmToken,
        "created_at": createdAt.toIso8601String(),
        "product": product.toJson(),
        "additions": List<dynamic>.from(additions.map((x) => x.toJson())),
      };

  void changeQuantity(int type) {
    _changeQuantityRequest(type);
    if (type == Constants.CHANGE_QUANTITY_TYPE_INCREMENT)
      quantity++;
    else
      quantity--;
    notifyListeners();
  }

  //||........................ logic methods ...........................||

  void _changeQuantityRequest(int type) async {

   // try {
      BaseResponse baseResponse = await _productsController.changeQuantity(
          productId: this.product.id, type: type);
      if (!baseResponse.status)
        Helpers.showMessage(baseResponse.message, MessageType.MESSAGE_FAILED);
   }

//    catch (error) {
//      print(error.toString());
//      Helpers.showMessage(
//          AppShared.appLang['SomethingWentWrong'], MessageType.MESSAGE_FAILED);
//    }

  //}








  void removeProductFromCartRequest() async {
    try {
      BaseResponse baseResponse =
          await _productsController.removeProductFromCart(this.id);
      if (!baseResponse.status)
        Helpers.showMessage(baseResponse.message, MessageType.MESSAGE_FAILED);
    } catch (error) {
      print(error.toString());
      Helpers.showMessage(
          AppShared.appLang['SomethingWentWrong'], MessageType.MESSAGE_FAILED);
    }
  }

  //||........................ logic methods ...........................||
}
