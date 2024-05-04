import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//base url of localhost................................
// const baseUrl = "http://192.168.3.11:9202/api/";
const baseUrl = "http://192.168.0.104:3000/";
const registerJudges="registerJudge";
const login="login";


class MyApiClient {
  final http.Client httpClient;

  MyApiClient({required this.httpClient});

  GetStorage box = GetStorage();
  late SharedPreferences prefs;

  registerJudge(userName, password, isSuperior)async {
    try {
      Map<String, String> headers = {
        'Content-type': 'application/json',
        // 'accept': '*/*'
      };
      dynamic mapData = {
        "username":userName,
        "password":password,
        "isSuperior":isSuperior
      };
      print('login mapData : ' + mapData.toString());
      var response = await httpClient.post(Uri.parse(baseUrl + registerJudges),
        headers: headers,
        body: jsonEncode(mapData),);
      print("registerJudge response"+response.body.toString());
    } catch (e) {
      print('exception registerJudge : ' + e.toString());
    }
  }

  loginUser(userName, password, isSuperior) async {
      try {
        Map<String, String> headers = {
          'Content-type': 'application/json',
          // 'accept': '*/*'
        };
        dynamic mapData = {
          "username":userName,
          "password":password,
          "isSuperior":isSuperior
        };
        print('login mapData : ' + mapData.toString());
        var response = await httpClient.post(Uri.parse(baseUrl + login),
          headers: headers,
          body: jsonEncode(mapData),);
        print("Login response"+response.body.toString());
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse;
      } catch (e) {
        print('exception Login : ' + e.toString());
      }
    }



}