import 'dart:convert';

import 'package:moonapp/src/models/api_models/base_response.dart';

CoffeePromoResponse CoffeePromoResponseFromJson(String str) =>
    CoffeePromoResponse.fromJson(json.decode(str));

String CoffeePromoResponseToJson(CoffeePromoResponse data) =>
    json.encode(data.toJson());

class CoffeePromoResponse extends BaseResponse {
  CoffeePromoResponse({
    status,
    code,
    message,
    this.discount,
  }) : super(status: status, code: code, message: message);

  num discount;

  factory CoffeePromoResponse.fromJson(Map<String, dynamic> json) =>
      CoffeePromoResponse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        discount: json["discount"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "discount": discount,
      };
}
