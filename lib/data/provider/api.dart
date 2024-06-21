import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/appString.dart';
import '../../constants/app_Colors.dart';
import '../../network/api_Client.dart';
import '../../network/request_options_builder.dart';

const baseUrl = "http://192.168.0.105:3000/";


const loginUser = 'token';

class MyApiClient {
  final http.Client httpClient;

  MyApiClient({required this.httpClient});

  GetStorage box = GetStorage();
  late SharedPreferences prefs;

   registerJudge(Map<String, dynamic> mapData) async {
    try {
      print('login mapData : ' + mapData.toString());
      ApiClient apiClient = ApiClient.defaultClient();
      var response = await apiClient.dioClient.post(
        AppStrings.apiEndpoints.registerJudge,
        data: jsonEncode(mapData),
        options: (await AppRequestOptionsBuilder().defaultHeader()).build(),
      );
      if (response.statusCode == 200) {
        dynamic jsonResponse = response.data;
        print("registerJudge response: " + jsonEncode(jsonResponse));
        return jsonResponse;
      } else {
        print('Error in registerJudge response: Status Code ' + response.statusCode.toString());
        print('Response data: ' + response.data.toString());

        return null;
      }
    }
    catch (e) {
      if (e is DioException) {
        print('DioException in registerJudge: ' + e.toString());
        print('Response status code: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
        Get.snackbar("REGISTER FAILED ",
            "${e.response?.data['error'].toString()}",
            duration: const Duration(seconds: 3),
            backgroundColor: AppColors.red);
      } else {
        print('Exception in registerJudge: ' + e.toString());
      }
      return null;
    }
  }

  loginUser(userName, password) async {

    dynamic mapData = {
      "judgeName": userName,
      "password": password
    };
    try {
      print('login mapData : ' + mapData.toString());
      ApiClient apiClient = ApiClient.defaultClient();
      var response = await apiClient.dioClient.post(
        AppStrings.apiEndpoints.login,
        data: jsonEncode(mapData),
        options: (await AppRequestOptionsBuilder().defaultHeader()).build(),
      );
      if (response.statusCode == 200) {
        dynamic jsonResponse = response.data;
        print("loginUser response: " + jsonEncode(jsonResponse));
        return jsonResponse;
      } else {
        print('Error in loginUser response: Status Code ' + response.statusCode.toString());
        print('Response data: ' + response.data.toString());

        return null;
      }
    }
    catch (e) {
      if (e is DioException) {
        print('DioException in loginUser: ' + e.toString());
        print('Response status code: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
        Get.snackbar("loginUser FAILED",
            "${e.response?.data['error'].toString()}",
            duration: const Duration(seconds: 3),
            backgroundColor: AppColors.red);
      } else {
        print('Exception in registerJudge: ' + e.toString());
      }
      return null;
    }

  }

  getTeamList(ageGroup) async {
    try {
      ApiClient apiClient = ApiClient.defaultClient();
      var response = await apiClient.dioClient.get(
        AppStrings.apiEndpoints.getTeamList,
        queryParameters:ageGroup ,
        // data: jsonEncode(mapData),
        options: (await AppRequestOptionsBuilder().defaultHeader()).build(),
      );
      print(json.decode(response.statusCode.toString()));
      if (response.statusCode == 200) {
        dynamic jsonResponse = response.data;
        print("getTeamList response: " + jsonEncode(jsonResponse));
        return jsonResponse;
      } else {
        print('Error in getTeamList response: Status Code ' + response.statusCode.toString());
        print('Response data: ' + response.data.toString());

        return null;
      }
    }
    catch (e) {
      if (e is DioException) {
        print('DioException in getTeamList: ' + e.toString());
        print('Response status code: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
        Get.snackbar("getTeamList Failed",
            "${e.response?.data['error'].toString()}",
            duration: const Duration(seconds: 3),
            backgroundColor: AppColors.red);
      }
      else {
        print('Exception in getTeamList: $e');
      }
      return null;
    }

  }

  getTeamPlayerList(query) async {
    try {
      ApiClient apiClient = ApiClient.defaultClient();
      var response = await apiClient.dioClient.get(
        AppStrings.apiEndpoints.playersData,
        queryParameters:query ,
        // data: jsonEncode(mapData),
        options: (await AppRequestOptionsBuilder().defaultHeader()).build(),
      );
      print(json.decode(response.statusCode.toString()));
      if (response.statusCode == 200) {
        dynamic jsonResponse = response.data;
        print("getTeamPlayerList response: " + jsonEncode(jsonResponse));
        return jsonResponse;
      } else {
        print('Error in getTeamPlayerList response: Status Code ' + response.statusCode.toString());
        print('Response data: ' + response.data.toString());

        return null;
      }
    }
    catch (e) {
      if (e is DioException) {
        print('DioException in getTeamPlayerList: ' + e.toString());
        print('Response status code: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
        Get.snackbar("getTeamPlayerList Failed",
            "${e.response?.data['error'].toString()}",
            duration: const Duration(seconds: 3),
            backgroundColor: AppColors.red);
      }
      else {
        print('Exception in getTeamPlayerList: $e');
      }
      return null;
    }

    // try {
    //   String url = "${baseUrl + AppStrings.apiEndpoints.playersData}?teamId=$teamId&ageGroup=$ageGroup&gender=$gender";
    //   print("getTeamPlayerList URL: $url");
    //   Map<String, String> headers = {
    //     'Content-type': 'application/json',
    //     // 'accept': '*/*'
    //   };
    //   ApiClient apiClient = ApiClient.defaultClient();
    //   var response = await httpClient.get(
    //     Uri.parse(url),
    //     headers: headers,
    //   );
    //   print("getTeamList response" + response.body.toString());
    //   dynamic jsonResponse = json.decode(response.body);
    //   return jsonResponse;
    // } catch (e) {
    //   print('exception getTeamList : ' + e.toString());
    // }
  }


}
