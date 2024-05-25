import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_Endpoints.dart';
import '../constants/app_Colors.dart';
import '../data/repository/post_repository.dart';
import '../data_model/dropDown_model.dart';
import '../data_model/getTeamPlayerListModel.dart';
import '../routes/app_routes.dart';

class TeamPlayerListController extends GetxController with SingleGetTickerProviderMixin {
  final MyRepository repository;

  TeamPlayerListController({required this.repository})
      : assert(repository != null);

  GetStorage box = GetStorage();
  var dummyText = ''.obs;
  late SharedPreferences prefs;
  ScrollController scrollController = new ScrollController();

  RxList<TeamPlayerList> teamPlayerList = <TeamPlayerList>[].obs;

  @override
  void onClose() {
    super.onClose();
    EasyLoading.dismiss();
  }

  @override
  void onInit() {
    super.onInit();
    print("TeamPlayerListController init");
    box = GetStorage();
    getTeamPlayerList();
    // EasyLoading.init();
    EasyLoading.dismiss();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // App is being minimized
      // EasyLoading.dismiss();
    }
  }
  getTeamPlayerList() async {
    print("teamId: ${box.read("teamId")}");
    print("ageGroup: ${box.read("ageGroup")}");
    print("gender: ${box.read("gender")}");
    var teamId = box.read("teamId");
    var ageGroup = box.read("ageGroup");
    var gender = box.read("gender");
    EasyLoading.show();
    try {
      var data = await repository.getTeamPlayerList(teamId, ageGroup, gender);
      print("getTeamPlayerList data: $data");
      if (data != null && data is List) {
        teamPlayerList.value = data.map((player) => TeamPlayerList.fromJson(player)).toList();
      } else {
        print("Invalid API response format");
      }
    } catch (e) {
      print("exception getTeamListController : " + e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }
}
