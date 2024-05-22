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
import '../routes/app_routes.dart';

class LoginController extends GetxController with SingleGetTickerProviderMixin {
  final MyRepository repository;

  LoginController({required this.repository}) : assert(repository != null);

  //if status is false then add other then remove..........

  var isLoading = false.obs;
  GetStorage box = GetStorage();
  Rx<TextEditingController> userNameLogin = TextEditingController().obs;
  Rx<TextEditingController> passwordLogin = TextEditingController().obs;
  Rx<TextEditingController> judgeNameRegister = TextEditingController().obs;
  Rx<TextEditingController> passwordRegister = TextEditingController().obs;
  var url = ''.obs;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var isShowPass = true.obs;
  var isSuperior = false.obs;
  var dummyText = ''.obs;
  late SharedPreferences prefs;
  // var selectedJudge;
  var selectedJudgeType = 'Superior'.obs;
  var selectedGender = 'Boys'.obs;
  RxList<DropdownList> ageGroupList = <DropdownList>[
    DropdownList('under12', 'Under 12'),
    DropdownList('under14', 'Under 14'),
    DropdownList('under16', 'Under 16'),
    DropdownList('under18', 'Under 18'),
    DropdownList('above16', 'Above 16'),
    DropdownList('above18', 'Above 18'),
  ].obs;
  var selectedAgeGroup = "".obs;

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

  registerJudge(judgeName, password, judge, ageGroup, gender) async {
    EasyLoading.show();
    try {
      print('auth : ' + judgeName + "-" + password);
      Map<String, dynamic> mapData = {
        "judgeName": judgeName,
        "password": password,
        "judge": judge,
        "ageGroup": ageGroup,
        "gender": gender
      };
      if (judgeName.isNotEmpty && password.isNotEmpty) {
        repository.registerJudge(mapData).then((data) {
          print("Register data: $data");
          if (data != null) {
            if (data['status'] != 'Failure') {
              print('Register Success');
              Get.snackbar("Login Successful",
                  "${data["judgeName"]} - ${data["judge"]} - ${data["ageGroup"]}",
                  duration: const Duration(seconds: 3),
                  backgroundColor: AppColors.green);
              judgeNameRegister.value.clear();
              passwordRegister.value.clear();
              selectedAgeGroup.value = "";
              EasyLoading.dismiss();

            }
          }
          else {
            print("Register Failed");
            Get.snackbar("Register failed", "",backgroundColor: Colors.red);
            EasyLoading.dismiss();
          }
        });
      } else {
        Get.snackbar(
            "Email or Password not Entered", "Please Enter Email and Password");
      }
    } catch (e) {
      EasyLoading.dismiss();
      print("exception: " + e.toString());
    }
  }

  void loginUser(userName, password) async {
    try {
      if (userName.isNotEmpty && password.isNotEmpty) {
        repository.loginUser(userName, password).then((data) {
          if (data != null) {
            if (data["message"] == "Login successful") {
              print("Login Success");
              box.write("Username", data["judgeDetails"]["judgeName"]);
              box.write("ageGroup", data["judgeDetails"]["ageGroup"]);
              Get.offNamed(Routes.DASHBOARD);
            } else {
              print("Login Failed");
              Get.snackbar("Login failed", "Please check Email and Password");
            }
          }
        });
      }
    } catch (e) {
      EasyLoading.dismiss();
      print("exception: " + e.toString());
    }
  }
}
