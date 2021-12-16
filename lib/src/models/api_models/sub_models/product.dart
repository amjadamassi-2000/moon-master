import 'dart:wasm';

import 'package:flutter/foundation.dart';
import 'package:moonapp/src/controllers/api_controllers/customer_controllers/shared_controllers/products_controller.dart';
import 'package:moonapp/src/models/api_models/base_response.dart';
import 'package:moonapp/src/models/api_models/sub_models/addition.dart';
import 'package:moonapp/src/models/api_models/sub_models/attachment.dart';
import 'package:moonapp/src/models/api_models/sub_models/size.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/utils/enums.dart';
import 'package:moonapp/src/utils/helpers.dart';

class Product with ChangeNotifier {


  Product({
    this.id,
    this.categoryId,
    this.price,
    this.count, // ====
    this.image,
    this.discount,
    this.offerFrom,
    this.offerTo,
    this.type,
    this.section,
    this.order,
    this.available,
    this.topSelling,
    this.newest,
    this.rate,
    this.views,
    this.likeCount,
    this.status,
    this.createdAt,
    this.availableOffer,
    this.isFavorite,
    this.isLike,
    this.isCart,
    this.name,
    this.description,

    this.attachments,
    this.additions,
    this.new_price,
    this.offer_price,
    this.sizes,
  }

  )
  {
    __productsController = ProductsController.instance;
  }

  int id;
  int categoryId;
  double price;
  dynamic count;
  String image;
  String offer_price;
  num discount;
  dynamic offerFrom;
  dynamic offerTo;
  int type;
  int section;
  int order;
  int available;
  int topSelling;
  int newest;
  int rate;
  int views;
  int likeCount;
  String status;
  String new_price;
  DateTime createdAt;
  String availableOffer;
  //||... notifiable vars ...||
  String isFavorite;
  String isLike;
  String isCart;
  //||... notifiable vars ...||
  String name;
  String description;
  List<Attachment> attachments;
  List<Addition> additions;
  List<Size> sizes;

  // ||... private vars ...||
  ProductsController __productsController;
  // ||... private vars ...||

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        categoryId: json["category_id"],
        price: double.parse(json["price"].toString()),
        count: json["count"],
        offer_price: json["offer_price"],
        image: json["image"],
        discount: json["discount"],
        offerFrom: json["offer_from"],
        offerTo: json["offer_to"],
        type: json["type"],
        section: json["section"],
        order: json["order"],
        available: json["available"],
        topSelling: json["top_selling"],
        newest: json["newest"],
        new_price: json["new_price"],
        rate: json["rate"],
        views: json["views"],
        likeCount: json["like_count"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        availableOffer: json["available_offer"],
        isFavorite: json["is_favorite"],
        isLike: json["is_like"],
        isCart: json["is_cart"],
        name: json["name"],
        description: json["description"],
        attachments: json["attachments"]
           == null
           ? null
           : List<Attachment>.from(
               json["attachments"].map(
                 (x) => Attachment.fromJson(x),
               ),
             ),



        sizes: json["sizes"] == null
            ? null
            : List<Size>.from(
                json["sizes"].map(
                  (x) => Size.fromJson(x),
                ),
              ),
        additions: json["additions"] == null
            ? null
            : List<Addition>.from(
                json["additions"].map(
                  (x) => Addition.fromJson(x),
                ),
              ),
      );



  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "price": price,
        "count": count,
        "image": image,
        "discount": discount,
        "offer_from": offerFrom,
        "offer_to": offerTo,
        "type": type,
        "section": section,
        "order": order,
        "available": available,
        "top_selling": topSelling,
        "newest": newest,
        "rate": rate,
        "views": views,
        "like_count": likeCount,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "available_offer": availableOffer,
        "is_favorite": isFavorite,
        "is_like": isLike,
        "is_cart": isCart,
        "name": name,
        "description": description,
        "attachments": List<dynamic>.from(attachments.map((x) => x.toJson())),
        "additions": List<dynamic>.from(additions.map((x) => x.toJson())),
        "sizes": List<dynamic>.from(sizes.map((x) => x.toJson())),
      };

  //  ||... notifiable  ...||
  // add or remove from favorite .

  void changeIsFavorite() {
    _changeIsFavoriteRequest();
    if (isFavorite == "0")
      isFavorite = "1";
    else
      isFavorite = "0";
    notifyListeners();
  }





  // like or unlike the product.
  void changeIsLike() {
    _likeOrUnlikeRequest();
    if (isLike == "0")
      isLike = "1";
    else
      isLike = "0";
    notifyListeners();
  }

  void changeQuantity(int type) {
    int value = int.parse(isCart);
    if (type == Constants.CHANGE_QUANTITY_TYPE_INCREMENT) {
      value++;
      isCart = value.toString();
      if (value == 1)
        addProductToCartRequest();
      else
        _changeQuantityRequest(type);
    } else {
      value--;
      isCart = value.toString();
      _changeQuantityRequest(type);
    }
    notifyListeners();
  }

//  ||... notifiable  ...||

  //||............................ logic methods ....................................||

  void _changeIsFavoriteRequest() async {
    try {
      BaseResponse baseResponse;
      baseResponse = await __productsController.addProductToFavorites(this.id);
      if (!baseResponse.status) {
        Helpers.showMessage(baseResponse.message, MessageType.MESSAGE_FAILED);
      }
    } catch (error) {
      print(error);
      Helpers.showMessage(
          AppShared.appLang['SomethingWentWrong'], MessageType.MESSAGE_FAILED);
    }
  }

// like a product
  void _likeOrUnlikeRequest() async {
    try {
      BaseResponse baseResponse =
          await __productsController.likeAProduct(this.id);
      if (!baseResponse.status) {
        Helpers.showMessage(baseResponse.message, MessageType.MESSAGE_FAILED);
      }
    } catch (error) {
      print(error.message);
      Helpers.showMessage(
          AppShared.appLang['SomethingWentWrong'], MessageType.MESSAGE_FAILED);
    }
  }

  void _changeQuantityRequest(int type) async {
    try {
      BaseResponse baseResponse = await __productsController.changeQuantity(
          productId: this.id, type: type);
      if (!baseResponse.status)
        Helpers.showMessage(baseResponse.message, MessageType.MESSAGE_FAILED);
    } catch (error) {
      print(error.toString());
      Helpers.showMessage(
          AppShared.appLang['SomethingWentWrong'], MessageType.MESSAGE_FAILED);
    }
  }

// add product to cart.
  void addProductToCartRequest() async {
    try {
      BaseResponse baseResponse = await __productsController.addProductToCart(
        productId: this.id,
        quantity: 1,
      );
      if (!baseResponse.status) {
        Helpers.showMessage(baseResponse.message, MessageType.MESSAGE_FAILED);
      }
    } catch (error) {
      print(error);
      Helpers.showMessage(error.message, MessageType.MESSAGE_FAILED);
    }
  }

// change quantity.
//  void _changeQuantityRequest(int type) async {
//    try {
//      BaseResponse baseResponse =
//      await _productsController.changeQuantity(this.id, type);
//      if (!baseResponse.status) {
//        Helpers.showMessage(baseResponse.message, MessageType.MESSAGE_FAILED);
//      }
//    } catch (error) {
//      print(error);
//      Helpers.showMessage(error.message, MessageType.MESSAGE_FAILED);
//    }
//  }

  // add to cart.
//  void _addProductToCartRequest() async {
//    try {
//      BaseResponse baseResponse =
//      await _productsController.addProductToCart(this.id);
//      if (!baseResponse.status) {
//        Helpers.showMessage(baseResponse.message, MessageType.MESSAGE_FAILED);
//      }
//    } catch (error) {
//      print(error);
//      Helpers.showMessage(error.message, MessageType.MESSAGE_FAILED);
//    }
//  }

  //  delete from cart.
//  void deleteFromCartRequest() async {
//    try {
//      BaseResponse baseResponse =
//      await _productsController.deleteProductFromCart(this.id);
//      if (!baseResponse.status) {
//        Helpers.showMessage(baseResponse.message, MessageType.MESSAGE_FAILED);
//      }
//    } catch (error) {
//      print(error);
//      Helpers.showMessage(error.message, MessageType.MESSAGE_FAILED);
//    }
//  }

//||............................ logic methods ....................................||

}
