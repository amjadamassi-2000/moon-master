import 'package:moonapp/src/models/api_models/sub_models/city_translation.dart';

class City {
  City({
    this.id,
    this.deliveryCost,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.name,
    this.translations,
  });

  int id;
  int deliveryCost;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String name;
  List<CityTranslation> translations;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        deliveryCost: json["deliveryCost"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        name: json["name"],
        translations: List<CityTranslation>.from(
            json["translations"].map((x) => CityTranslation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "deliveryCost": deliveryCost,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "name": name,
        "translations": List<dynamic>.from(translations.map((x) => x.toJson())),
      };
}
