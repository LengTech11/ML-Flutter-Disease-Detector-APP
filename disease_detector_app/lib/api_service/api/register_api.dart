import 'package:disease_detector_app/config/app_constants/app_constants.dart';
import 'package:disease_detector_app/model/login_model/login_response_model.dart';
import '../base_api_service.dart';

class RegisterApiService {
  Future<LoginResponseModel> postRegister(
      {required String firstName,
      required String lastName,
      required String email,
      required String phonNumber,
      required String password,
      required int age,
      required int gender}) async {
    Map<String, dynamic> query = {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "age": age,
      "phone_number": phonNumber,
      "gender": gender,
      "password": password
    };

    return BaseApiService().onRequest(
        path: "/register",
        method: HttpMethod.POST,
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
