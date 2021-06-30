import 'package:flutter/material.dart';
import 'package:flutter_demo_app/utils/AppColors.dart';

class CircularProgressbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator(color: COLOR_PRIMARY));
  }
}
