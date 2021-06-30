import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo_app/ui/dashboard/DashboardScreen.dart';
import 'package:flutter_demo_app/ui/home/HomeBloc.dart';
import 'package:flutter_demo_app/ui/myshift/MyShiftScreen.dart';
import 'package:flutter_demo_app/ui/roster/Roster.dart';
import 'package:flutter_demo_app/ui/staff/StaffScreen.dart';
import 'package:flutter_demo_app/ui/staff/addoredit/AddOrEditStaffScreen.dart';
import 'package:flutter_demo_app/utils/UtilsLibrary.dart';
import 'package:flutter_demo_app/widget/WidgetLibrary.dart';

import 'HomeUIStates.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider<HomeBloc>(
        create: (BuildContext context) => HomeBloc(),
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size(double.infinity, kToolbarHeight),
              child: _appbar() // StreamBuilder
              ),
          body: _body(),
          bottomNavigationBar: _bottomNavigationBar(),
        ));
  }
}

Widget _appbar() {
  return BlocBuilder<HomeBloc, HomeUIStates>(builder: (context, state) {
    switch ((state as ShowSelectedBottomMenu).selectedIndex) {
      case 1:
        return _myShiftAppbar();
      case 2:
        return _staffAppbar(context);
      case 3:
        return _rosterAppbar();
      default:
        return _dashboardAppbar();
    }
  });
}

Widget _dashboardAppbar() {
  return AppbarWithoutTab(
    title: label_dashboard,
    onTap: () {},
    actions: [],
  );
}

Widget _myShiftAppbar() {
  return AppbarWithoutTab(
    title: label_my_shift,
    onTap: () {},
    actions: [],
  );
}

Widget _staffAppbar(BuildContext context) {
  return SearchView(
      title: label_staff,
      onTap: () {
        log('Logout');
      },
      actions: [
        addMenuIconItem(
            iconData: Icons.add,
            onTap: () {
              Navigator.push(
                  context,
                  SlideRightRoute(
                      page: AddOrEditStaffScreen(isAddStaff: true)));
            })
      ],
      onChanged: (String value) {
        StaffListScreen.searchByStaffList(value);
      },
      onCleared: () {
        StaffListScreen.searchByStaffList('');
      },
      onClosed: () {
        StaffListScreen.searchByStaffList('');
      });
}

Widget _rosterAppbar() {
  return AppbarWithoutTab(title: label_roster, onTap: () {}, actions: []);
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
      onTap: (index) {
        context.read<HomeBloc>().onBottomMenuItemClick(index);
      },
    );
  });
}
