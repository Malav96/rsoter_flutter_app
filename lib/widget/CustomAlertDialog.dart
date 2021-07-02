import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_app/utils/UtilsLibrary.dart';
import 'package:flutter_demo_app/widget/Constants.dart';

class CustomDialogBox extends StatelessWidget {
  final String title, descriptions, actionButtonText, cancelButtonText;
  final VoidCallback onPressed;

  const CustomDialogBox(
      {required this.title,
      required this.descriptions,
      required this.actionButtonText,
      required this.cancelButtonText,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: COLOR_PRIMARY,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        width: double.maxFinite,
        height: 56,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: COLOR_WHITE),
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                descriptions,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
            Divider(height: 1, color: COLOR_GREY),
            Container(
              width: double.maxFinite,
              child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onPressed();
                  },
                  child: Text(actionButtonText,
                      style: TextStyle(color: Colors.red))),
            ),
            Divider(height: 1, color: COLOR_GREY),
            Container(
              width: double.maxFinite,
              child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(cancelButtonText,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: COLOR_PRIMARY))),
            )
          ],
        ),
      )
    ]);
  }
}
