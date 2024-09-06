import 'package:disease_detector_app/api_service/base_api_service.dart';
import 'package:disease_detector_app/config/app_constants/app_constants.dart';
import 'package:disease_detector_app/model/get_history_model/get_history_model.dart';

class GetHistoryApiService {
  Future<List<GetHistoryModel>> getHistory() async {
    return BaseApiService().onRequest(
      path: "/predictions",
      method: HttpMethod.get,
      requiredToken: true,
      autoRefreshToken: true,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Encoding': 'Accept-Encoding',
        'Connection': 'keep-alive',
        'Authorization': 'Bearer ${AppConstant.userToken}'
      },
      onSuccess: (response) {
        return List<GetHistoryModel>.from(
          response.data.map((x) => GetHistoryModel.fromJson(x)),
        );
      },
    );
  }
}
