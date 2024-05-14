import 'package:bhausaheb2k24/constants/app_Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../constants/appString.dart';
import '../../controller/loginController.dart';
import '../../custom_widgets/custom_drop_down.dart';
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
                    onDoubleTap: () {
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
                SizedBox(
                  width: Get.width * 0.01,
                ),
                Container(
                  width: Get.width * 0.6,
                  child: Text(
                    AppStrings.competionName + " " + AppStrings.competionYear,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Get.height * 0.02),

          // Username TextField
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              controller: controller.judgeNameRegister.value,
              decoration: InputDecoration(
                labelText: "Enter Judge Name",
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          SizedBox(height: Get.height * 0.02),

          // Password TextField
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              controller: controller.passwordRegister.value,
              decoration: InputDecoration(
                labelText: "Password",
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          SizedBox(height: Get.height * 0.02),

          Row(
            children: [
              Expanded(
                child: RadioListTile(
                  title: Text('Boys'),
                  value: 'Boys',
                  groupValue: controller.selectedGender.value,
                  onChanged: (value) =>
                      controller.selectedGender.value = value!,
                ),
              ),
              Expanded(
                child: RadioListTile(
                  title: Text('Girls'),
                  value: 'Girls',
                  groupValue: controller.selectedGender.value,
                  onChanged: (value) =>
                      controller.selectedGender.value = value!,
                ),
              ),
            ],
          ),
          SizedBox(height: Get.height * 0.02),
          Container(
            margin: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
            child: _ageDropDown(controller),
          ),

          // Radio buttons for judge types
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: RadioListTile(
                        title: Text('Superior Judge'),
                        value: 'Superior',
                        groupValue: controller.selectedJudgeType.value,
                        onChanged: (value) =>
                            controller.selectedJudgeType.value = value!,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        title: Text('Judge 1'),
                        value: 'Judge 1',
                        groupValue: controller.selectedJudgeType.value,
                        onChanged: (value) =>
                            controller.selectedJudgeType.value = value!,
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: Text('Judge 2'),
                        value: 'Judge 2',
                        groupValue: controller.selectedJudgeType.value,
                        onChanged: (value) =>
                            controller.selectedJudgeType.value = value!,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        title: Text('Judge 3'),
                        value: 'Judge 3',
                        groupValue: controller.selectedJudgeType.value,
                        onChanged: (value) =>
                            controller.selectedJudgeType.value = value!,
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: Text('Judge 4'),
                        value: 'Judge 4',
                        groupValue: controller.selectedJudgeType.value,
                        onChanged: (value) =>
                            controller.selectedJudgeType.value = value!,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColors.black),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
              ),
              onPressed: () {
                print("judgeName :${controller.judgeNameRegister.value.text}");
                print("password :${controller.passwordRegister.value.text}");
                controller.registerJudge(
                    controller.judgeNameRegister.value.text,
                    controller.passwordRegister.value.text,
                    controller.selectedJudgeType.value,
                    controller.selectedAgeGroup.value,
                    controller.selectedGender.value);
              },
              child: Text(
                "Register",
                style: TextStyle(color: AppColors.white),
              ))
        ],
      );
    });
  }

  Widget _ageDropDown(controller) {
    return Builder(builder: (context) {
      return Obx(() => CustomDropDown(
            dropdownList: controller.ageGroupList.value,
            value: controller.selectedAgeGroup.value != ''
                ? controller.selectedAgeGroup.value
                : null,
            selectedData: (value) async {
              if (value == '0') {
                print('SelectAge : $value');
                controller.selectedAgeGroup.value = '';
              } else {
                controller.selectedAgeGroup.value = value;
              }
            },
          ));
    });
  }
}
