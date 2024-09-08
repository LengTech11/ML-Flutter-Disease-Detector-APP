import 'package:disease_detector_app/api_service/base_api_service.dart';
import 'package:disease_detector_app/config/app_constants/app_constants.dart';
import 'package:disease_detector_app/model/appointment_model/appointment_model.dart';
import 'package:disease_detector_app/model/appointment_model/list_appointment_model.dart';

class AppointmentApiService {
  Future<AppointmentModel> requestAppointment({
    required int doctorId,
    required String preferredDate,
    required String phoneNumber,
  }) async {
    Map<String, dynamic> query = {
      "doctor_id": doctorId,
      "preferred_date": preferredDate,
      "phone_number": phoneNumber
    };

    return BaseApiService().onRequest(
      path: "/appointment-requests",
      method: HttpMethod.post,
      requiredToken: true,
      autoRefreshToken: true,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Encoding': 'Accept-Encoding'
      },
      data: query,
      onSuccess: (response) {
        return AppointmentModel.fromJson(response.data);
      },
    );
  }

  Future<ListAppointmentModel> getAppointmenList() async {
    return BaseApiService().onRequest(
      path: "/appointment-requests",
      method: HttpMethod.get,
      requiredToken: true,
      autoRefreshToken: true,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Encoding': 'Accept-Encoding',
        'Authorization': 'Bearer ${AppConstant.userToken}'
      },
      onSuccess: (response) {
        return ListAppointmentModel.fromJson(response.data);
      },
    );
  }
}
