import 'dart:convert';

import 'package:moonapp/src/models/api_models/customer_models/shared_models/reviews_response.dart';
import 'package:moonapp/src/models/api_models/sub_models/product.dart';

import '../../base_response.dart';

ProductDetailsResponse productDetailsResponseFromJson(String str) =>
    ProductDetailsResponse.fromJson(json.decode(str));

String productDetailsResponseToJson(ProductDetailsResponse data) =>
    json.encode(data.toJson());

class ProductDetailsResponse extends BaseResponse {
  ProductDetailsResponse({
    status,
    code,
    message,
    this.product,
    this.reviews,
    this.isReview,
  }) : super(message: message, code: code, status: status);

  Product product;

  Reviews reviews;

  String isReview;

  factory ProductDetailsResponse.fromJson(Map<String, dynamic> json) =>
      ProductDetailsResponse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        product: Product.fromJson(json["product"]),
        reviews: Reviews.fromJson(json["reviews"]),
        isReview: json["is_review"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "product": product.toJson(),
        "reviews": reviews.toJson(),
        "is_review": isReview,
      };
}



class Reviews {
  Reviews({
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
  List<Review> data;
  String firstPageUrl;
  dynamic from;
  int lastPage;
  String lastPageUrl;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  dynamic to;
  int total;

  factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
        currentPage: json["current_page"],
        data: List<Review>.from(json["data"].map((x) => Review.fromJson(x))),
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
        "data": List<dynamic>.from(data.map((x) => x)),
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
