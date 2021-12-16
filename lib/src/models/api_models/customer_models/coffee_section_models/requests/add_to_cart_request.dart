class AddToCartRequest {
  AddToCartRequest({
    this.productId,
    this.quantity,
    this.type,
    this.sizeId,
  });

  int productId;
  int quantity;
  int type;
  int sizeId;

  factory AddToCartRequest.fromJson(Map<String, dynamic> json) =>
      AddToCartRequest(
        productId: json["product_id"],
        quantity: json["quantity"],
        type: json["type"],
        sizeId: json["size_id"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "quantity": quantity,
        "type": type,
        "size_id": sizeId,
      };
}
