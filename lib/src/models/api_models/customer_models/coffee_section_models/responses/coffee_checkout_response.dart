import 'dart:convert';

import 'package:moonapp/src/models/api_models/base_response.dart';

CoffeeCheckoutResponse CoffeeCheckoutResponseFromJson(String str) =>
    CoffeeCheckoutResponse.fromJson(json.decode(str));

String CoffeeCheckoutResponseToJson(CoffeeCheckoutResponse data) =>
    json.encode(data.toJson());

class CoffeeCheckoutResponse extends BaseResponse {
  CoffeeCheckoutResponse({
    status,
    code,
    message,
    this.link,
  }) : super(status: status, code: code, message: message);

  String link;

  factory CoffeeCheckoutResponse.fromJson(Map<String, dynamic> json) =>
      CoffeeCheckoutResponse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "link": link,
      };
}
