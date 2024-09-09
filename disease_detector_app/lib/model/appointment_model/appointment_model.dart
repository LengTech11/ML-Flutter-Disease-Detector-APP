// To parse this JSON data, do
//
//     final appointmentModel = appointmentModelFromJson(jsonString);

import 'dart:convert';

AppointmentModel appointmentModelFromJson(String str) => AppointmentModel.fromJson(json.decode(str));

String appointmentModelToJson(AppointmentModel data) => json.encode(data.toJson());

class AppointmentModel {
    int userId;
    int doctorId;
    String preferredDate;
    String phoneNumber;
    String? requestStatus;
    DateTime updatedAt;
    DateTime createdAt;
    int id;

    AppointmentModel({
        required this.userId,
        required this.doctorId,
        required this.preferredDate,
        required this.phoneNumber,
        required this.requestStatus,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    factory AppointmentModel.fromJson(Map<String, dynamic> json) => AppointmentModel(
        userId: json["user_id"],
        doctorId: json["doctor_id"],
        preferredDate: json["preferred_date"],
        phoneNumber: json["phone_number"],
        requestStatus: json["request_status"] ?? '',
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "doctor_id": doctorId,
        "preferred_date": preferredDate,
        "phone_number": phoneNumber,
        "request_status": requestStatus,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
    };
}
