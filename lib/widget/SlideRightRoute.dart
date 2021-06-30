
import 'package:flutter/material.dart';

class SlideRightRoute extends PageRouteBuilder {

  final Widget page;
  SlideRightRoute({required this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionDuration: Duration(milliseconds: 500),
    transitionsBuilder:
        (context, animation, anotherAnimation, child) {
      animation = CurvedAnimation(
          curve: Curves.easeInOut, parent: animation);
      return  SlideTransition(
        position: Tween(
            begin: Offset(1.0, 0.0),
            end: Offset(0.0, 0.0))
            .animate(animation),
        child: child,
      );
    }
  );
}