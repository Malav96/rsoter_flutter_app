import 'package:flutter/material.dart';

class FullScreenBackground extends StatelessWidget {
  final String asstImage;
  final Widget childWidget;

  const FullScreenBackground(
      {required this.asstImage, required this.childWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(asstImage), fit: BoxFit.cover),
      ),
      child: childWidget,
    );
  }
}
