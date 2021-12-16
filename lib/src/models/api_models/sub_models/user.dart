import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User user) => json.encode(user.toJson());

class User {
  User({
    this.id,
    this.name ,
    this.email,
    this.mobile,
    this.imageProfile,
    this.cityId,
    this.rememberToken,
    this.status,
    this.type,
    this.points,
    this.accessToken,
    this.pointsNo,
  });

  int id;
  String name ;
  String email;
  String mobile;
  String imageProfile;
  int cityId;
  dynamic rememberToken;
  String status;
  String type;
  int points;
  String accessToken;
  String pointsNo;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"] ,
        email: json["email"],
        mobile: json["mobile"],
        imageProfile: json["image_profile"],
        cityId: json["city_id"],
        rememberToken: json["remember_token"],
        status: json["status"],
        type: json["type"],
        points: json["points"],
        accessToken: json["access_token"],
        pointsNo: json["points_no"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "mobile": mobile,
        "image_profile": imageProfile,
        "city_id": cityId,
        "remember_token": rememberToken,
        "status": status,
        "type": type,
        "points": points,
        "access_token": accessToken,
        "points_no": pointsNo,
      };
}
