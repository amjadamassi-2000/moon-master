import 'dart:convert';

import 'package:moonapp/src/models/api_models/base_response.dart';

StaticPagesResponse staticPagesResponseFromJson(String str) =>
    StaticPagesResponse.fromJson(json.decode(str));

String staticPagesResponseToJson(StaticPagesResponse data) =>
    json.encode(data.toJson());

class StaticPagesResponse extends BaseResponse {
  StaticPagesResponse({
    status,
    code,
    message,
    this.page,
  }) : super(message: message, code: code, status: status);

  Page page;

  factory StaticPagesResponse.fromJson(Map<String, dynamic> json) =>
      StaticPagesResponse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        page: Page.fromJson(json["page"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "page": page.toJson(),
      };
}

class Page {
  Page({
    this.id,
    this.image,
    this.views,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.title,
    this.description,
    this.keyWords,
    this.translations,
  });

  int id;
  String image;
  int views;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String title;
  String description;
  String keyWords;
  List<Translation> translations;

  factory Page.fromJson(Map<String, dynamic> json) => Page(
        id: json["id"],
        image: json["image"],
        views: json["views"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        title: json["title"],
        description: json["description"],
        keyWords: json["key_words"],
        translations: List<Translation>.from(
            json["translations"].map((x) => Translation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "views": views,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "title": title,
        "description": description,
        "key_words": keyWords,
        "translations": List<dynamic>.from(translations.map((x) => x.toJson())),
      };
}

class Translation {
  Translation({
    this.id,
    this.pageId,
    this.locale,
    this.title,
    this.slug,
    this.description,
    this.keyWords,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int id;
  int pageId;
  String locale;
  String title;
  String slug;
  String description;
  String keyWords;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        id: json["id"],
        pageId: json["page_id"],
        locale: json["locale"],
        title: json["title"],
        slug: json["slug"],
        description: json["description"],
        keyWords: json["key_words"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "page_id": pageId,
        "locale": locale,
        "title": title,
        "slug": slug,
        "description": description,
        "key_words": keyWords,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
