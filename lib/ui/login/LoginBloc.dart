import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo_app/data/network/ApiManager.dart';
import 'package:flutter_demo_app/data/network/Response.dart';
import 'package:flutter_demo_app/data/preference/Prefs.dart';
import 'package:flutter_demo_app/extension/extension-functions.dart';
import 'package:flutter_demo_app/ui/login/LoginUIStates.dart';
import 'package:flutter_demo_app/utils/UtilsLibrary.dart';

class LoginBloc extends Cubit<LoginUIStates> {
  LoginBloc() : super(LoginUIStates());

  String _email = '';
  String _password = '';

  void onEmailChange(String email) {
    this._email = email;
  }

  void onPasswordChange(String password) {
    this._password = password;
  }

  void onForgotPasswordButtonClick() {
    emit(ShowForgotPassword(_email));
  }

  Future<void> validateCredentials() async {
    if (!_email.isValidEmail) {
      emit(ShowValidationError(error_email));
    } else if (_password.isEmpty) {
      emit(ShowValidationError(error_password));
    } else {
      try {
        emit(ApiHandling(ApiResponse.loading()));
        var response = await ApiManager.performLogin(_email, _password);
        Prefs.setUserLoggedIn(true);
        Prefs.setToken(response.sid);
        Prefs.setUserEmail(_email);
        Prefs.setUserPassword(_password);
        emit(ApiHandling(ApiResponse.hideLoading()));
        emit(ApiHandling(ApiResponse.completed(response)));
      } catch (e) {
        emit(ApiHandling(ApiResponse.hideLoading()));
        emit(ApiHandling(ApiResponse.error(message: e.toString())));
      }
    }
  }
}
