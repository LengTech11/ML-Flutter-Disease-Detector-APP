import 'package:disease_detector_app/config/app_constants/app_constants.dart';
import '../base_api_service.dart';

class SampleApiService {
  Future<String> getSampleInfo(
      {required String location, String? building, String? floor}) async {
    Map<String, dynamic> query = {"location": location};

    if (building != null) {
      query["building"] = building;
    }
    if (floor != null) {
      query["floor"] = floor;
    }
    return BaseApiService().onRequest(
        path: "YOUR PATH",
        method: HttpMethod.GET,
        requiredToken: true,
        autoRefreshToken: true,
        query: query,
        onSuccess: (response) {
          // return SampleModel.fromJson(response.data);
          return "";
        });
  }
}
