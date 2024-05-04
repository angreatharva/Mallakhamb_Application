import 'package:bhausaheb2k24/controller/dashboardController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../constants/app_Colors.dart';
import '../../controller/loginController.dart';

class Dashboard extends GetView<DashboardController> {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.orange,
        title: Text("Welcome,${controller.box.read("Username")}",style: TextStyle(color: AppColors.black),),
      ),
      body: Center(
        child: Text("${controller.box.read("Username")}"),
      ),
    );
  }
}
