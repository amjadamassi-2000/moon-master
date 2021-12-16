import 'dart:convert';

import 'package:moonapp/src/models/api_models/base_response.dart';
import 'package:moonapp/src/models/api_models/sub_models/product.dart';

SimilarProductsResponse similarProductsResponseFromJson(String str) =>
    SimilarProductsResponse.fromJson(json.decode(str));

String similarProductsResponseToJson(SimilarProductsResponse data) =>
    json.encode(data.toJson());

class SimilarProductsResponse extends BaseResponse {
  SimilarProductsResponse({
    status,
    code,
    message,
    this.products,
  }) : super(message: message, code: code, status: status);

  List<Product> products;

  factory SimilarProductsResponse.fromJson(Map<String, dynamic> json) =>
      SimilarProductsResponse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}
