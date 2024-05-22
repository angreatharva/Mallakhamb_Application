import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_Endpoints.dart';
import '../data/repository/post_repository.dart';
import '../data_model/teamsListModel.dart';
import '../routes/app_routes.dart';

class DashboardController extends GetxController with SingleGetTickerProviderMixin {
  final MyRepository repository;

  DashboardController({required this.repository}) : assert(repository != null);

  //if status is false then add other then remove..........

  var dummyText = ''.obs;
  late SharedPreferences prefs;
  GetStorage box = GetStorage();

  RxList<TeamsListModel> teamList = <TeamsListModel>[].obs;
  Rx<TextEditingController> searchTeamsEditingController = TextEditingController().obs;
  ScrollController scrollController = new ScrollController();

  @override
  void onClose() {
    super.onClose();
    EasyLoading.dismiss();
  }

  @override
  void onInit() {
    super.onInit();
    print("DashboardController init");
    box = GetStorage();
    EasyLoading.dismiss();
    getTeamList(); // Move getTeamList call here
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // App is being minimized
      // EasyLoading.dismiss();
    }
  }

  getTeamList() async {
    print(box.read("ageGroup"));
    var ageGroup = box.read("ageGroup");
    EasyLoading.show();
    try {
      var data = await repository.getTeamList(ageGroup);
      print("getTeamList data: $data");
      if (data != null && data is List<dynamic>) {
        teamList.value = data.map((item) => TeamsListModel.fromJson(item)).toList();
      } else {

        print("Invalid API response format");
      }
    } catch (e) {
      EasyLoading.dismiss();
      print("exception getTeamListController : " + e.toString());
    }
    EasyLoading.dismiss();
  }
}
