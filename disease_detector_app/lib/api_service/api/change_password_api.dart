import 'package:disease_detector_app/api_service/base_api_service.dart';
import 'package:disease_detector_app/config/app_constants/app_constants.dart';
import 'package:disease_detector_app/model/change_password/change_password_response_model.dart';

class ChangePasswordApiService {
  Future<ChangePasswordResponseModel> postChangePassword({
    required String oldPassword,
    required String password,
    required String confirmPassword,
  }) async {
    Map<String, dynamic> query = {
      "old_password": oldPassword,
      "password": password,
      "confirm_password": confirmPassword
    };

    return BaseApiService().onRequest(
        path: "/change-password",
        method: HttpMethod.POST,
        requiredToken: true,
        autoRefreshToken: true,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Accept-Encoding': 'Accept-Encoding',
          'Connection': 'keep-alive',
          'Authorization':'Bearer ${AppConstant.USER_TOKEN}'
        },
        data: query,
        onSuccess: (response) {
          return ChangePasswordResponseModel.fromJson(response.data);
        });
  }
}
