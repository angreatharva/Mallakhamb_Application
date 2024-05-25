import 'package:bhausaheb2k24/controller/teamPlayerListController.dart';
import 'package:get/get.dart';
import '../controller/dashboardController.dart';
import '../data/provider/api.dart';
import '../data/repository/post_repository.dart';
import 'package:http/http.dart' as http;

class TeamPlayerListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TeamPlayerListController(
        repository:
        MyRepository(apiClient: MyApiClient(httpClient: http.Client()))));
  }
}
