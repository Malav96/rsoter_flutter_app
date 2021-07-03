import 'package:flutter/material.dart';
import 'package:flutter_demo_app/ui/myinfo/changepassword/ChangePasswordScreen.dart';
import 'package:flutter_demo_app/ui/myinfo/editprofile/EditProfileScreen.dart';
import 'package:flutter_demo_app/utils/UtilsLibrary.dart';
import 'package:flutter_demo_app/widget/CommonWidget.dart';
import 'package:flutter_demo_app/widget/WidgetLibrary.dart';

class MyInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(label_my_info),
        actions: [
          addMenuIconItem(
              iconData: Icons.lock,
              onTap: () {
                Navigator.push(
                    context, SlideRightRoute(page: ChangePasswordScreen()));
              }),
          addMenuIconItem(
              iconData: Icons.edit,
              onTap: () {
                Navigator.push(
                    context, SlideRightRoute(page: EditProfileScreen()));
              })
        ],
      ),
    );
  }
}
