import 'dart:convert';

import 'package:moonapp/src/models/api_models/base_response.dart';
import 'package:moonapp/src/models/api_models/sub_models/product.dart';

HomeResponse homeResponseFromJson(String str) =>
    HomeResponse.fromJson(json.decode(str));

String homeResponseToJson(HomeResponse data) => json.encode(data.toJson());

class HomeResponse extends BaseResponse {
  HomeResponse({
    status,
    code,
    message,
    this.salonProducts,
    this.salonServies,
  }) : super(message: message, code: code, status: status);

  List<Product> salonProducts;
  List<Product> salonServies;

  factory HomeResponse.fromJson(Map<String, dynamic> json) => HomeResponse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        salonProducts: List<Product>.from(
            json["salonProducts"].map((x) => Product.fromJson(x))),
        salonServies: List<Product>.from(
            json["salonServies"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "salonProducts":
            List<dynamic>.from(salonProducts.map((x) => x.toJson())),
        "salonServies": List<dynamic>.from(salonServies.map((x) => x.toJson())),
      };
}
