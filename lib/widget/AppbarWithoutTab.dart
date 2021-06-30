import 'package:flutter/material.dart';
import 'package:flutter_demo_app/utils/UtilsLibrary.dart';

class AppbarWithoutTab extends StatelessWidget {
  final String title;
  final GestureTapCallback? onTap;
  final List<Widget>? actions;

  const AppbarWithoutTab(
      {required this.title, required this.onTap, required this.actions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR_VIEW_BACKGROUND,
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        leading: GestureDetector(
            onTap: () => onTap,
            child: Image.asset(
              IC_TOOLBAR_LOGO,
              scale: 3.0,
            )),
        actions: actions,
      ),
    );
  }
}
