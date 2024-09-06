import 'package:disease_detector_app/api_service/base_api_service.dart';
import 'package:disease_detector_app/config/app_constants/app_constants.dart';
import 'package:disease_detector_app/model/document_model.dart';

class DocumentApiService {
  Future<DocumentModel> getDocument({required String diseaseName}) async {
    return BaseApiService().onRequest(
        path: "/documents",
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
        query: {
          'disease': diseaseName,
        },
        onSuccess: (response) {
          return DocumentModel.fromJson(response.data);
        });
  }
}
