import 'package:disease_detector_app/api_service/api/disease_api.dart';
import 'package:disease_detector_app/model/disease_model.dart';
import 'package:flutter/material.dart';

class DiseaseProvider extends ChangeNotifier {
  DiseaseModel? dis;
  DiseaseModel? get _dis => dis;
  Future<void> fetchDocument() async {
    final response = await DiseaseApiService().getDiseases();
    if (response.data.isNotEmpty) {
      dis = response;
    } else {
      dis = null;
    }
    notifyListeners();
  }
}
