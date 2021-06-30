import 'package:flutter_demo_app/data/network/Response.dart';

class LoginUIStates {}

class ShowValidationError extends LoginUIStates {
  String errorMessage = '';
  ShowValidationError(this.errorMessage);
}

class ShowForgotPassword extends LoginUIStates {
  String email = '';
  ShowForgotPassword(this.email);
}

class ApiHandling extends LoginUIStates {
  ApiResponse response;
  ApiHandling(this.response);
}
