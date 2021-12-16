import 'dart:convert';

import 'package:dio/dio.dart';

EditProfileRequest editProfileRequestFromJson(String str) =>
    EditProfileRequest.fromJson(json.decode(str));

String editProfileRequestToJson(EditProfileRequest data) =>
    json.encode(data.toJson());

class EditProfileRequest {
  EditProfileRequest({
    this.mobile,
    this.name,
    this.imageProfile,
    this.cityId,
  });

  String mobile;
  String name;
  MultipartFile imageProfile;
  int cityId;

  factory EditProfileRequest.fromJson(Map<String, dynamic> json) =>
      EditProfileRequest(
        mobile: json["mobile"],
        name: json["name"],
        imageProfile: json["image_profile"],
        cityId: json["city_id"],
      );

  Map<String, dynamic> toJson() => {
        "mobile": mobile,
        "name": name,
        "image_profile": imageProfile,
        "city_id": cityId,
      };
}
