import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo_app/data/network/ApiHelper.dart';
import 'package:flutter_demo_app/data/network/ApiManager.dart';
import 'package:flutter_demo_app/data/network/Response.dart';
import 'package:flutter_demo_app/extension/extension-functions.dart';
import 'package:flutter_demo_app/ui/forgotpassword/ForgotPasswordUIStates.dart';
import 'package:flutter_demo_app/utils/UtilsLibrary.dart';

class ForgotPasswordBloc extends Cubit<ForgotPasswordUIState> {
  String _email = '';

  ForgotPasswordBloc(this._email) : super(ForgotPasswordUIState());

  void onEmailChange(String email) {
    this._email = email;
  }

  Future<void> validateCredentials() async {
    if (!_email.isValidEmail) {
      emit(ShowValidationError(error_email));
    } else {
      try {
        emit(ApiHandling(ApiResponse.loading()));
        var response = await ApiManager.sendForgotPasswordRequest(_email);
        emit(ApiHandling(ApiResponse.hideLoading()));
        emit(ApiHandling(ApiResponse.completed(response)));
      } catch (e) {
        emit(ApiHandling(ApiResponse.hideLoading()));
        emit(ApiHandling(ApiResponse.error(message: e.toString())));
      }
    }
  }
}
