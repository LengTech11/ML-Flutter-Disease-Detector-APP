import 'package:disease_detector_app/api_service/api/user_profile_api.dart';
import 'package:disease_detector_app/model/user_profile_model/user_profile_model.dart';
import 'package:disease_detector_app/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';

class UserProfileProvider extends ChangeNotifier {
  UserProfileModel? _userProfileModel;
  UserProfileModel? get userProfileModel => _userProfileModel;

  Future<void> getUserProfile() async {
    final result = await UserProfileApiService().getUserProfile();
    if (result.data != null) {
      _userProfileModel = result;
    } else {
      _userProfileModel = null;
    }
    notifyListeners();
  }

  void clearUser() {
    _userProfileModel = null;
    notifyListeners();
  }
}
