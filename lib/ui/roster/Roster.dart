import 'package:flutter/material.dart';
import 'package:flutter_demo_app/ui/home/HomeScreen.dart';
import 'package:flutter_demo_app/utils/UtilsLibrary.dart';
import 'package:flutter_demo_app/widget/WidgetLibrary.dart';

class RosterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppbarWithoutTab(
        title: label_roster,
        onTap: () {
          HomeScreen.showSettingsDialog();
        },
        actions: [
          addMenuIconItem(iconData: Icons.today_sharp, onTap: () {}),
          addMenuIconItem(iconData: Icons.filter_list_outlined, onTap: () {}),
          addMenuIconItem(iconData: Icons.add, onTap: () {}),
        ]);
  }
}
