import 'dart:convert';

import 'package:moonapp/src/models/api_models/base_response.dart';

ContactResponse forgotPasswordResponseFromJson(String str) =>
    ContactResponse.fromJson(json.decode(str));

String forgotPasswordResponseToJson(ContactResponse data) =>
    json.encode(data.toJson());

class ContactResponse extends BaseResponse {
  String validator;

  ContactResponse({status, code, message, this.validator})
      : super(message: message, code: code, status: status);

  factory ContactResponse.fromJson(Map<String, dynamic> json) =>
      ContactResponse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        validator: json["validator"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "validator": validator,
      };
}
