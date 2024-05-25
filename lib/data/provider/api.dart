import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/appString.dart';
import '../../network/api_Client.dart';
import '../../network/request_options_builder.dart';

const baseUrl = "http://192.168.0.104:3000/";
//for uat...............................................
// const baseUrl = "https://beta-reconnect-mobileapi.colliersasia.com/api/";

const loginUser = 'token';

class MyApiClient {
  final http.Client httpClient;

  MyApiClient({required this.httpClient});

  GetStorage box = GetStorage();
  late SharedPreferences prefs;

  registerJudge(mapData) async {
    try {
      Map<String, String> headers = {
        'Content-type': 'application/json',
        // 'accept': '*/*'
      };
      print('login mapData : ' + mapData.toString());

      var response = await httpClient.post(
        Uri.parse(baseUrl + AppStrings.apiEndpoints.registerJudge),
        headers: headers,
        body: jsonEncode(mapData),

      );
      print("registerJudge response" + response.body.toString());
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse;
    } catch (e) {
      print('exception registerJudge : ' + e.toString());
    }
  }

  loginUser(userName, password) async {

    dynamic mapData = {
      "judgeName": userName,
      "password": password
    };

    try {
      Map<String, String> headers = {
        'Content-type': 'application/json',
        // 'accept': '*/*'
      };
      print('login mapData : ' + mapData.toString());

      var response = await httpClient.post(
        Uri.parse(baseUrl + AppStrings.apiEndpoints.login),
        headers: headers,
        body: jsonEncode(mapData),
      );
      print("loginUser response" + response.body.toString());
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse;
    } catch (e) {
      print('exception loginUser : ' + e.toString());
    }
  }

  getTeamList(ageGroup) async {
    try {
      String url = "${baseUrl + AppStrings.apiEndpoints.getTeamList}?ageGroup=$ageGroup";
      print("getTeamList URL: $url");
      Map<String, String> headers = {
        'Content-type': 'application/json',
        // 'accept': '*/*'
      };
      ApiClient apiClient = ApiClient.defaultClient();
      var response = await httpClient.get(
        Uri.parse(url),
        headers: headers,
      );
      print("getTeamList response" + response.body.toString());
      dynamic jsonResponse = json.decode(response.body);
      return jsonResponse;
    } catch (e) {
      print('exception getTeamList : ' + e.toString());
    }
  }

  getTeamPlayerList(teamId, ageGroup, gender) async {
    try {
      String url = "${baseUrl + AppStrings.apiEndpoints.playersData}?teamId=$teamId&ageGroup=$ageGroup&gender=$gender";
      print("getTeamPlayerList URL: $url");
      Map<String, String> headers = {
        'Content-type': 'application/json',
        // 'accept': '*/*'
      };
      ApiClient apiClient = ApiClient.defaultClient();
      var response = await httpClient.get(
        Uri.parse(url),
        headers: headers,
      );
      print("getTeamList response" + response.body.toString());
      dynamic jsonResponse = json.decode(response.body);
      return jsonResponse;
    } catch (e) {
      print('exception getTeamList : ' + e.toString());
    }
  }


}
