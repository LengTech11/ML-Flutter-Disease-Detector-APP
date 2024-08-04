import 'package:disease_detector_app/api_service/api/get_history_api.dart';
import 'package:disease_detector_app/api_service/base_api_service.dart';
import 'package:disease_detector_app/config/app_constants/app_constants.dart';
import 'package:disease_detector_app/model/get_history_model/get_history_model.dart';
import 'package:flutter/cupertino.dart';

class GetHistoryProvider extends ChangeNotifier {
  List<GetHistoryModel>? history;
  bool isloading = true;

  Future<void> getHistory() async {
    try {
      final response = await GetHistoryApiService().getHistory();

      history = response;
      isloading = false;
    } catch (e) {
      isloading = false;
      print(e);
    }
    notifyListeners();
  }

  Future<void> deletePrediction(String id) async {
    return BaseApiService().onRequest(
      path: "/predictions/$id",
      method: HttpMethod.DELETE,
      requiredToken: true,
      autoRefreshToken: true,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppConstant.USER_TOKEN}'
      },
      onSuccess: (response) {
        return;
      },
    );
  }
}
