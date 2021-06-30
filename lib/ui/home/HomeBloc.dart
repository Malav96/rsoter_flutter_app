import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo_app/ui/home/HomeUIStates.dart';
import 'package:flutter_demo_app/utils/UtilsLibrary.dart';

class HomeBloc extends Cubit<HomeUIStates> {
  HomeBloc() : super(ShowSelectedBottomMenu(0, label_dashboard));

  List<String> toolbarTitle = [
    label_dashboard,
    label_my_shift,
    label_staff,
    label_roster
  ];

  int selectedIndex = 0;

  void onBottomMenuItemClick(int selectedIndex) {
    this.selectedIndex = selectedIndex;
    emit(ShowSelectedBottomMenu(selectedIndex, toolbarTitle[selectedIndex]));
  }
}
