import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo_app/data/network/Response.dart';
import 'package:flutter_demo_app/models/index.dart';
import 'package:flutter_demo_app/ui/staff/addoredit/AddOrEditStaffBloc.dart';
import 'package:flutter_demo_app/ui/staff/addoredit/AddOrEditStaffUIStates.dart';
import 'package:flutter_demo_app/utils/UtilsLibrary.dart';
import 'package:flutter_demo_app/widget/WidgetLibrary.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:phone_number/phone_number.dart';

class AddOrEditStaffScreen extends StatelessWidget {
  final bool isAddStaff;
  final Staff? staff;
  late BuildContext _buildContext;
  late AddOrEditStaffBloc _addOrEditStaffBloc;
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  AddOrEditStaffScreen({required this.isAddStaff, required this.staff});

  @override
  Widget build(BuildContext context) {
    this._buildContext = context;
    return BlocProvider(
        create: (context) {
          _addOrEditStaffBloc =
              AddOrEditStaffBloc(staff: staff, isAddStaff: isAddStaff);
          return _addOrEditStaffBloc;
        },
        child: _blocBuilder());
  }

  Widget _blocBuilder() {
    return BlocBuilder<AddOrEditStaffBloc, AddOrEditStaffUIStates>(
        builder: (context, state) {
      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: COLOR_VIEW_BACKGROUND,
        appBar: AppBar(
          centerTitle: true,
          title: _appbarTitle(),
          actions: [
            addMenuTextItem(
                context: context,
                menuItemText: button_save,
                onTap: () {
                  _addOrEditStaffBloc.validateCredentials();
                })
          ],
        ),
        body: _blocListener(),
      );
    });
  }

  Widget _blocListener() {
    return BlocListener<AddOrEditStaffBloc, AddOrEditStaffUIStates>(
      listener: (context, state) {
        FocusScope.of(context).unfocus();
        if (state is ShowValidationError) {
          Fluttertoast.showToast(msg: state.errorMessage);
        } else {
          if (state is ApiHandling) {
            if (state.response.status == Status.LOADING) {
              showProgressDialog(context);
            } else if (state.response.status == Status.HIDE_LOADING) {
              Navigator.of(context).pop();
            } else if (state.response.status == Status.ERROR) {
              _scaffoldKey.currentState?.showSnackBar(displaySnackBar(
                  message: state.response.message, snackBarAction: null));
            } else if (state.response.status == Status.COMPLETED) {
              Navigator.pop(context, true);
            }
          }
        }
      },
      child: _addOrEditStaffBody(),
    );
  }

  Widget _addOrEditStaffBody() {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 16),
          _firstNameTextInput(),
          SizedBox(height: 12),
          _lastNameTextInput(),
          SizedBox(height: 12),
          _emailTextInput(),
          SizedBox(height: 12),
          Container(
            width: SizeConfig.screenWidth * 0.8,
            decoration: BoxDecoration(
                color: COLOR_WHITE,
                border: Border.all(color: COLOR_GREY, width: 0.5)),
            child: Row(
              children: [
                Flexible(child: _countryCodePicker()),
                Flexible(child: _mobileNumberTextField()),
              ],
            ),
          ),
          if (!isAddStaff) SizedBox(height: 32),
          if (!isAddStaff) _deleteButton(),
        ],
      ),
    ));
  }

  Widget _appbarTitle() {
    if (isAddStaff)
      return Text(label_add_staff);
    else
      return Text(label_edit_staff);
  }

  Widget _firstNameTextInput() {
    return TextInputField(
        initialValue: staff?.firstName,
        hintText: hint_first_name,
        onChanged: (value) {
          _addOrEditStaffBloc.onFirstNameChange(value);
        },
        inputType: TextInputType.name,
        inputAction: TextInputAction.next);
  }

  Widget _lastNameTextInput() {
    return TextInputField(
        initialValue: staff?.lastName,
        hintText: hint_last_name,
        onChanged: (value) {
          _addOrEditStaffBloc.onLastNameChange(value);
        },
        inputType: TextInputType.name,
        inputAction: TextInputAction.next);
  }

  Widget _emailTextInput() {
    return TextInputField(
        initialValue: staff?.email,
        hintText: hint_star_email_address,
        onChanged: (value) {
          _addOrEditStaffBloc.onEmailChange(value);
        },
        inputType: TextInputType.emailAddress,
        inputAction: TextInputAction.next);
  }

  Widget _countryCodePicker() {
    return FutureBuilder<String>(
      future: _addOrEditStaffBloc.formatCountryCode(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _displayCountryFlag(snapshot.data);
        } else {
          if (snapshot.hasError)
            return _displayCountryFlag(snapshot.data);
          else
            return _displayCountryFlag(snapshot.data);
        }
      },
    );
  }

  Widget _displayCountryFlag(String? dialCode) {
    return CountryCodePicker(
      dialogSize:
          Size(SizeConfig.screenWidth * 0.8, SizeConfig.screenHeight * 0.8),
      onChanged: (value) {
        _addOrEditStaffBloc.onCountryCodeChange(value);
      },
      onInit: (value) {
        _addOrEditStaffBloc.onCountryCodeChange(value);
      },
      initialSelection: dialCode,
      showCountryOnly: true,
      hideMainText: true,
      padding: EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
      searchDecoration: InputDecoration(hintText: 'Search by country name'),
    );
  }

  Widget _mobileNumberTextField() {
    return FutureBuilder<String>(
        future: _addOrEditStaffBloc.getFormattedNumber(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          } else if (snapshot.connectionState == ConnectionState.done) {
            return _mobileNumberTextInput(snapshot.data);
          } else {
            return _mobileNumberTextInput(hint_mobile_number);
          }
        });
  }

  Widget _mobileNumberTextInput(String? formattedNumber) {
    return TextFormField(
        initialValue: formattedNumber,
        decoration: InputDecoration(
          hintText: hint_mobile_number,
          border: InputBorder.none,
        ),
        onChanged: (value) {
          _addOrEditStaffBloc.onMobileNumberChange(value);
        },
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.done);
  }

  Widget _deleteButton() {
    return NormalButton(
      buttonText: button_delete,
      onClicked: () {
        showDialog(
            context: _buildContext,
            builder: (BuildContext context) {
              return CustomDialogBox(
                title: label_delete_staff,
                actionButtonText: button_delete,
                cancelButtonText: button_cancel,
                descriptions: msg_delete_employee,
                onPressed: () {
                  _addOrEditStaffBloc.deleteStaff(staff?.id ?? 0);
                },
              );
            });
      },
      buttonColor: COLOR_GREY,
    );
  }
}
