import 'dart:convert';

import 'package:moonapp/src/models/api_models/base_response.dart';
import 'package:moonapp/src/models/api_models/sub_models/category.dart';
import 'package:moonapp/src/models/api_models/sub_models/city.dart';

SettingResponse settingResponseFromJson(String str) =>
    SettingResponse.fromJson(json.decode(str));

String settingResponseToJson(SettingResponse data) =>
    json.encode(data.toJson());

class SettingResponse extends BaseResponse {
  SettingResponse({
    status,
    code,
    message,
    this.settings,
  }) : super(message: message, code: code, status: status);

  Settings settings;

  factory SettingResponse.fromJson(Map<String, dynamic> json) =>
      SettingResponse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        settings: Settings.fromJson(json["settings"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "settings": settings.toJson(),
      };
}

class Settings {
  Settings({
    this.id,
    this.url,
    this.logo,
    this.taxAmount,
    this.pointsInMony,
    this.monyInPoints,
    this.appStoreUrl,
    this.playStoreUrl,
    this.infoEmail,
    this.mobile,
    this.phone,
    this.facebook,
    this.twitter,
    this.linkedIn,
    this.instagram,
    this.googlePlus,
    this.minOrder,
    this.fromHour,
    this.toHour,
    this.latitude,
    this.longitude,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.cities,
    this.coffeeCategory,
    this.salonCategory,
    this.serviceCategory,
    this.title,
    this.joinDescription,
    this.description,
    this.address,
    this.show_salon,
    this.show_store,
    this.show_coffe,
    this.keyWords,
  });

  int id;
  String url;
  String logo;
  int taxAmount;
  int pointsInMony;
  int monyInPoints;
  int show_salon;
  int show_store;
  int show_coffe;
  String appStoreUrl;
  String playStoreUrl;
  String infoEmail;
  String mobile;
  String phone;
  String facebook;
  String twitter;
  String linkedIn;
  String instagram;
  String googlePlus;
  int minOrder;
  String fromHour;
  String toHour;
  String latitude;
  String longitude;
  String image;
  dynamic createdAt;
  DateTime updatedAt;
  List<City> cities;
  List<Category> coffeeCategory;
  List<Category> salonCategory;
  List<Category> serviceCategory;
  String title;
  dynamic joinDescription;
  String description;
  String address;
  dynamic keyWords;

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        id: json["id"],
        url: json["url"],
        logo: json["logo"],
        show_salon: json["show_salon"],
        show_store: json["show_store"],
        show_coffe: json["show_coffe"],
        taxAmount: json["tax_amount"],
        pointsInMony: json["points_in_mony"],
        monyInPoints: json["mony_in_points"],
        appStoreUrl: json["app_store_url"],
        playStoreUrl: json["play_store_url"],
        infoEmail: json["info_email"],
        mobile: json["mobile"],
        phone: json["phone"],
        facebook: json["facebook"],
        twitter: json["twitter"],
        linkedIn: json["linked_in"],
        instagram: json["instagram"],
        googlePlus: json["google_plus"],
        minOrder: json["min_order"],
        fromHour: json["from_hour"],
        toHour: json["to_hour"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        image: json["image"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
        cities: List<City>.from(json["cities"].map((x) => City.fromJson(x))),
        coffeeCategory: List<Category>.from(
            json["coffeeCategory"].map((x) => Category.fromJson(x))),
        salonCategory: List<Category>.from(
            json["salonCategory"].map((x) => Category.fromJson(x))),
        serviceCategory: List<Category>.from(
            json["serviceCategory"].map((x) => Category.fromJson(x))),
        title: json["title"],
        joinDescription: json["join_description"],
        description: json["description"],
        address: json["address"],
        keyWords: json["key_words"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "logo": logo,
        "tax_amount": taxAmount,
        "points_in_mony": pointsInMony,
        "mony_in_points": monyInPoints,
        "app_store_url": appStoreUrl,
        "play_store_url": playStoreUrl,
        "info_email": infoEmail,
        "mobile": mobile,
        "phone": phone,
        "facebook": facebook,
        "twitter": twitter,
        "linked_in": linkedIn,
        "instagram": instagram,
        "google_plus": googlePlus,
        "min_order": minOrder,
        "from_hour": fromHour,
        "to_hour": toHour,
        "latitude": latitude,
        "longitude": longitude,
        "image": image,
        "created_at": createdAt,
        "updated_at": updatedAt.toIso8601String(),
        "cities": List<dynamic>.from(cities.map((x) => x.toJson())),
        "coffeeCategory":
            List<dynamic>.from(coffeeCategory.map((x) => x.toJson())),
        "salonCategory":
            List<dynamic>.from(salonCategory.map((x) => x.toJson())),
        "serviceCategory":
            List<dynamic>.from(serviceCategory.map((x) => x.toJson())),
        "title": title,
        "join_description": joinDescription,
        "description": description,
        "address": address,
        "key_words": keyWords,
      };
}
