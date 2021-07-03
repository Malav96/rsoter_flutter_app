import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo_app/data/preference/Prefs.dart';
import 'package:flutter_demo_app/ui/dashboard/DashboardScreen.dart';
import 'package:flutter_demo_app/ui/home/HomeBloc.dart';
import 'package:flutter_demo_app/ui/login/LoginScreen.dart';
import 'package:flutter_demo_app/ui/myinfo/MyInfoScreen.dart';
import 'package:flutter_demo_app/ui/myshift/MyShiftScreen.dart';
import 'package:flutter_demo_app/ui/roster/Roster.dart';
import 'package:flutter_demo_app/ui/staff/StaffScreen.dart';
import 'package:flutter_demo_app/utils/UtilsLibrary.dart';
import 'package:flutter_demo_app/widget/WidgetLibrary.dart';
import 'package:package_info/package_info.dart';

import 'HomeUIStates.dart';

class HomeScreen extends StatelessWidget {
  static late BuildContext _buildContext;
  static late HomeBloc _homeBloc;

  @override
  Widget build(BuildContext context) {
    HomeScreen._buildContext = context;
    SizeConfig().init(context);
    return BlocProvider<HomeBloc>(
        create: (BuildContext context) {
          _homeBloc = HomeBloc();
          return _homeBloc;
        },
        child: Scaffold(
          body: _body(),
          bottomNavigationBar: _bottomNavigationBar(),
        ));
  }

  Widget _body() {
    final List<Widget> _children = [
      DashboardScreen(),
      MyShiftScreen(),
      StaffScreen(),
      RosterScreen()
    ];
    return BlocBuilder<HomeBloc, HomeUIStates>(
      builder: (context, state) {
        if (state is ShowSelectedBottomMenu) {
          return IndexedStack(
            children: _children,
            index: state.selectedIndex,
          );
        } else {
          return IndexedStack(
            children: _children,
            index: 0,
          );
        }
      },
    );
  }

  Widget _bottomNavigationBar() {
    return BlocBuilder<HomeBloc, HomeUIStates>(builder: (context, state) {
      return BottomNavigationBar(
        backgroundColor: COLOR_WHITE,
        currentIndex: context.select((HomeBloc bloc) => bloc.selectedIndex),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: COLOR_PRIMARY,
        unselectedItemColor: COLOR_GREY,
        type: BottomNavigationBarType.fixed,
        items: bottomNavigationBarItem,
        onTap: (index) => _homeBloc.onBottomMenuItemClick(index),
      );
    });
  }

  static void showSettingsDialog() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      showDialog(
          context: _buildContext,
          builder: (BuildContext context) {
            return SettingsDialog(
                appVersionInfo:
                    '${packageInfo.version} (${packageInfo.buildNumber})',
                dialogTitle: label_settings,
                children: [
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context, SlideRightRoute(page: MyInfoScreen()));
                    },
                    child: const Text(label_my_info),
                  ),
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context);
                      showLogoutAlertDialog();
                    },
                    child: const Text(label_logout),
                  )
                ]);
          });
    });
  }

  static void showLogoutAlertDialog() {
    showDialog(
      context: _buildContext,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.fromLTRB(24, 16, 24, 0),
          content: const Text(msg_logout),
          actions: <Widget>[
            TextButton(
              child: const Text(button_cancel,
                  style: TextStyle(color: COLOR_PRIMARY)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text(button_logout,
                  style: TextStyle(color: COLOR_PRIMARY)),
              onPressed: () {
                Prefs.clear();
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  SlideRightRoute(page: LoginScreen()),
                  (route) => false,
                );
              },
            )
          ],
        );
      },
    );
  }
}
