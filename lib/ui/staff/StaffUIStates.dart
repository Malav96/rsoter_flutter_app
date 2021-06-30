import 'package:flutter_demo_app/data/network/Response.dart';

class StaffUIStates {}

class RefreshError extends StaffUIStates {
  String errorMessage = '';
  RefreshError(this.errorMessage);
}

class ApiHandling extends StaffUIStates {
  ApiResponse response;

  ApiHandling(this.response);
}
