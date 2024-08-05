import 'package:disease_detector_app/api_service/api/user_profile_api.dart';
import 'package:disease_detector_app/config/app_constants/app_constants.dart';
import 'package:disease_detector_app/model/user_profile_model/user_profile_model.dart';
import 'package:flutter/material.dart';

class UserProfileProvider extends ChangeNotifier {
  UserProfileModel? _userProfileModel;
  UserProfileModel? get userProfileModel => _userProfileModel;

  bool isGuest = true;

  Future<void> getUserProfile() async {
    final result = await UserProfileApiService().getUserProfile();
    if (result.data != null) {
      _userProfileModel = result;
    } else {
      _userProfileModel = null; // Ensure _userProfileModel is null if no data
    }
    notifyListeners();
  }

  void clearUser() {
    _userProfileModel = null;
    notifyListeners();
  }

  void checkIsGuest() {
    if (AppConstant.USER_TOKEN == "" || AppConstant.USER_TOKEN == null) {
      isGuest = true;
    } else {
      isGuest = false;
    }
    notifyListeners();
  }
}
