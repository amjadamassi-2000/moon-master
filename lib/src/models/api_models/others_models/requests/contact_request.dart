import 'dart:convert';

ContactRequest contactRequestFromJson(String str) =>
    ContactRequest.fromJson(json.decode(str));

String contactRequestToJson(ContactRequest data) => json.encode(data.toJson());

class ContactRequest {
  ContactRequest({
    this.mobile,
    this.email,
    this.name,
    this.message,
  });

  String mobile;
  String email;
  String name;
  String message;

  factory ContactRequest.fromJson(Map<String, dynamic> json) => ContactRequest(
        mobile: json["mobile"],
        email: json["email"],
        name: json["name"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "mobile": mobile,
        "email": email,
        "name": name,
        "message": message,
      };
}
