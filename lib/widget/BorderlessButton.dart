import 'package:flutter/material.dart';
import 'package:flutter_demo_app/utils/UtilsLibrary.dart';

class BorderlessButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onClicked;

  const BorderlessButton({required this.buttonText, required this.onClicked});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth * 0.5,
      height: 40,
      child: TextButton(
          onPressed: onClicked,
          child:
              Text(buttonText, style: TextStyle(color: COLOR_WHITE))),
    );
  }
}
