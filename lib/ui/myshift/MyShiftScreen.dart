import 'package:flutter/material.dart';
import 'package:flutter_demo_app/ui/home/HomeScreen.dart';
import 'package:flutter_demo_app/ui/myshift/future/FutureScreen.dart';
import 'package:flutter_demo_app/ui/myshift/myavails/MyAvailsScreen.dart';
import 'package:flutter_demo_app/ui/myshift/myavails/addavails/AddAvailsScreen.dart';
import 'package:flutter_demo_app/ui/myshift/myleave/MyLeaveScreen.dart';
import 'package:flutter_demo_app/ui/myshift/myleave/addleave/AddLeaveScreen.dart';
import 'package:flutter_demo_app/ui/myshift/myswaps/MySwapsScreen.dart';
import 'package:flutter_demo_app/ui/myshift/today/TodayScreen.dart';
import 'package:flutter_demo_app/utils/UtilsLibrary.dart';
import 'package:flutter_demo_app/widget/WidgetLibrary.dart';

class MyShiftScreen extends StatefulWidget {
  @override
  State createState() => _MyShiftScreen();
}

class _MyShiftScreen extends State<MyShiftScreen> {
  int selectedIndex = 0;

  void onTabChange(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, kToolbarHeight),
          child: _appbar() // StreamBuilder
          ),
      body: _tabView(),
    );
  }

  Widget _appbar() {
    return AppbarWithoutTab(
      title: label_my_shift,
      onTap: () => HomeScreen.showSettingsDialog(),
      actions: [
        if (selectedIndex == 3)
          addMenuIconItem(
              iconData: Icons.add,
              onTap: () {
                Navigator.push(
                    context, SlideRightRoute(page: AddAvailsScreen()));
              }),
        if (selectedIndex == 4)
          addMenuIconItem(iconData: Icons.filter_list_outlined, onTap: () {}),
        if (selectedIndex == 4)
          addMenuIconItem(
              iconData: Icons.add,
              onTap: () {
                Navigator.push(
                    context, SlideRightRoute(page: AddLeaveScreen()));
              })
      ],
    );
  }

  Widget _tabView() {
    return TabView(
        tabs: [
          Tab(text: label_today),
          Tab(text: label_future),
          Tab(text: label_swaps),
          Tab(text: label_avails),
          Tab(text: label_leave)
        ],
        onTap: (index) {
          onTabChange(index);
        },
        isScrollable: true,
        body: TabBarView(children: [
          TodayScreen(),
          FutureScreen(),
          MySwapsScreen(),
          MyAvailsScreen(),
          MyLeaveScreen(),
        ]));
  }
}
