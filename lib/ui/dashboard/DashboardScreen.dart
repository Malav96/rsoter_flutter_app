import 'package:flutter/material.dart';
import 'package:flutter_demo_app/ui/dashboard/avails/AvailsScreen.dart';
import 'package:flutter_demo_app/ui/dashboard/leave/LeaveScreen.dart';
import 'package:flutter_demo_app/ui/dashboard/swaps/SwapsScreen.dart';
import 'package:flutter_demo_app/ui/dashboard/trends/TrendsChartScreen.dart';
import 'package:flutter_demo_app/ui/home/HomeScreen.dart';
import 'package:flutter_demo_app/utils/UtilsLibrary.dart';
import 'package:flutter_demo_app/widget/TabView.dart';
import 'package:flutter_demo_app/widget/WidgetLibrary.dart';

class DashboardScreen extends StatelessWidget {
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
      title: label_dashboard,
      onTap: () => HomeScreen.showSettingsDialog(),
      actions: null,
    );
  }

  Widget _tabView() {
    return TabView(
        tabs: [
          Tab(text: label_trends),
          Tab(text: label_swaps),
          Tab(text: label_leave),
          Tab(text: label_avails),
        ],
        isScrollable: false,
        onTap: (index) {},
        body: TabBarView(children: [
          TrendsChartScreen(),
          SwapsScreen(),
          LeaveScreen(),
          AvailsScreen()
        ]));
  }
}
