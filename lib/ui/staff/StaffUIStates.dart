import 'package:flutter_demo_app/data/network/Response.dart';
import 'package:flutter_demo_app/models/index.dart';

class StaffUIStates {}

class RefreshError extends StaffUIStates {
  String errorMessage = '';
  RefreshError(this.errorMessage) : super();
}

class ShowAddOrEditStaff extends StaffUIStates {
  Staff? staff;
  bool isAddStaff = false;
  ShowAddOrEditStaff(this.staff, this.isAddStaff);
}

class ApiHandling extends StaffUIStates {
  final ApiResponse response;
  ApiHandling(this.response);
}
