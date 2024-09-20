// To parse this JSON data, do
//
//     final doctorListModel = doctorListModelFromJson(jsonString);

import 'dart:convert';

DoctorListModel doctorListModelFromJson(String str) =>
    DoctorListModel.fromJson(json.decode(str));

String doctorListModelToJson(DoctorListModel data) =>
    json.encode(data.toJson());

class DoctorListModel {
  String status;
  List<Datum?>? data;

  DoctorListModel({
    required this.status,
    required this.data,
  });

  factory DoctorListModel.fromJson(Map<String, dynamic> json) =>
      DoctorListModel(
        status: json["status"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum?.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x!.toJson())),
      };
}

class Datum {
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

  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
