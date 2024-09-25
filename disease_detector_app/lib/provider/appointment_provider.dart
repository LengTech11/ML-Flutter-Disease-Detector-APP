import 'package:disease_detector_app/api_service/api/appointment_api.dart';
import 'package:disease_detector_app/model/appointment_model/list_appointment_model.dart';
import 'package:disease_detector_app/utils/logger/logger.dart';
import 'package:flutter/material.dart';

class AppointmentProvider extends ChangeNotifier {
  ListAppointmentModel? appointment;
  bool isLoading = true;

  Future<void> getAppointment() async {
    try {
      var response = await AppointmentApiService().getAppointmenList();
      appointment = response;
      isLoading = false;
    } catch (e) {
      isLoading = false;
      printMe(e);
    }

    notifyListeners();
  }
}
