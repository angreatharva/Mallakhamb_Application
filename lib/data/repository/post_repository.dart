import '../provider/api.dart';

class MyRepository {
  final MyApiClient apiClient;

  MyRepository({required this.apiClient}) : assert(apiClient != null);

  registerJudge(userName, password, isSuperior) {
    return apiClient.registerJudge(userName, password,isSuperior);
  }

  loginUser(userName, password, isSuperior) {
    return apiClient.loginUser(userName, password,isSuperior);
  }

}