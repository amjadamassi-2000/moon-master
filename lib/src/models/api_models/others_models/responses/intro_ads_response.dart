import 'dart:convert';

import 'package:moonapp/src/models/api_models/base_response.dart';

IntroAdsResponse introAdsResponseFromJson(String str) =>
    IntroAdsResponse.fromJson(json.decode(str));

String introAdsResponseToJson(IntroAdsResponse data) =>
    json.encode(data.toJson());

class IntroAdsResponse extends BaseResponse {
  IntroAdsResponse({
    status,
    code,
    message,
    this.ads,
  }) : super(message: message, code: code, status: status);

  List<Ad> ads;

  factory IntroAdsResponse.fromJson(Map<String, dynamic> json) =>
      IntroAdsResponse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        ads: List<Ad>.from(json["ads"].map((x) => Ad.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "ads": List<dynamic>.from(ads.map((x) => x.toJson())),
      };
}

class Ad {
  Ad({
    this.id,
    this.image,
    this.link,
    this.status,
    this.createdAt,
    this.details,
    this.title,
  });

  int id;
  String image;
  String link;
  String status;
  DateTime createdAt;
  String details;
  String title;

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
        id: json["id"],
        image: json["image"],
        link: json["link"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        details: json["details"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "link": link,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "details": details,
        "title": title,
      };
}
