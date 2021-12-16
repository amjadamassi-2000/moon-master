import 'dart:convert';

import 'package:moonapp/src/models/api_models/base_response.dart';
import 'package:moonapp/src/models/api_models/sub_models/order.dart';

OrderDetailsResponse orderDetailsResponseFromJson(String str) =>
    OrderDetailsResponse.fromJson(json.decode(str));

String orderDetailsResponseToJson(OrderDetailsResponse data) =>
    json.encode(data.toJson());

class OrderDetailsResponse extends BaseResponse {
  OrderDetailsResponse({
    status,
    code,
    message,
    this.orders,
  }) : super(status: status, code: code, message: message);

  Order orders;

  factory OrderDetailsResponse.fromJson(Map<String, dynamic> json) =>
      OrderDetailsResponse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        orders: Order.fromJson(json["orders"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "orders": orders.toJson(),
      };
}
