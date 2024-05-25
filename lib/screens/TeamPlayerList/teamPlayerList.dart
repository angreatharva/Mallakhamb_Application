import 'package:bhausaheb2k24/controller/dashboardController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../constants/app_Colors.dart';
import '../../controller/teamPlayerListController.dart';

class TeamPlayerList extends GetView<TeamPlayerListController> {
  const TeamPlayerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<TeamPlayerListController>(initState: (state) async{
      print("Team Player List page");
      await controller.getTeamPlayerList();

    }, builder: (context) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.orange,
          title: Row(
            children: [
              GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Icon(Icons.keyboard_arrow_left)),
              SizedBox(width: Get.width * 0.05,),
              Text(
              "${controller.box.read("teamName")}",
              style: TextStyle(color: AppColors.black),
                          ),
            ]
          ),

        ),
        body: Container(
          height: Get.height * 0.894,
          child: _main(controller.teamPlayerList.value),
        ),
      );
    });
  }

  _main(data) {
    return Stack(
      children: [

        Align(
          alignment: Alignment.center,
          child: controller.teamPlayerList.isNotEmpty == true
              ? _cardList(controller, data)
              : Center(
            child: Container(
              color: Colors.white,
              child: Text(
                "Data_not_found".tr,
              ),
            ),
          ),
        ),
      ],
    );
  }
  _cardList(controller, list) {
    print("_cardList${list.length}");
    return Container(
      margin: EdgeInsets.only(top: Get.height * 0.01),
      width: double.infinity,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        controller: controller.scrollController,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _playerCard(controller, index, list[index]);
        },
      ),
    );
  }

  _playerCard(controller, index, data) {
    return GestureDetector(
      onTap: (){

      },
      child: Container(
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
                data.playerName,
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,),
              ),
            ),
          ],
        ),
      ),
    );
  }

}


