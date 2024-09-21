// To parse this JSON data, do
//
//     final doctorModel = doctorModelFromJson(jsonString);

import 'dart:convert';

DoctorModel doctorModelFromJson(String str) =>
    DoctorModel.fromJson(json.decode(str));

String doctorModelToJson(DoctorModel data) => json.encode(data.toJson());

class DoctorModel {
  String status;
  Data? data;

  DoctorModel({
    required this.status,
    required this.data,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data!.toJson(),
      };
}

class Data {
  int id;
  String title;
  String firstName;
  String lastName;
  int userId;
  String specialist;
  String description;
  int patient;
  int experience;
  String profilePic;
  String phoneNumber;
  String telegram;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  Data({
    required this.id,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.userId,
    required this.specialist,
    required this.description,
    required this.patient,
    required this.experience,
    required this.profilePic,
    required this.phoneNumber,
    required this.telegram,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        userId: json["user_id"],
        specialist: json["specialist"],
        description: json["description"],
        patient: json["patient"],
        experience: json["experience"],
        profilePic: json["profile_pic"] ?? '',
        phoneNumber: json["phone_number"],
        telegram: json["telegram"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "first_name": firstName,
        "last_name": lastName,
        "user_id": userId,
        "specialist": specialist,
        "description": description,
        "patient": patient,
        "experience": experience,
        "profile_pic": profilePic,
        "phone_number": phoneNumber,
        "telegram": telegram,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
