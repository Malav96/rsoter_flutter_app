import 'package:flutter/material.dart';
import 'package:flutter_demo_app/utils/UtilsLibrary.dart';

class TextInputField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool obscureText;
  final Color textInputBackgroundColor;
  final String? initialValue;
  final VoidCallback? onClicked;

  const TextInputField(
      {Key? key,
      required this.hintText,
      required this.onChanged,
      required this.inputType,
      required this.inputAction,
      this.obscureText = false,
      this.textInputBackgroundColor = COLOR_WHITE,
      this.initialValue,
      this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.8,
      height: 48,
      decoration: BoxDecoration(
          color: textInputBackgroundColor,
          border: Border.all(color: COLOR_GREY, width: 0.5)),
      child: TextFormField(
          onTap: () {
            onClicked!();
          },
          onChanged: onChanged,
          initialValue: initialValue,
          cursorColor: COLOR_PRIMARY,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
          ),
          keyboardType: inputType,
          textInputAction: inputAction,
          obscureText: obscureText),
    );
  }
}
