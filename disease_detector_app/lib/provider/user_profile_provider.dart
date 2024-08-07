import 'dart:io';

import 'package:disease_detector_app/api_service/api/user_profile_api.dart';
import 'package:disease_detector_app/model/user_profile_model/user_profile_model.dart';
import 'package:disease_detector_app/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';

class UserProfileProvider extends ChangeNotifier {
  UserProfileModel? _userProfileModel;
  UserProfileModel? get userProfileModel => _userProfileModel;

  bool get isGuest => _userProfileModel == null;

  Future<void> getUserProfile() async {
    final result = await UserProfileApiService().getUserProfile();
    if (result.data != null) {
      _userProfileModel = result;
    } else {
      _userProfileModel = null; // Ensure _userProfileModel is null if no data
    }
    notifyListeners();
  }

  Future<void> editUserProfile({
    required String firstName,
    required String lastName,
    required int age,
    required int gender,
    required String email,
    required String phoneNumber,
    required File image,
  }) async {
    try {
      final response = await UserProfileApiService().editUserProfile(
        gender: gender,
        firstName: firstName,
        lastName: lastName,
        age: age,
        email: email,
        phoneNumber: phoneNumber,
        image: image,
      );
      if (response.data != null) {
        _userProfileModel = response;
      }
    } catch (error) {
      HelperFunctions.debug('Error: $error');
    }
    notifyListeners();
  }

  void clearUser() {
    _userProfileModel = null;
    notifyListeners();
  }
}
