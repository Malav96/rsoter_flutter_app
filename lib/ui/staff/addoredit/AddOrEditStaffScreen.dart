import 'package:flutter/material.dart';
import 'package:flutter_demo_app/utils/UtilsLibrary.dart';
import 'package:flutter_demo_app/widget/WidgetLibrary.dart';

class AddOrEditStaffScreen extends StatelessWidget {
  final bool isAddStaff;

  const AddOrEditStaffScreen({required this.isAddStaff});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR_VIEW_BACKGROUND,
      appBar: AppBar(
        centerTitle: true,
        title: _appbarTitle(isAddStaff),
        actions: [
          addMenuTextItem(
              context: context, menuItemText: button_save, onTap: () {})
        ],
      ),
      body: Padding(
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
      ),
    );
  }
}

Widget _appbarTitle(bool isAddStaff) {
  if (isAddStaff)
    return Text(label_add_staff);
  else
    return Text(label_edit_staff);
}

Widget _firstNameTextInput() {
  return TextInputField(
      hintText: hint_first_name,
      onChanged: (value) {},
      inputType: TextInputType.name,
      inputAction: TextInputAction.next);
}

Widget _lastNameTextInput() {
  return TextInputField(
      hintText: hint_last_name,
      onChanged: (value) {},
      inputType: TextInputType.name,
      inputAction: TextInputAction.next);
}

Widget _emailTextInput() {
  return TextInputField(
      hintText: hint_star_email_address,
      onChanged: (value) {},
      inputType: TextInputType.emailAddress,
      inputAction: TextInputAction.next);
}

Widget _mobileNumberTextInput() {
  return TextInputField(
      hintText: hint_mobile_number,
      onChanged: (value) {},
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
