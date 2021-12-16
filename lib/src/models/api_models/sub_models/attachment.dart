class Attachment {
  Attachment({
    this.id,
    this.productImg,
    this.productId,
    this.createdAt,
  });

  int id;
  String productImg;
  int productId;
  DateTime createdAt;

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        id: json["id"],
        productImg: json["product_img"],
        productId: json["product_id"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_img": productImg,
        "product_id": productId,
        "created_at": createdAt.toIso8601String(),
      };
}
