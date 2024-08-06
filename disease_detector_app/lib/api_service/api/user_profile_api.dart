import 'package:disease_detector_app/api_service/base_api_service.dart';
import 'package:disease_detector_app/config/app_constants/app_constants.dart';
import 'package:disease_detector_app/model/user_profile_model/user_profile_model.dart';

class UserProfileApiService {
  Future<UserProfileModel> getUserProfile() async {
    return BaseApiService().onRequest(
        path: "/profile",
        method: HttpMethod.GET,
        requiredToken: true,
        autoRefreshToken: true,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Accept-Encoding': 'Accept-Encoding',
          'Connection': 'keep-alive',
          'Authorization': 'Bearer ${AppConstant.USER_TOKEN}'
        },
        onSuccess: (response) {
          return UserProfileModel.fromJson(response.data);
        });
  }

  Future<UserProfileModel> editUserProfile({
    required String firstName,
    required String lastName,
    // required int age,
    required String email,
    required String phoneNumber,
    // required File image,
  }) async {
    return BaseApiService().onRequest(
        path: "/edit-profile",
        method: HttpMethod.POST,
        requiredToken: true,
        autoRefreshToken: true,
        query: {
          "first_name": firstName,
          "last_name": lastName,
          // "profile": image,
          "email": email,
          "phone_number": phoneNumber
          // "age": age
        },
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Accept-Encoding': 'Accept-Encoding',
          'Connection': 'keep-alive',
          'Authorization': 'Bearer ${AppConstant.USER_TOKEN}'
        },
        onSuccess: (response) {
          return UserProfileModel.fromJson(response.data);
        });
  }
}
