import 'dart:convert';

import 'package:moonapp/src/models/api_models/base_response.dart';
import 'package:moonapp/src/models/api_models/sub_models/user.dart';

ReviewsResponse reviewsResponseFromJson(String str) =>
    ReviewsResponse.fromJson(json.decode(str));

String reviewsResponseToJson(ReviewsResponse data) =>
    json.encode(data.toJson());

class ReviewsResponse extends BaseResponse {
  ReviewsResponse({
    status,
    code,
    message,
    this.reviews,
  }) : super(message: message, code: code, status: status);

  Reviews reviews;

  factory ReviewsResponse.fromJson(Map<String, dynamic> json) =>
      ReviewsResponse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        reviews: Reviews.fromJson(json["reviews"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "reviews": reviews.toJson(),
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
  int from;
  int lastPage;
  String lastPageUrl;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
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

class Review {
  Review({
    this.id,
    this.userId,
    this.productId,
    this.rate,
    this.comment,
    this.createdAt,
    this.user,
  });

  int id;
  int userId;
  int productId;
  int rate;
  String comment;
  String createdAt;
  User user;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        userId: json["user_id"],
        productId: json["product_id"],
        rate: json["rate"],
        comment: json["comment"],
        createdAt: json["created_at"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "product_id": productId,
        "rate": rate,
        "comment": comment,
        "created_at": createdAt,
        "user": user.toJson(),
      };
}
