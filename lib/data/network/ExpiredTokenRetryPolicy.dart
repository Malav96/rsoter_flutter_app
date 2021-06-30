import 'package:flutter_demo_app/data/network/ApiManager.dart';
import 'package:flutter_demo_app/data/preference/Prefs.dart';
import 'package:http_interceptor/models/response_data.dart';
import 'package:http_interceptor/models/retry_policy.dart';

class ExpiredTokenRetryPolicy extends RetryPolicy {
  @override
  Future<bool> shouldAttemptRetryOnResponse(ResponseData response) async {
    if (response.statusCode == 401) {
      var response = await ApiManager.performLogin(
          await Prefs.getUserEmail, await Prefs.getUserPassword);
      Prefs.setToken(response.sid);
      return true;
    }
    return false;
  }
}
