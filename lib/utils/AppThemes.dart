import 'package:flutter/material.dart';

import 'UtilsLibrary.dart';

ThemeData appTheme() {
  TextTheme _basicTextTheme(TextTheme base) {
    return base.copyWith(
      headline5: base.headline5?.copyWith(color: Colors.white),
      caption: base.caption?.copyWith(color: Colors.white),
    );
  }

  final ThemeData base = ThemeData.light();
  return base.copyWith(
      platform: TargetPlatform.android,
      primaryColor: COLOR_PRIMARY,
      scaffoldBackgroundColor: COLOR_WHITE,
      appBarTheme: AppBarTheme(
        brightness: Brightness.dark,
        elevation: 0,
        backgroundColor: COLOR_PRIMARY,
      ),
      textTheme: _basicTextTheme(base.textTheme));
}
