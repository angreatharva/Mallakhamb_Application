import '../provider/api.dart';

class MyRepository {
  final MyApiClient apiClient;

  MyRepository({required this.apiClient}) : assert(apiClient != null);

  registerJudge(mapData) {
    return apiClient.registerJudge(mapData);
  }

  loginUser(userName, password, isSuperior) {
    // return apiClient.loginUser(userName, password,isSuperior);
  }

}