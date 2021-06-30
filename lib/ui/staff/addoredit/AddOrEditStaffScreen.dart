import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo_app/data/network/Response.dart';
import 'package:flutter_demo_app/models/index.dart';
import 'package:flutter_demo_app/ui/staff/addoredit/AddOrEditStaffBloc.dart';
import 'package:flutter_demo_app/ui/staff/addoredit/AddOrEditStaffUIStates.dart';
import 'package:flutter_demo_app/utils/UtilsLibrary.dart';
import 'package:flutter_demo_app/widget/WidgetLibrary.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddOrEditStaffScreen extends StatelessWidget {
  final bool isAddStaff;
  final Staff? staff;
  late BuildContext _buildContext;
  late AddOrEditStaffBloc _addOrEditStaffBloc;

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
        hideSnackBar(buildContext: context);
        if (state is ShowValidationError) {
          Fluttertoast.showToast(msg: state.errorMessage);
        } else {
          if (state is ApiHandling) {
            if (state.response.status == Status.LOADING) {
              showProgressDialog(context);
            } else if (state.response.status == Status.HIDE_LOADING) {
              Navigator.of(context).pop();
            } else if (state.response.status == Status.ERROR) {
              showSnackBar(
                  buildContext: context,
                  message: state.response.message,
                  onButtonClicked: () => {
                    _addOrEditStaffBloc.validateCredentials()
                      });
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
    return Padding(
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
          _mobileNumberTextInput(),
          if (!isAddStaff) SizedBox(height: 32),
          if (!isAddStaff) _deleteButton(),
        ],
      ),
    );
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

  Widget _mobileNumberTextInput() {
    return TextInputField(
        initialValue: staff?.yourNumber,
        hintText: hint_mobile_number,
        onChanged: (value) {
          _addOrEditStaffBloc.onMobileNumberChange(value);
        },
        inputType: TextInputType.phone,
        inputAction: TextInputAction.done);
  }

  Widget _deleteButton() {
    return NormalButton(
      buttonText: button_delete,
      onClicked: () {},
      buttonColor: COLOR_GREY,
    );
  }
}
