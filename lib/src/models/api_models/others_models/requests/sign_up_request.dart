import 'dart:convert';

SignUpRequest signUpRequestFromJson(String str) =>
    SignUpRequest.fromJson(json.decode(str));

String signUpRequestToJson(SignUpRequest data) => json.encode(data.toJson());

class SignUpRequest {
  SignUpRequest({
    this.name,
    this.mobile,
    this.password,
    this.email,
    this.deviceType,
    this.fcmToken,
    this.cityId,
  });

  String name;
  String mobile;
  String password;
  String email;
  String deviceType;
  String fcmToken;
  int cityId;

  factory SignUpRequest.fromJson(Map<String, dynamic> json) => SignUpRequest(
        name: json["name"],
        mobile: json["mobile"],
        password: json["password"],
        email: json["email"],
        deviceType: json["device_type"],
        fcmToken: json["fcm_token"],
        cityId: json["city_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "mobile": mobile,
        "password": password,
        "email": email,
        "device_type": deviceType,
        "fcm_token": fcmToken,
        "city_id": cityId,
      };
}
