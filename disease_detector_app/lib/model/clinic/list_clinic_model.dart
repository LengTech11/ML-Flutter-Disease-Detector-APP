
//
//     final listClinicModel = listClinicModelFromJson(jsonString);

import 'dart:convert';

ListClinicModel listClinicModelFromJson(String str) => ListClinicModel.fromJson(json.decode(str));

String listClinicModelToJson(ListClinicModel data) => json.encode(data.toJson());

class ListClinicModel {
    String status;
    List<Datum> data;

    ListClinicModel({
        required this.status,
        required this.data,
    });

    factory ListClinicModel.fromJson(Map<String, dynamic> json) => ListClinicModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
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

    Datum({
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

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
