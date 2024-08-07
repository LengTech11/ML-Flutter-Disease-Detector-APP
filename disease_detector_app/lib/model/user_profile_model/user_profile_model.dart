// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) =>
    UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) =>
    json.encode(data.toJson());

class UserProfileModel {
  String? status;
  String? message;
  Data? data;

  UserProfileModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        status: json["status"] ?? '',
        message: json["message"] ?? '',
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? profile;
  String? emailVerifiedAt;
  int? age;
  String? phoneNumber;
  int? gender;
  int? userRole;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profile,
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
        firstName: json["first_name"] ?? '',
        lastName: json["last_name"] ?? '',
        email: json["email"] ?? '',
        profile: json["profile"] ?? '',
        emailVerifiedAt: json["email_verified_at"] ?? '',
        age: json["age"] ?? 0,
        phoneNumber: json["phone_number"] ?? '',
        gender: json["gender"] ?? 1,
        userRole: json["user_role"] ?? 1,
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "profile": profile,
        "email_verified_at": emailVerifiedAt,
        "age": age,
        "phone_number": phoneNumber,
        "gender": gender,
        "user_role": userRole,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
