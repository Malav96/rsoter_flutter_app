import 'package:country_code_picker/country_code.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo_app/data/network/ApiManager.dart';
import 'package:flutter_demo_app/data/network/Response.dart';
import 'package:flutter_demo_app/extension/extension-functions.dart';
import 'package:flutter_demo_app/models/index.dart';
import 'package:flutter_demo_app/ui/staff/addoredit/AddOrEditStaffUIStates.dart';
import 'package:flutter_demo_app/utils/UtilsLibrary.dart';
import 'package:phone_number/phone_number.dart';

class AddOrEditStaffBloc extends Cubit<AddOrEditStaffUIStates> {
  String _firstName = '';
  String _lastName = '';
  String _emailAddress = '';
  String _mobileNumber = '';
  String _regionCode = '+61';
  CountryCode? _countryCode;
  int? id;
  bool isAddStaff;
  Staff? staff;
  PhoneNumberUtil plugin = PhoneNumberUtil();

  AddOrEditStaffBloc({required this.staff, required this.isAddStaff})
      : super(AddOrEditStaffUIStates()) {
    _firstName = staff?.firstName ?? '';
    _lastName = staff?.lastName ?? '';
    _emailAddress = staff?.email ?? '';
    _mobileNumber = staff?.yourNumber ?? '';
  }

  Future<String> formatCountryCode() async {
    try {
      _regionCode = await plugin
          .parse(staff?.yourNumber ?? '')
          .then((value) => '+${value.countryCode}');
    } catch (e) {
      _regionCode = await plugin.carrierRegionCode();
    }
    return _regionCode;
  }

  Future<String> getFormattedNumber() async {
    try {
      return await plugin
          .parse(staff?.yourNumber ?? '')
          .then((value) => value.nationalNumber);
    } catch (e) {
      return _mobileNumber;
    }
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

  void onCountryCodeChange(CountryCode? countryCode) {
    this._countryCode = countryCode;
  }

  Future<void> validateCredentials() async {
    if (_firstName.isEmpty) {
      emit(ShowValidationError(error_first_name));
    } else if (_lastName.isEmpty) {
      emit(ShowValidationError(error_last_name));
    } else if (!_emailAddress.isValidEmail) {
      emit(ShowValidationError(error_email));
    } else if (_mobileNumber.isNotEmpty && !await isValidMobileNumber()) {
      emit(ShowValidationError(error_message_enter_valid_mobile));
    } else {
      if (_mobileNumber.isNotEmpty) {
        if (!_mobileNumber.contains(_countryCode?.dialCode ?? '+61')) {
          _mobileNumber = '${_countryCode?.dialCode}${_mobileNumber}';
        }
      }
      try {
        emit(ApiHandling(ApiResponse.loading()));
        await ApiManager.addOrEditStaff(staff?.id.toString() ?? '', isAddStaff,
            _firstName, _lastName, _emailAddress, _mobileNumber);
        emit(ApiHandling(ApiResponse.hideLoading()));
        emit(ApiHandling(ApiResponse.completed(null)));
      } catch (e) {
        emit(ApiHandling(ApiResponse.hideLoading()));
        emit(ApiHandling(ApiResponse.error(message: e.toString())));
      }
    }
  }

  Future<void> deleteStaff(int id) async {
    try {
      emit(ApiHandling(ApiResponse.loading()));
      await ApiManager.deleteStaff(id);
      emit(ApiHandling(ApiResponse.hideLoading()));
      emit(ApiHandling(ApiResponse.completed(null)));
    } catch (e) {
      emit(ApiHandling(ApiResponse.hideLoading()));
      emit(ApiHandling(ApiResponse.error(message: e.toString())));
    }
  }

  Future<bool> isValidMobileNumber() async {
    return await plugin.validate(_mobileNumber, _countryCode?.code ?? 'AU');
  }
}
