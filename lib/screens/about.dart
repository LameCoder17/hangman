import 'package:flutter/material.dart';

aboutDialog(BuildContext context) {

  AlertDialog alert = AlertDialog(
    title: Text("About"),
    content: Text("Created By Shalom using Flutter"),
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}