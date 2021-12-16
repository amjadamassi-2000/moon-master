class CityTranslation {
  CityTranslation({
    this.id,
    this.cityId,
    this.locale,
    this.name,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int cityId;
  String locale;
  String name;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory CityTranslation.fromJson(Map<String, dynamic> json) =>
      CityTranslation(
        id: json["id"],
        cityId: json["city_id"],
        locale: json["locale"],
        name: json["name"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city_id": cityId,
        "locale": locale,
        "name": name,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
