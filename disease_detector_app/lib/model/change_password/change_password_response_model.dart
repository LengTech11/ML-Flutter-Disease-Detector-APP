// To parse this JSON data, do
//
//     final changePasswordResponseModel = changePasswordResponseModelFromJson(jsonString);

import 'dart:convert';

ChangePasswordResponseModel changePasswordResponseModelFromJson(String str) => ChangePasswordResponseModel.fromJson(json.decode(str));

String changePasswordResponseModelToJson(ChangePasswordResponseModel data) => json.encode(data.toJson());

class ChangePasswordResponseModel {
    String status;
    String message;

    ChangePasswordResponseModel({
        required this.status,
        required this.message,
    });

    factory ChangePasswordResponseModel.fromJson(Map<String, dynamic> json) => ChangePasswordResponseModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
