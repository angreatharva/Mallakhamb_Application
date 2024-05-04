import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_Endpoints.dart';
import '../data/repository/post_repository.dart';
import '../routes/app_routes.dart';

class DashboardController extends GetxController with SingleGetTickerProviderMixin {
  final MyRepository repository;

  DashboardController({required this.repository}) : assert(repository != null);

  //if status is false then add other then remove..........

  var dummyText = ''.obs;
  late SharedPreferences prefs;
  GetStorage box = GetStorage();



  @override
  void onClose() {
    // flutterWebViewPlugin.dispose();
    super.onClose();
    EasyLoading.dismiss();
  }

  @override
  void onInit() {
    super.onInit();
    print("PhysicalProgressController init 123");
    box = GetStorage();
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


}