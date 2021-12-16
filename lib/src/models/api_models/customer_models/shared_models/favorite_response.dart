import 'dart:convert';

import 'package:moonapp/src/models/api_models/base_response.dart';
import 'package:moonapp/src/models/api_models/sub_models/product.dart';

FavoriteResponse favoriteResponseFromJson(String str) =>
    FavoriteResponse.fromJson(json.decode(str));

String favoriteResponseToJson(FavoriteResponse data) =>
    json.encode(data.toJson());

class FavoriteResponse extends BaseResponse {
  FavoriteResponse({
    status,
    code,
    message,
    this.products,
  }) : super(message: message, code: code, status: status);

  Products products;

  factory FavoriteResponse.fromJson(Map<String, dynamic> json) =>
      FavoriteResponse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        products: Products.fromJson(json["products"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "products": products.toJson(),
      };
}

class Products {
  Products({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  Datum({
    this.id,
    this.userId,
    this.fcmToken,
    this.productId,
    this.createdAt,
    this.product,
  });

  int id;
  int userId;
  String fcmToken;
  int productId;
  DateTime createdAt;
  Product product;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        fcmToken: json["fcm_token"],
        productId: json["product_id"],
        createdAt: DateTime.parse(json["created_at"]),
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "fcm_token": fcmToken,
        "product_id": productId,
        "created_at": createdAt.toIso8601String(),
        "product": product.toJson(),
      };
}
