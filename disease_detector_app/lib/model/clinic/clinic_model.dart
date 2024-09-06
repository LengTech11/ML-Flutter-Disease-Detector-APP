// To parse this JSON data, do
//
//     final clinicModel = clinicModelFromJson(jsonString);

import 'dart:convert';

ClinicModel clinicModelFromJson(String str) => ClinicModel.fromJson(json.decode(str));

String clinicModelToJson(ClinicModel data) => json.encode(data.toJson());

class ClinicModel {
    String status;
    Data data;

    ClinicModel({
        required this.status,
        required this.data,
    });

    factory ClinicModel.fromJson(Map<String, dynamic> json) => ClinicModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
    };
}

class Data {
    int id;
    String firstName;
    String lastName;
    String email;
    dynamic profile;
    dynamic emailVerifiedAt;
    int age;
    String phoneNumber;
    int gender;
    int userRole;
    DateTime createdAt;
    DateTime updatedAt;
    int count;

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
        required this.count,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        profile: json["profile"],
        emailVerifiedAt: json["email_verified_at"],
        age: json["age"],
        phoneNumber: json["phone_number"],
        gender: json["gender"],
        userRole: json["user_role"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        count: json["count"],
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
        "count": count,
    };
}
