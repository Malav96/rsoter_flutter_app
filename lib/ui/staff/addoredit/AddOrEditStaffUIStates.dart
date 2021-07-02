import 'package:flutter_demo_app/data/network/Response.dart';

class AddOrEditStaffUIStates {}

class ShowValidationError extends AddOrEditStaffUIStates {
  String errorMessage = '';
  ShowValidationError(this.errorMessage);
}

class ShowCountryFlag extends AddOrEditStaffUIStates {
  final String countryCode;
  ShowCountryFlag(this.countryCode);
}

class ApiHandling extends AddOrEditStaffUIStates {
  ApiResponse response;
  ApiHandling(this.response);
}
