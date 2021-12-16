import 'dart:convert';

import 'package:moonapp/src/models/api_models/base_response.dart';
import 'package:moonapp/src/models/api_models/sub_models/product.dart';

ProductsResponse productsResponseFromJson(String str) =>
    ProductsResponse.fromJson(json.decode(str));

String productsResponseToJson(ProductsResponse data) =>
    json.encode(data.toJson());

class ProductsResponse extends BaseResponse {
  ProductsResponse({
    status,
    code,
    message,
    this.products,
  }) : super(message: message, code: code, status: status);

  Products products;

  factory ProductsResponse.fromJson(Map<String, dynamic> json, {String objName = "products"}) =>
      ProductsResponse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        products: Products.fromJson(json[objName]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "products": products.toJson(),
      };
}

class Products {
  Products({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int currentPage;
  List<Product> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  String nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        currentPage: json["current_page"],
        data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}
