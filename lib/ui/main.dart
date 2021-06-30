import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo_app/data/preference/Prefs.dart';
import 'package:flutter_demo_app/ui/home/HomeScreen.dart';
import 'package:flutter_demo_app/utils/UtilsLibrary.dart';

import 'login/LoginScreen.dart';

void main() async {
  //Status bar color
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: COLOR_PRIMARY_DARK));

  //Fix for rotation
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // Run app!
  runApp(RosterElfApp(isUserLoggedIn: await Prefs.isUserLoggedIn));
}

class RosterElfApp extends StatelessWidget {
  final bool isUserLoggedIn;

  const RosterElfApp({Key? key, required this.isUserLoggedIn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (DevicePreview(
        enabled: false,
        builder: (context) => MaterialApp(
            //hide debug banner
            debugShowCheckedModeBanner: false,
            theme: appTheme(),
            title: label_appName,
            home: isUserLoggedIn ? HomeScreen() : LoginScreen())));
  }
}
