// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) =>
    UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) =>
    json.encode(data.toJson());

class UserProfileModel {
  int? id;
  String? status;
  String? message;
  Data? data;

  UserProfileModel({
    required this.id,
    required this.status,
    required this.message,
    required this.data,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        id: json["id"] ?? "",
        status: json["status"] ?? "",
        message: json["message"] ?? "",
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  int id;
  String firstName;
  String lastName;
  String email;
  dynamic emailVerifiedAt;
  int age;
  dynamic phoneNumber;
  int gender;
  int userRole;
  DateTime createdAt;
  DateTime updatedAt;

  Data({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.emailVerifiedAt,
    required this.age,
    required this.phoneNumber,
    required this.gender,
    required this.userRole,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        age: json["age"],
        phoneNumber: json["phone_number"],
        gender: json["gender"],
        userRole: json["user_role"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "age": age,
        "phone_number": phoneNumber,
        "gender": gender,
        "user_role": userRole,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
