import 'package:flutter_demo_app/data/network/ApiHelper.dart';
import 'package:flutter_demo_app/models/index.dart';
import 'package:flutter_demo_app/utils/UtilsLibrary.dart';

class ApiManager {
  static Future<LoginResponse> performLogin(
      String email, String password) async {
    var apiRequest = {KEY_USERNAME: email, KEY_PASSWORD: password};
    return LoginResponse.fromJson(await ApiHelper.post(AUTH, apiRequest));
  }

  static Future<String> sendForgotPasswordRequest(String email) async {
    var apiRequest = {KEY_EMAIL: email};
    return await ApiHelper.post(RESET_PASSWORD, apiRequest);
  }

  static Future<StaffResponse> getStaffList() async {
    return StaffResponse.fromJson(await ApiHelper.get(STAFF));
  }

  static Future<String> performLogout() async {
    return await ApiHelper.get(LOGOUT);
  }

  static Future<void> addOrEditStaff(bool isAddStaff, String firstName,
      String lastName, String emailAddress, String mobileNumber) async {
    var apiRequest = {
      KEY_FIRST_NAME: firstName,
      KEY_LAST_NAME: lastName,
      KEY_EMAIL: emailAddress,
      KEY_MOBILE_NUMBER: mobileNumber
    };
    if (isAddStaff)
      return await ApiHelper.post(ADD_STAFF, apiRequest);
    else
      return await ApiHelper.post(UPDATE_STAFF, apiRequest);
  }

  static Future<String> deleteStaff(String staffId) async {
    var apiRequest = {KEY_ID: staffId};
    return await ApiHelper.post(ADD_STAFF, apiRequest);
  }
}
