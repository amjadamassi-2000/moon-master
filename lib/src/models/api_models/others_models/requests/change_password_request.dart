import 'dart:convert';

ChangePasswordRequest changePasswordRequestFromJson(String str) =>
    ChangePasswordRequest.fromJson(json.decode(str));

String changePasswordRequestToJson(ChangePasswordRequest data) =>
    json.encode(data.toJson());

class ChangePasswordRequest {
  ChangePasswordRequest({
    this.oldPassword,
    this.password,
    this.confirmPassword,
  });

  String oldPassword;
  String password;
  String confirmPassword;

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) =>
      ChangePasswordRequest(
        oldPassword: json["old_password"],
        password: json["password"],
        confirmPassword: json["confirm_password"],
      );

  Map<String, dynamic> toJson() => {
        "old_password": oldPassword,
        "password": password,
        "confirm_password": confirmPassword,
      };
}
