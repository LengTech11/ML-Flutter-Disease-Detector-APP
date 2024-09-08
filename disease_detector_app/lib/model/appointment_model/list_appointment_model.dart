// To parse this JSON data, do
//
//     final listAppointmentModel = listAppointmentModelFromJson(jsonString);

import 'dart:convert';

ListAppointmentModel listAppointmentModelFromJson(String str) => ListAppointmentModel.fromJson(json.decode(str));

String listAppointmentModelToJson(ListAppointmentModel data) => json.encode(data.toJson());

class ListAppointmentModel {
    String status;
    List<Datum>? data;

    ListAppointmentModel({
        required this.status,
        required this.data,
    });

    factory ListAppointmentModel.fromJson(Map<String, dynamic> json) => ListAppointmentModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    int userId;
    int doctorId;
    DateTime preferredDate;
    String phoneNumber;
    String requestStatus;
    DateTime createdAt;
    DateTime updatedAt;

    Datum({
        required this.id,
        required this.userId,
        required this.doctorId,
        required this.preferredDate,
        required this.phoneNumber,
        required this.requestStatus,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        doctorId: json["doctor_id"],
        preferredDate: DateTime.parse(json["preferred_date"]),
        phoneNumber: json["phone_number"],
        requestStatus: json["request_status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "doctor_id": doctorId,
        "preferred_date": preferredDate.toIso8601String(),
        "phone_number": phoneNumber,
        "request_status": requestStatus,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
