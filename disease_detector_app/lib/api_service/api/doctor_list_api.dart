import 'package:disease_detector_app/api_service/base_api_service.dart';
import 'package:disease_detector_app/config/app_constants/app_constants.dart';
import 'package:disease_detector_app/model/doctor/doctor_list_model.dart';

class DoctorListApi {
  Future<DoctorListModel> getDoctorsList() async {
    return BaseApiService().onRequest(
        path: "/doctors",
        method: HttpMethod.GET,
        autoRefreshToken: true,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Accept-Encoding': 'Accept-Encoding',
          'Connection': 'keep-alive',
          'Authorization': 'Bearer ${AppConstant.USER_TOKEN}'
        },
        onSuccess: (response) {
          return DoctorListModel.fromJson(response.data);
        });
  }
}
