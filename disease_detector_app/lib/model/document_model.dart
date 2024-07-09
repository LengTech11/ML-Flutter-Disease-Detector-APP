// To parse this JSON data, do
//
//     final documentModel = documentModelFromJson(jsonString);

import 'dart:convert';

DocumentModel documentModelFromJson(String str) => DocumentModel.fromJson(json.decode(str));

String documentModelToJson(DocumentModel data) => json.encode(data.toJson());

class DocumentModel {
    String status;
    List<Document> data;

    DocumentModel({
        required this.status,
        required this.data,
    });

    factory DocumentModel.fromJson(Map<String, dynamic> json) => DocumentModel(
        status: json["status"],
        data: List<Document>.from(json["data"].map((x) => Document.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Document {
    int id;
    String fileName;
    String url;
    String? disease;

    Document({
        required this.id,
        required this.fileName,
        required this.url,
        required this.disease,
    });

    factory Document.fromJson(Map<String, dynamic> json) => Document(
        id: json["id"],
        fileName: json["file_name"],
        url: json["url"],
        disease: json["disease"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "file_name": fileName,
        "url": url,
        "disease": disease,
    };
}
