import 'dart:convert';

import 'package:moonapp/src/models/api_models/base_response.dart';
import 'package:moonapp/src/models/api_models/sub_models/user.dart';

UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse extends BaseResponse {
  UserResponse({
    message,
    code,
    status,
    this.user,
  }) : super(message: message, code: code, status: status);

  User user;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        status: json["status"],
        code: json["code"],
        user: User.fromJson(json["user"] ?? {}),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "user": user.toJson(),
        "message": message,
      };
}
