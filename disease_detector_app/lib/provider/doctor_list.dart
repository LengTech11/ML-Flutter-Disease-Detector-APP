import 'package:disease_detector_app/api_service/api/doctor_list_api.dart';
import 'package:disease_detector_app/model/doctor/doctor_list_model.dart';
import 'package:flutter/material.dart';

class DoctorListProvider extends ChangeNotifier {
  DoctorListModel? doctors;
  bool isLoading = true;

  Future<void> fetchDotorList() async {
    try {
      final response = await DoctorListApi().getDoctorsList();
      if (response.data.isNotEmpty) {
        doctors = response;
      } else {
        doctors = null;
      }
      isLoading = false;
    } catch (error) {
      print('Error fetching doctor: $error');
      isLoading = false;
    }
    notifyListeners();
  }
}
