import '../provider/api.dart';

class MyRepository {
  final MyApiClient apiClient;

  MyRepository({required this.apiClient}) : assert(apiClient != null);

  registerJudge(mapData) {
    return apiClient.registerJudge(mapData);
  }

  loginUser(userName, password) {
    return apiClient.loginUser(userName, password);
  }

  getTeamList(ageGroup) {
    return apiClient.getTeamList(ageGroup);
  }

  getTeamPlayerList(teamId, ageGroup, gender) {
    return apiClient.getTeamPlayerList(teamId, ageGroup, gender);
  }

}