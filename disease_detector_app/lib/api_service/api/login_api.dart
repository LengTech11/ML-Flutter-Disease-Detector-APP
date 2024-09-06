import 'package:disease_detector_app/config/app_constants/app_constants.dart';
import 'package:disease_detector_app/model/login_model/login_response_model.dart';

import '../base_api_service.dart';

class LoginApiService {
  Future<LoginResponseModel> postLogin(
      {required String email, required String password}) async {
    Map<String, dynamic> query = {"email": email, "password": password};

    return BaseApiService().onRequest(
        path: "/login",
        method: HttpMethod.post,
        requiredToken: true,
        autoRefreshToken: true,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Accept-Encoding': 'Accept-Encoding',
          'Connection': 'keep-alive'
        },
        data: query,
        onSuccess: (response) {
          return LoginResponseModel.fromJson(response.data);
        });
  }
}
