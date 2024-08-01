// To parse this JSON data, do
//
//     final getHistoryModel = getHistoryModelFromJson(jsonString);

import 'dart:convert';

List<GetHistoryModel> getHistoryModelFromJson(String str) =>
    List<GetHistoryModel>.from(
        json.decode(str).map((x) => GetHistoryModel.fromJson(x)));

String getHistoryModelToJson(List<GetHistoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetHistoryModel {
  int? id;
  int? userId;
  String? predictedClass;
  String? confidence;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? imageUrl;

  GetHistoryModel({
    required this.id,
    required this.userId,
    required this.predictedClass,
    required this.confidence,
    required this.createdAt,
    required this.updatedAt,
    required this.imageUrl,
  });

  factory GetHistoryModel.fromJson(Map<String, dynamic> json) =>
      GetHistoryModel(
        id: json["id"] ?? '',
        userId: json["user_id"] ?? '',
        predictedClass: json["predicted_class"] ?? '',
        confidence: json["confidence"] ?? '',
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updatad_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        imageUrl: json["image_url"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "predicted_class": predictedClass,
        "confidence": confidence,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "image_url": imageUrl,
      };
}
