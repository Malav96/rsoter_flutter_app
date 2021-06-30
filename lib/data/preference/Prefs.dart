import 'dart:async';

import 'PreferencesHelper.dart';

class Prefs {
  static Future<bool> get isUserLoggedIn =>
      PreferencesHelper.getBool(Const.PREF_IS_USER_LOGGED_IN);

  static Future setUserLoggedIn(bool value) =>
      PreferencesHelper.setBool(Const.PREF_IS_USER_LOGGED_IN, value);

  static Future<String> get getToken =>
      PreferencesHelper.getString(Const.PREF_USER_TOKEN);

  static Future setToken(String value) =>
      PreferencesHelper.setString(Const.PREF_USER_TOKEN, value);

  static Future<String> get getUserEmail =>
      PreferencesHelper.getString(Const.PREF_USER_EMAIL);

  static Future setUserEmail(String value) =>
      PreferencesHelper.setString(Const.PREF_USER_EMAIL, value);

  static Future<String> get getUserPassword =>
      PreferencesHelper.getString(Const.PREF_USER_PASSWORD);

  static Future setUserPassword(String value) =>
      PreferencesHelper.setString(Const.PREF_USER_PASSWORD, value);

  static Future<void> clear() async {
    await Future.wait(<Future>[
      setUserLoggedIn(false),
      setToken(''),
      setUserPassword(''),
      setUserEmail('')
    ]);
  }
}

class Const {
  // Default preferences
  static const PREF_IS_USER_LOGGED_IN = 'IsUserLoggedIn';
  static const PREF_USER_TOKEN = 'UserToken';
  static const PREF_USER_EMAIL = 'UserEmail';
  static const PREF_USER_PASSWORD = 'UserPassword';
}
