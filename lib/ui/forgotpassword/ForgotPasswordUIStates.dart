import 'package:flutter_demo_app/data/network/Response.dart';


class ForgotPasswordUIState {}

class ShowValidationError extends ForgotPasswordUIState {
  String errorMessage = '';
  ShowValidationError(this.errorMessage);
}

class ApiHandling extends ForgotPasswordUIState {
  ApiResponse response;
  ApiHandling(this.response);
}
