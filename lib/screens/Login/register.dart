import 'package:bhausaheb2k24/constants/app_Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../constants/appString.dart';
import '../../controller/loginController.dart';
import '../../routes/app_routes.dart';

class Register extends GetView<LoginController> {
  Register(this.navigatorKey);
  GlobalKey<NavigatorState> navigatorKey;
  // Login(this.navigatorKey);
  // GlobalKey<NavigatorState> navigatorKey;

  final FocusNode _focusNode = FocusNode();
  final formGlobalKey = GlobalKey<FormState>();
  // Rx<TextEditingController> scanEditingController = TextEditingController().obs;
  TextEditingController scanEditingController = TextEditingController();

  init() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // executes after build
      // controller.checkForAlreadyLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetX<LoginController>(initState: (_) {
      init();
    }, builder: (controller) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: 'logo',
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                  child: GestureDetector(
                    onDoubleTap: (){
                      Get.toNamed(Routes.LOGIN);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset(
                        "assets/images/bhausahebLogo.jpg",
                        height: Get.height * 0.15,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: Get.width * 0.01,),
                Container(
                  width: Get.width * 0.6,
                  child: Text(AppStrings.competionName +" "+ AppStrings.competionYear,
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
                ),
              ],
            ),
          ),
          SizedBox(height: Get.height * 0.1,),
          TextFormField(

            controller: controller.userNameRegister.value,
          ),
          TextFormField(
            controller: controller.passwordRegister.value,
          ),
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF004780)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))),
              ),
              onPressed: (){
            print("userName :${controller.userNameRegister.value.text}");
            print("password :${controller.passwordRegister.value.text}");
            controller.registerAdmin(controller.userNameRegister.value.text,controller.passwordRegister.value.text,true);
          }, child: Text("Register",style: TextStyle(color: AppColors.white),))
        ],
      );
    });
  }
}
