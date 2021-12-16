import 'dart:convert';

import 'package:moonapp/src/models/api_models/base_response.dart';
import 'package:moonapp/src/models/api_models/sub_models/order.dart';

OrdersResponse ordersResponseFromJson(String str) =>
    OrdersResponse.fromJson(json.decode(str));

String ordersResponseToJson(OrdersResponse data) => json.encode(data.toJson());

class OrdersResponse extends BaseResponse {
  OrdersResponse({
    status,
    code,
    message,
    this.orders,
  }) : super(status: status, code: code, message: message);

  Orders orders;

  factory OrdersResponse.fromJson(Map<String, dynamic> json) => OrdersResponse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        orders: Orders.fromJson(json["orders"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "orders": orders.toJson(),
      };
}

class Orders {

  Orders({
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
  List<Order> data;
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

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        currentPage: json["current_page"],
        data: List<Order>.from(json["data"].map((x) => Order.fromJson(x))),
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
