class Size {

  int id;
  int productId;
  int sizeId;
  String price;
  DateTime createdAt;
  SizeDetails size;


  Size({
    this.id,
    this.productId,
    this.sizeId,
    this.price,
    this.createdAt,
    this.size,
  });





  factory Size.fromJson(Map<String, dynamic> json) => Size(
        id: json["id"],
        productId: json["product_id"],
        sizeId: json["size_id"],
        price: json["price"],
        createdAt: DateTime.parse(json["created_at"]),
        size: SizeDetails.fromJson(json["size"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "size_id": sizeId,
        "price": price,
        "created_at": createdAt.toIso8601String(),
        "size": size.toJson(),
      };
}

class SizeDetails {
  SizeDetails({
    this.id,
    this.status,
    this.createdAt,
    this.name,
  });

  int id;
  String status;
  DateTime createdAt;
  String name;

  factory SizeDetails.fromJson(Map<String, dynamic> json) => SizeDetails(
        id: json["id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "name": name,
      };
}
