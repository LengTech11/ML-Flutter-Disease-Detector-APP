import 'package:disease_detector_app/api_service/api/document_api.dart';
import 'package:disease_detector_app/model/document_model.dart';
import 'package:flutter/material.dart';

class DocumentProvider extends ChangeNotifier {
  Document? doc;
  Future<void> fetchDocument(String name) async {
    final response = await DocumentApiService().getDocument();
    if (response.data.isNotEmpty) {
      for (int i = 0; i < response.data.length; i++) {
        if (name == response.data[i].fileName) {
          doc = response.data[i];
        }
      }
    } else {
      doc = null;
    }
    notifyListeners();
  }
}
