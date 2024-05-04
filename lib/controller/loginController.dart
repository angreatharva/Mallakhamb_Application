import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_Endpoints.dart';
import '../data/repository/post_repository.dart';
import '../routes/app_routes.dart';

class LoginController extends GetxController with SingleGetTickerProviderMixin {
  final MyRepository repository;

  LoginController({required this.repository}) : assert(repository != null);

  //if status is false then add other then remove..........

  var isLoading = false.obs;
  GetStorage box = GetStorage();
  Rx<TextEditingController> userNameLogin = TextEditingController().obs;
  Rx<TextEditingController> passwordLogin = TextEditingController().obs;
  Rx<TextEditingController> userNameRegister = TextEditingController().obs;
  Rx<TextEditingController> passwordRegister = TextEditingController().obs;
  var url = ''.obs;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var isShowPass = true.obs;
  var isSuperior = false.obs;
  var dummyText = ''.obs;
  late SharedPreferences prefs;
  // var selectedJudge;
  var selectedJudgeType = 'Superior'.obs;


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

  registerAdmin(userName,password,isSuperior)async {
    // EasyLoading.dismiss();
    try {
      print('auth : ' + userName +"-"+ password);
      if (userName.isNotEmpty && password.isNotEmpty) {
        repository.registerJudge(userName, password,isSuperior).then((data) {
          print("Register data: ${data}");
          if (data != null) {
            if (data['status'] != 'Failure') {
              print('Register Success');
            }
            else {
              print("Register Failed");
              Get.snackbar("Register failed","");
            }
          }
          else {
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

  void loginUser(userName,password,isSuperior) async{
    try{
      if(userName.isNotEmpty && password.isNotEmpty){
        repository.loginUser(userName, password,isSuperior).then((data) {
          if(data != null){
            if(data["status"] != "true"){
              print("Login Success");
              box.write("Username", data["username"]);
              Get.offNamed(Routes.DASHBOARD);
            }
            else{
              print("Login Failed");
              Get.snackbar("Login failed", "Please check Email and Password");
            }
          }

        });
      }
    }
    catch(e){
      EasyLoading.dismiss();
      print("exception: " + e.toString());
    }

  }
}