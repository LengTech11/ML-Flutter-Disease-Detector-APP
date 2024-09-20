import 'package:disease_detector_app/api_service/api/disease_api.dart';
import 'package:disease_detector_app/model/disease_model.dart';
import 'package:flutter/material.dart';

class DiseaseProvider extends ChangeNotifier {
  DiseaseModel? dis;

  Future<void> fetchDisease() async {
    final response = await DiseaseApiService().getDiseases();
    if (response.data != null) {
      dis = response;
    } else {
      dis = null;
    }

    notifyListeners();
  }
}
