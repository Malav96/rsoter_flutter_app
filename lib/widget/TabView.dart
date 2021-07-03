import 'package:flutter/material.dart';
import 'package:flutter_demo_app/utils/UtilsLibrary.dart';

class TabView extends StatelessWidget {
  final List<Widget> tabs;
  final Widget? body;
  final bool isScrollable;
  final ValueChanged<int> onTap;

  const TabView(
      {required this.tabs,
      required this.body,
      this.isScrollable = false,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
          backgroundColor: COLOR_VIEW_BACKGROUND,
          appBar: AppBar(
              toolbarHeight: kMinInteractiveDimension,
              bottom: TabBar(
                onTap: (index) {
                  onTap(index);
                },
                indicatorColor: COLOR_WHITE,
                isScrollable: isScrollable,
                tabs: tabs,
              )),
          body: body),
    );
  }
}
