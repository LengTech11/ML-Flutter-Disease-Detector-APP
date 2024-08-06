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
    this.id,
    this.status,
    this.message,
    this.data,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        id: json["id"] as int?,
        status: json["status"] as String?,
        message: json["message"] as String?,
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  int id;
  String firstName;
  String lastName;
  String email;
  String profile;
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
    required this.profile,
    this.emailVerifiedAt,
    required this.age,
    this.phoneNumber,
    required this.gender,
    required this.userRole,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] as int,
        firstName: json["first_name"] as String? ?? '',
        lastName: json["last_name"] as String? ?? '',
        email: json["email"] as String? ?? '',
        profile: json["profile"] as String? ?? '',
        emailVerifiedAt: json["email_verified_at"],
        age: json["age"] as int? ?? 0,
        phoneNumber: json["phone_number"],
        gender: json["gender"] as int? ?? 0,
        userRole: json["user_role"] as int? ?? 0,
        createdAt: DateTime.tryParse(json["created_at"] as String? ?? '') ??
            DateTime.now(),
        updatedAt: DateTime.tryParse(json["updated_at"] as String? ?? '') ??
            DateTime.now(),
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
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
