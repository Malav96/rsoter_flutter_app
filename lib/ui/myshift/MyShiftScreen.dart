import 'package:flutter/material.dart';
import 'package:flutter_demo_app/utils/UtilsLibrary.dart';
import 'package:flutter_demo_app/widget/WidgetLibrary.dart';

class MyShiftScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabView(
        tabs: [
          Tab(text: label_today),
          Tab(text: label_future),
          Tab(text: label_swaps),
          Tab(text: label_avails),
          Tab(text: label_leave)
        ],
        isScrollable: true,
        body: TabBarView(children: [
          Icon(Icons.bar_chart, size: 350),
          Icon(Icons.swap_vert_rounded, size: 350),
          Icon(Icons.leave_bags_at_home, size: 350),
          Icon(Icons.event_available, size: 350),
          Icon(Icons.event_available, size: 350),
        ]));
  }
}
