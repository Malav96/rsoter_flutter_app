import 'package:flutter/material.dart';
import 'package:flutter_demo_app/utils/UtilsLibrary.dart';

class NormalButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final VoidCallback onClicked;
  final double? screenWidth;

  NormalButton(
      {required this.buttonText,
      required this.onClicked,
      this.buttonColor = COLOR_PRIMARY,
      this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth ?? SizeConfig.screenWidth * 0.8,
      height: 40,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: buttonColor, elevation: 0),
          onPressed: onClicked,
          child: Text(buttonText)),
    );
  }
}
