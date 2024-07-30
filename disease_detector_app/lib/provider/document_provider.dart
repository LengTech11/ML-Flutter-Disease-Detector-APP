import 'package:disease_detector_app/api_service/api/document_api.dart';
import 'package:disease_detector_app/model/document_model.dart';
import 'package:flutter/material.dart';

class DocumentProvider extends ChangeNotifier {
  DocumentModel? doc;
  Future<void> fetchDocument(String name) async {
    try {
      final response =
          await DocumentApiService().getDocument(diseaseName: name);
      if (response.data.isNotEmpty) {
        doc = response;
      } else {
        doc = null;
      }
    } catch (error) {
      print('Error fetching document: $error');
    }
    notifyListeners();
  }
}
