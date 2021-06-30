import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo_app/data/network/ApiManager.dart';
import 'package:flutter_demo_app/data/network/Response.dart';
import 'package:flutter_demo_app/extension/extension-functions.dart';
import 'package:flutter_demo_app/models/index.dart';
import 'package:flutter_demo_app/ui/staff/addoredit/AddOrEditStaffUIStates.dart';
import 'package:flutter_demo_app/utils/UtilsLibrary.dart';

class AddOrEditStaffBloc extends Cubit<AddOrEditStaffUIStates> {
  String _firstName = '';
  String _lastName = '';
  String _emailAddress = '';
  String _mobileNumber = '';
  int? id;
  bool isAddStaff;
  Staff? staff;

  AddOrEditStaffBloc({required this.staff, required this.isAddStaff})
      : super(AddOrEditStaffUIStates()) {
    _firstName = staff?.firstName ?? '';
    _lastName = staff?.lastName ?? '';
    _emailAddress = staff?.email ?? '';
    _mobileNumber = staff?.yourNumber ?? '';
  }

  void onFirstNameChange(String firstName) {
    this._firstName = firstName;
  }

  void onLastNameChange(String lastName) {
    this._lastName = lastName;
  }

  void onEmailChange(String emailAddress) {
    this._emailAddress = emailAddress;
  }

  void onMobileNumberChange(String mobileNumber) {
    this._mobileNumber = mobileNumber;
  }

  Future<void> validateCredentials() async {
    if (_firstName.isEmpty) {
      emit(ShowValidationError(error_first_name));
    } else if (_lastName.isEmpty) {
      emit(ShowValidationError(error_last_name));
    } else if (!_emailAddress.isValidEmail) {
      emit(ShowValidationError(error_email));
    } else {
      try {
        emit(ApiHandling(ApiResponse.loading()));
        await ApiManager.addOrEditStaff(
            true, _firstName, _lastName, _emailAddress, _mobileNumber);
        emit(ApiHandling(ApiResponse.hideLoading()));
        emit(ApiHandling(ApiResponse.completed(null)));
      } catch (e) {
        emit(ApiHandling(ApiResponse.hideLoading()));
        emit(ApiHandling(ApiResponse.error(message: e.toString())));
      }
    }
  }
}
