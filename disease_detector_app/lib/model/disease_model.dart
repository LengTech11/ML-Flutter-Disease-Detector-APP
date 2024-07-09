// To parse this JSON data, do
//
//     final diseaeModel = diseaeModelFromJson(jsonString);

import 'dart:convert';

DiseaseModel diseaeModelFromJson(String str) => DiseaseModel.fromJson(json.decode(str));

String diseaeModelToJson(DiseaseModel data) => json.encode(data.toJson());

class DiseaseModel {
    String status;
    List<Datum> data;

    DiseaseModel({
        required this.status,
        required this.data,
    });

    factory DiseaseModel.fromJson(Map<String, dynamic> json) => DiseaseModel(
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
    String title;
    String description;

    Datum({
        required this.id,
        required this.title,
        required this.description,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
    };
}
