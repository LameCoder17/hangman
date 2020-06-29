import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

exitDialog(BuildContext context) {
  Widget cancelButton = FlatButton(
    child: Text(
        "No",
        style: TextStyle(color: Color(0xFF72CDf4))
    ),
    onPressed:  () {
      Navigator.of(context).pop();
    },
  );
  Widget okButton = FlatButton(
    child: Text(
        "Yes",
        style: TextStyle(color: Color(0xFF72CDf4))
    ),
    onPressed: () {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
        "Quit",
        style: TextStyle(color: Color(0xFF72CDf4))
    ),
    backgroundColor: Color(0xFF173F5F),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.00)
    ),
    content: Text(
        "Are you sure you want to exit ?",
        style: TextStyle(color: Color(0xFF72CDf4))
    ),
    actions: [
      cancelButton,
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return alert;
    },
  );
}