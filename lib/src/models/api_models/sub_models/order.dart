import 'package:moonapp/src/models/api_models/sub_models/product.dart';

class Order {
  Order({
    this.id,
    this.userId,
    this.driverId,
    this.customerName,
    this.mobile,
    this.cityId,
    this.paymentMethod,
    this.deliveryMethod,
    this.tableNumber,
    this.deliveryTime,
    this.promoCodeName,
    this.totalProducts,
    this.totalAdditions,
    this.deliveryCost,
    this.discount,
    this.total,
    this.details,
    this.address,
    this.latitude,
    this.longitude,
    this.type,
    this.paymentJson,
    this.status,
    this.createdAt,
    this.statusName,
    this.serviceDate,
    this.serviceTime,
    this.products,
    this.taxAmount,
    this.taxRate,
  });

  int id;
  int userId;
  int driverId;
  String customerName;
  int mobile;
  int cityId;
  int paymentMethod;
  int deliveryMethod;
  String tableNumber;
  dynamic deliveryTime;
  dynamic promoCodeName;
  String totalProducts;
  String totalAdditions;
  num deliveryCost;
  String discount;
  String total;
  String details;
  String address;
  double latitude;
  double longitude;
  int type;
  dynamic paymentJson;
  int status;
  DateTime createdAt;
  String statusName;
  String serviceTime;
  String serviceDate;
  List<ProductElement> products;
  String taxAmount;
  String taxRate;



  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        userId: json["user_id"],
        driverId: json["driver_id"],
        customerName: json["customer_name"],
        mobile: json["mobile"],
        cityId: json["city_id"],
        paymentMethod: json["payment_method"],
        deliveryMethod: json["delivery_method"],
        tableNumber: json["table_number"],
        deliveryTime: json["delivery_time"],
        promoCodeName: json["promoCode_name"],
        totalProducts: json["total_products"],
        totalAdditions: json["total_additions"],
        deliveryCost: json["delivery_cost"],
        discount: json["discount"],
        total: json["total"],
        details: json["details"],
        serviceDate: json['service_date'],
        serviceTime: json['service_time'],
        address: json["address"] == null ? null : json["address"],
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
        type: json["type"],
        paymentJson: json["payment_json"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        statusName: json["status_name"],
        products: List<ProductElement>.from(json["products"].map((x) => ProductElement.fromJson(x))),
        taxAmount :json["tax_amount"],
        taxRate : json["tax_rate"],





  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "driver_id": driverId,
        "customer_name": customerName,
        "mobile": mobile,
        "city_id": cityId,
        "payment_method": paymentMethod,
        "delivery_method": deliveryMethod,
        "table_number": tableNumber,
        "delivery_time": deliveryTime,
        "promoCode_name": promoCodeName,
        "total_products": totalProducts,
        "total_additions": totalAdditions,
        "delivery_cost": deliveryCost,
        "discount": discount,
        "total": total,
        "details": details,
        "address": address == null ? null : address,
        "latitude": latitude,
        "longitude": longitude,
        "type": type,
        "payment_json": paymentJson,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "status_name": statusName,
        "service_time": serviceTime,
        "service_date": serviceDate,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
         "tax_amount":taxAmount,
         "tax_rate" : taxRate,

      };
}

class ProductElement {
  ProductElement({
    this.id,
    this.orderId,
    this.productId,
    this.quantity,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.product,
    this.additions,
  });

  int id;
  int orderId;
  int productId;
  int quantity;
  num price;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  Product product;
  List<dynamic> additions;

  factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
        id: json["id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        price: json["price"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        product: Product.fromJson(json["product"]),
        additions: List<dynamic>.from(json["additions"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "product_id": productId,
        "quantity": quantity,
        "price": price,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "product": product.toJson(),
        "additions": List<dynamic>.from(additions.map((x) => x)),
      };
}
