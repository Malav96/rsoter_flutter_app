import 'package:flutter_demo_app/data/network/ApiHelper.dart';
import 'package:flutter_demo_app/models/index.dart';
import 'package:flutter_demo_app/utils/UtilsLibrary.dart';

class ApiManager {
  static Future<LoginResponse> performLogin(
      String email, String password) async {
    var apiRequest = {KEY_USERNAME: email, KEY_PASSWORD: password};
    final response = await ApiHelper.post(AUTH, apiRequest);
    return LoginResponse.fromJson(response);
  }

  static Future<String> sendForgotPasswordRequest(String email) async {
    var apiRequest = {KEY_EMAIL: email};
    final response = await ApiHelper.post(RESET_PASSWORD, apiRequest);
    return response;
  }

  static Future<StaffResponse> getStaffList() async {
    final response = await ApiHelper.get(STAFF);
    return StaffResponse.fromJson(response);
  }

  static Future<String> performLogout() async {
    final response = await ApiHelper.get(LOGOUT);
    return response;
  }
}
