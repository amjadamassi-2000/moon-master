import 'dart:convert';

import 'package:moonapp/src/models/api_models/base_response.dart';
import 'package:moonapp/src/models/api_models/sub_models/product.dart';

OffersResponse offersResponseFromJson(String str) =>
    OffersResponse.fromJson(json.decode(str));

String offersResponseToJson(OffersResponse data) => json.encode(data.toJson());

class OffersResponse extends BaseResponse {
  OffersResponse({
    status,
    code,
    message,
    this.productoffer,
  }) : super(message: message, code: code, status: status);

  List<Productoffer> productoffer;

  factory OffersResponse.fromJson(Map<String, dynamic> json) => OffersResponse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        productoffer: List<Productoffer>.from(
            json["productoffer"].map((x) => Productoffer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "productoffer": List<dynamic>.from(productoffer.map((x) => x.toJson())),
      };
}

class Productoffer {
  Productoffer({
    this.id,
    this.productId,
    this.discount,
    this.offerFrom,
    this.offerTo,
    this.createdAt,
    this.product,
  });

  int id;
  int productId;
  int discount;
  DateTime offerFrom;
  DateTime offerTo;
  DateTime createdAt;
  Product product;

  factory Productoffer.fromJson(Map<String, dynamic> json) => Productoffer(
        id: json["id"],
        productId: json["product_id"],
        discount: json["discount"],
        offerFrom: DateTime.parse(json["offer_from"]),
        offerTo: DateTime.parse(json["offer_to"]),
        createdAt: DateTime.parse(json["created_at"]),
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "discount": discount,
        "offer_from":
            "${offerFrom.year.toString().padLeft(4, '0')}-${offerFrom.month.toString().padLeft(2, '0')}-${offerFrom.day.toString().padLeft(2, '0')}",
        "offer_to":
            "${offerTo.year.toString().padLeft(4, '0')}-${offerTo.month.toString().padLeft(2, '0')}-${offerTo.day.toString().padLeft(2, '0')}",
        "created_at": createdAt.toIso8601String(),
        "product": product.toJson(),
      };
}
