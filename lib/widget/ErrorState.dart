import 'package:flutter/material.dart';
import 'package:flutter_demo_app/utils/UtilsLibrary.dart';
import 'package:flutter_demo_app/widget/NormalButton.dart';

class ErrorView extends StatelessWidget {
  final String errorTitle;
  final String errorMessage;
  final String buttonText;
  final VoidCallback onClicked;
  final IconData icon;

  const ErrorView(
      {required this.errorTitle,
      required this.errorMessage,
      required this.buttonText,
      required this.onClicked,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 144,
            color: COLOR_GREY,
          ),
          if (errorTitle.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: Text(errorTitle,
                  style: Theme.of(context).textTheme.title,
                  textAlign: TextAlign.center),
            ),
          SizedBox(height: 4),
          if (errorMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: Text(errorMessage,
                  style: Theme.of(context).textTheme.body1,
                  textAlign: TextAlign.center),
            ),
          SizedBox(height: 12),
          NormalButton(
            buttonText: buttonText,
            onClicked: onClicked,
            screenWidth: SizeConfig.screenWidth * 0.5,
          )
        ],
      ),
    );
  }
}
