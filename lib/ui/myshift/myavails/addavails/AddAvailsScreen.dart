import 'package:flutter/material.dart';
import 'package:flutter_demo_app/utils/UtilsLibrary.dart';
import 'package:flutter_demo_app/widget/WidgetLibrary.dart';

class AddAvailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(label_add_availability),
        actions: [
          addMenuTextItem(
              context: context, menuItemText: button_save, onTap: () {})
        ],
      ),
    );
  }
}
