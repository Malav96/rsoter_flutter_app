import 'package:flutter_demo_app/data/network/Response.dart';

class AddOrEditStaffUIStates {}

class ShowValidationError extends AddOrEditStaffUIStates {
  String errorMessage = '';
  ShowValidationError(this.errorMessage);
}

class ApiHandling extends AddOrEditStaffUIStates {
  ApiResponse response;
  ApiHandling(this.response);
}
