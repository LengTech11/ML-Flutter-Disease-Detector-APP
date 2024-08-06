import 'dart:io';

import 'package:dio/dio.dart';
import 'package:disease_detector_app/api_service/base_api_service.dart';
import 'package:disease_detector_app/config/app_constants/app_constants.dart';
import 'package:disease_detector_app/model/user_profile_model/user_profile_model.dart';

class UserProfileApiService {
  Future<UserProfileModel> getUserProfile() async {
    print('bart: ${AppConstant.USER_TOKEN}');
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
    required int age,
    required int gender,
    required String email,
    required String phoneNumber,
    required File? image,
  }) async {
    print('bart: ${image?.isAbsolute}');
    final formData = image!.isAbsolute
        ? FormData.fromMap({
            "first_name": firstName,
            "last_name": lastName,
            "email": email,
            "phone_number": phoneNumber,
            "age": age,
            "gender": gender,
            "profile": await MultipartFile.fromFile(image.path),
          })
        : FormData.fromMap({
            "first_name": firstName,
            "last_name": lastName,
            "email": email,
            "phone_number": phoneNumber,
            "age": age,
            "gender": gender,
          });
    return BaseApiService().onRequest(
        path: "/edit-profile",
        method: HttpMethod.POST,
        requiredToken: true,
        autoRefreshToken: true,
        data: formData,
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
