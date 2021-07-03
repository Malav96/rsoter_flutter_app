import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_app/utils/UtilsLibrary.dart';

class SettingsDialog extends StatelessWidget {
  final String dialogTitle;
  final List<Widget>? children;
  final String appVersionInfo;

  const SettingsDialog(
      {required this.dialogTitle,
      required this.children,
      required this.appVersionInfo});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Center(
        child: Container(
      width: SizeConfig.screenWidth * 0.8,
      height: SizeConfig.screenWidth * 0.45,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16, top: 16),
            child: Text(appVersionInfo,
                textAlign: TextAlign.end,
                style: textTheme.subtitle2?.merge(TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black))),
          ),
          SimpleDialog(
            elevation: 0,
            insetPadding: EdgeInsets.zero,
            titlePadding: EdgeInsets.fromLTRB(24, 16, 0, 0),
            contentPadding: EdgeInsets.fromLTRB(4, 8, 0, 0),
            title: Text(label_settings),
            children: children,
          )
        ],
      ),
    ));
  }
}
