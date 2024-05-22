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
    return GetX<DashboardController>(initState: (state) {
      print("Dashboard page");
      controller.getTeamList(); // No await here
    }, builder: (context) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.orange,
          title: Text(
            "Welcome, ${controller.box.read("Username")}",
            style: TextStyle(color: AppColors.black),
          ),
        ),
        body: Container(
            height: Get.height * 0.894,
          child: _main(controller.teamList.value),
        ),
      );
    });
  }
  _main(data) {
    return Stack(
      children: [
        _search(controller, data),
        Align(
          alignment: Alignment.center,
          child: controller.teamList.isNotEmpty == true
              ? _cardList(controller, data)
              : Center(
            child: Container(
              color: Colors.white,
              child: Text(
                "Data_not_found".tr,
                style: TextStyle(fontFamily: 'Arial'),
              ),
            ),
          ),
        ),
      ],
    );
  }

  //  Search
  _search(controller, data) {
    return Container(
      height: Get.height * 0.045,
      margin: EdgeInsets.symmetric(vertical: Get.height * 0.012, horizontal: Get.width * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Stack(children: [
        TextFormField(
          controller: controller.searchTeamsEditingController.value,
          decoration: InputDecoration(
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                controller.searchTeamsEditingController.value.text.isNotEmpty
                    ? GestureDetector(
                  onTap: () {
                    controller.searchTeamsEditingController.value.text = '';
                  },
                  child: Icon(Icons.cancel, color: AppColors.grey),
                )
                    : GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.search, color: AppColors.grey),
                ),

              ],
            ),
            hintText: 'Search'.tr,
            hintStyle: TextStyle(color: Colors.grey, fontFamily: 'Arial'),
            contentPadding: EdgeInsets.symmetric(vertical: Get.height * 0.008, horizontal: Get.width * 0.03),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          onChanged: (value) {},
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
        ),
      ]),
    );
  }

  _cardList(controller, list) {
    print("_cardList${list.length}");
    return Container(
      margin: EdgeInsets.only(top: Get.height * 0.07),
      width: double.infinity,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        controller: controller.scrollController,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _unitCard(controller, index, list[index]);
        },
      ),
    );
  }




  _unitCard(controller, index, data) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color:Colors.grey),
      ),
      margin: EdgeInsets.only(bottom: Get.height * 0.005,left: Get.width * 0.02,right: Get.width * 0.02),
      padding: EdgeInsets.only(left: Get.width * 0.02,right: Get.width * 0.02,top:Get.height * 0.008,bottom: Get.height * 0.008),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              child: Text(
                data.teamName,
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,fontFamily: 'Arial'),
              ),
          ),
          Container(
            child: Text(
              data.coachName + " (" + "Coach".tr + ")",
              style: TextStyle(fontSize: 15,fontFamily: 'Arial'),
            ),
          ),
          
          Container(
            child: Text(
              "Total Marks".tr+" : "+data.totalMarks.toString(),
              style: TextStyle(fontSize: 15,fontFamily: 'Arial'),
            ),
          ),
        ],
      ),
    );
  }
}

