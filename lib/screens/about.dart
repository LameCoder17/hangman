import 'package:flutter/material.dart';

aboutDialog(BuildContext context) {
  Widget license = FlatButton(
    child: Text('Licenses',
      style: TextStyle(color: Color(0xFF72CDf4)),
    ),
    onPressed: (){
      showLicensePage(
          context: context,
          applicationName: 'Hangman - The Game',
        applicationVersion: '1.1'
      );
    },
  );
  Widget close = FlatButton(
    child: Text('Close',
      style: TextStyle(color: Color(0xFF72CDf4)),
    ),
    onPressed: (){
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text(
        "About",
      style: TextStyle(color: Color(0xFF72CDf4)),
    ),
    backgroundColor: Color(0xFF173F5F),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.00)
    ),
    content: Text(
        "Hangman - The Game\n"
            "Version 1.1\n\n"
            "Created By Shalom",
      style: TextStyle(color: Color(0xFF72CDf4)),
    ),
    actions: <Widget>[
      license,
      close
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}