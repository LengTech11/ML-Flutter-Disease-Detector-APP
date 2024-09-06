import 'package:disease_detector_app/api_service/base_api_service.dart';
import 'package:disease_detector_app/config/app_constants/app_constants.dart';
import 'package:disease_detector_app/model/disease_model.dart';

class DiseaseApiService {
  Future<DiseaseModel> getDiseases() async {
    return BaseApiService().onRequest(
        path: "/diseases",
        method: HttpMethod.get,
        requiredToken: true,
        autoRefreshToken: true,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Accept-Encoding': 'Accept-Encoding',
          'Connection': 'keep-alive',
          'Authorization': 'Bearer ${AppConstant.userToken}'
        },
        onSuccess: (response) {
          return DiseaseModel.fromJson(response.data);
        });
  }
}
