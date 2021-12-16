import 'dart:convert';

import 'package:moonapp/src/models/api_models/base_response.dart';

FaqResponse faqResponseFromJson(String str) =>
    FaqResponse.fromJson(json.decode(str));

String faqResponseToJson(FaqResponse data) => json.encode(data.toJson());

class FaqResponse extends BaseResponse {
  FaqResponse({
    status,
    code,
    message,
    this.questions,
  }) : super(message: message, code: code, status: status);

  List<Question> questions;

  factory FaqResponse.fromJson(Map<String, dynamic> json) => FaqResponse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}

class Question {
  Question({
    this.id,
    this.status,
    this.createdAt,
    this.question,
    this.answer,
  });

  int id;
  String status;
  DateTime createdAt;
  String question;
  String answer;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        question: json["question"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "question": question,
        "answer": answer,
      };
}
