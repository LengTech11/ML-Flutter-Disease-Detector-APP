import 'package:disease_detector_app/api_service/api/get_history_api.dart';
import 'package:disease_detector_app/model/get_history_model/get_history_model.dart';
import 'package:flutter/cupertino.dart';

class GetHistoryProvider extends ChangeNotifier {
  List<GetHistoryModel>? history;

  Future<void> getHistory() async {
    try {
      final response = await GetHistoryApiService().getHistory();

      history = response;
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
