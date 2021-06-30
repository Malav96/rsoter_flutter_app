import 'package:flutter/material.dart';
import 'package:flutter_demo_app/utils/UtilsLibrary.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

class SearchView extends StatefulWidget {
  final String title;
  final GestureTapCallback onTap;
  final TextFieldChangeCallback onChanged;
  final VoidCallback onClosed;
  final VoidCallback onCleared;
  final List<Widget>? actions;

  SearchView(
      {required this.title,
      required this.onTap,
      required this.onChanged,
      required this.onClosed,
      required this.onCleared,
      required this.actions});

  @override
  State createState() => SearchBarDemoHomeState();
}

class SearchBarDemoHomeState extends State<SearchView> {
  late SearchBar searchBar;

  SearchBarDemoHomeState() {
    searchBar = SearchBar(
        inBar: false,
        buildDefaultAppBar: buildAppBar,
        hintText: hint_search_by_name,
        setState: setState,
        onChanged: (value) {
          widget.onChanged(value);
        },
        onClosed: () {
          widget.onClosed();
        },
        onCleared: () {
          widget.onCleared();
        });
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      centerTitle: true,
      leading: GestureDetector(
          onTap: () => widget.onTap(),
          child: Image.asset(
            IC_TOOLBAR_LOGO,
            scale: 3.0,
          )),
      actions: [searchBar.getSearchAction(context)]
        ..addAll(widget.actions ?? []),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: COLOR_VIEW_BACKGROUND,
        appBar: searchBar.build(context));
  }
}
