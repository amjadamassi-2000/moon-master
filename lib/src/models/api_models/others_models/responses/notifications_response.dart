import 'dart:convert';

import 'package:moonapp/src/models/api_models/base_response.dart';

NotificationsResponse notificationsResponseFromJson(String str) =>
    NotificationsResponse.fromJson(json.decode(str));

String notificationsResponseToJson(NotificationsResponse data) =>
    json.encode(data.toJson());

class NotificationsResponse extends BaseResponse {
  NotificationsResponse({
    status,
    code,
    message,
    this.data,
  }) : super(message: message, code: code, status: status);

  List<Datum> data;

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) =>
      NotificationsResponse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.userId,
    this.orderId,
    this.message,
    this.messagType,
    this.status,
    this.createdAt,
    this.imageUser,
    this.nameUser,
    this.totalOrder,
  });

  int id;
  int userId;
  int orderId;
  String message;
  int messagType;
  String status;
  DateTime createdAt;
  dynamic imageUser;
  String nameUser;
  num totalOrder;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        orderId: json["order_id"],
        message: json["message"],
        messagType: json["messag_type"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        imageUser: json["image_user"],
        nameUser: json["name_user"],
        totalOrder: json["total_order"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "order_id": orderId,
        "message": message,
        "messag_type": messagType,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "image_user": imageUser,
        "name_user": nameUser,
        "total_order": totalOrder,
      };
}
