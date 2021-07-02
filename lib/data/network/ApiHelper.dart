import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_demo_app/data/network/LoggingInterceptor.dart';
import 'package:flutter_demo_app/data/preference/Prefs.dart';
import 'package:flutter_demo_app/models/index.dart';
import 'package:flutter_demo_app/utils/UtilsLibrary.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';

import 'CustomException.dart';
import 'ExpiredTokenRetryPolicy.dart';

class ApiHelper {
  static String _baseUrl = 'https://api.prod.rosterelf.com/2.0.0/';
  static Client client = InterceptedClient.build(
      requestTimeout: Duration(seconds: 60),
      interceptors: [LoggingInterceptor()],
      retryPolicy: ExpiredTokenRetryPolicy());

  static Future<dynamic> get(String endPoint) async {
    var responseJson;
    try {
      final response =
          await client.get(Uri.parse(_baseUrl + endPoint), headers: {
        HttpHeaders.authorizationHeader: await Prefs.getToken,
      }).timeout(Duration(seconds: 60));
      responseJson = _response(response);
    } on TimeoutException {
      throw InternalServerErrorExceptions(
          title: error_message_no_internet_title,
          message: error_message_no_internet_msg);
    } on SocketException {
      throw UnknownHostException(
          title: error_message_no_internet_title,
          message: error_message_no_internet_msg);
    }
    return responseJson;
  }

  static Future<dynamic> post(String endPoint, dynamic body) async {
    var responseJson;
    try {
      final response = await client
          .post(Uri.parse(_baseUrl + endPoint), body: body, headers: {
        HttpHeaders.authorizationHeader: await Prefs.getToken,
      }).timeout(Duration(seconds: 60));
      responseJson = _response(response);
    } on TimeoutException {
      throw InternalServerErrorExceptions(
          title: error_message_no_internet_title,
          message: error_message_no_internet_msg);
    } on SocketException {
      throw UnknownHostException(
          title: error_message_no_internet_title,
          message: error_message_no_internet_msg);
    }
    return responseJson;
  }

  static dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body);
        return responseJson;
      case 401:
        throw UnAuthorizedException(
            title: error_message_unauthorized_title,
            message: error_message_unauthorized_msg);
      case 500:
        throw InternalServerErrorExceptions(
            title: error_message_server_error_title,
            message: error_message_server_error_msg);
      default:
        throw ApiSideExceptions(
            title: error_message_unknown_title,
            message:
                ApiErrorResponse.fromJson(jsonDecode(response.body)).exception);
    }
  }
}
