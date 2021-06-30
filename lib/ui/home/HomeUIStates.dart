import 'package:flutter_demo_app/utils/UtilsLibrary.dart';

class HomeUIStates {}

class ShowSelectedBottomMenu extends HomeUIStates {
  int selectedIndex = 0;
  String selectedAppbarTitle = label_dashboard;

  ShowSelectedBottomMenu(this.selectedIndex, this.selectedAppbarTitle);
}
