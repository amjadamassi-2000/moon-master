import 'dart:convert';

import 'package:moonapp/src/models/api_models/base_response.dart';

SliderResponse coffeeSliderResponseFromJson(String str) =>
    SliderResponse.fromJson(json.decode(str));

String coffeeSliderResponseToJson(SliderResponse data) =>
    json.encode(data.toJson());

class SliderResponse extends BaseResponse {
  SliderResponse({
    status,
    code,
    message,
    this.slider,
  }) : super(message: message, code: code, status: status);

  List<Slider> slider;

  factory SliderResponse.fromJson(Map<String, dynamic> json) => SliderResponse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        slider:
            List<Slider>.from(json["slider"].map((x) => Slider.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "slider": List<dynamic>.from(slider.map((x) => x.toJson())),
      };
}

class Slider {
  Slider({
    this.id,
    this.order,
    this.type,
    this.image,
    this.status,
    this.createdAt,
    this.details,
    this.title,
  });

  int id;
  int order;
  int type;
  String image;
  String status;
  DateTime createdAt;
  String details;
  String title;

  factory Slider.fromJson(Map<String, dynamic> json) => Slider(
        id: json["id"],
        order: json["order"],
        type: json["type"],
        image: json["image"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        details: json["details"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order": order,
        "type": type,
        "image": image,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "details": details,
        "title": title,
      };
}
