import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_app/utils/UtilsLibrary.dart';

showProgressDialog(BuildContext context,
    [String message = msg_please_wait_moment]) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        CircularProgressIndicator(color: COLOR_PRIMARY, strokeWidth: 3),
        Container(
            margin: EdgeInsets.only(left: 16),
            child: Text(
              message,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600),
            )),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showSuccessMessageAlertDialog(
    {required BuildContext buildContext,
    required String message,
    required Function onButtonClicked}) {
  showDialog(
    barrierDismissible: false,
    context: buildContext,
    builder: (BuildContext context) => AlertDialog(
      content: Text(message),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              onButtonClicked();
            },
            child: Text(button_ok, style: TextStyle(color: COLOR_PRIMARY))),
      ],
    ),
  );
}

SnackBar displaySnackBar(
    {required String message, required SnackBarAction? snackBarAction}) {
  return SnackBar(
    duration: Duration(minutes: 5),
    content: Text(message),
    action: snackBarAction,
  );
}

Widget addMenuIconItem({required IconData iconData, required Function onTap}) {
  return Padding(
      padding: EdgeInsets.only(right: 16.0),
      child: GestureDetector(
        onTap: () => {onTap()},
        child: Icon(iconData),
      ));
}

Widget addMenuTextItem(
    {required BuildContext context,
    required String menuItemText,
    required Function onTap}) {
  var textTheme = Theme.of(context).textTheme;
  return Center(
    child: GestureDetector(
      onTap: () => {onTap()},
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
            child: Text(menuItemText,
                style: textTheme.subtitle1?.merge(TextStyle(
                    fontWeight: FontWeight.bold, color: COLOR_WHITE)))),
      ),
    ),
  );
}
