import 'package:disease_detector_app/api_service/base_api_service.dart';
import 'package:disease_detector_app/config/app_constants/app_constants.dart';
import 'package:disease_detector_app/model/clinic/clinic_model.dart';
import 'package:disease_detector_app/model/clinic/list_clinic_model.dart';

class ClinicApiService {
  Future<ListClinicModel> getClinicList() async {
    return BaseApiService().onRequest(
      path: "/clinics",
      method: HttpMethod.get,
      onSuccess: (response) {
        return ListClinicModel.fromJson(response.data);
      },
    );
  }

  Future<ClinicModel> getClinicById(int id) async {
    return BaseApiService().onRequest(
      path: "/clinics/$id",
      method: HttpMethod.get,
      onSuccess: (response) {
        return ClinicModel.fromJson(response.data);
      },
    );
  }
}
