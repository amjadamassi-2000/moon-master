class Category {
  Category({
    this.id,
    this.subId,
    this.type,
    this.image,
    this.status,
    this.createdAt,
    this.name,
  });

  int id;
  int subId;
  int type;
  String image;
  String status;
  DateTime createdAt;
  String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        subId: json["sub_id"],
        type: json["type"],
        image: json["image"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sub_id": subId,
        "type": type,
        "image": image,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "name": name,
      };
}
