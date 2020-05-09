import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hangman/screens/about.dart';
import 'package:hangman/screens/exit.dart';
import 'package:hangman/start/game_stage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Hangman - The Game',
    home: MainPage(),
  ));
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
        children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 270.00),
          child: Center(
            child: Text(
              'Hangman',
              textScaleFactor: 5,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 90.00),
          child: FlatButton(
              child: Text(
                'Start',
                textScaleFactor: 2,
              ),
              onPressed: () {
                Navigator.push
                  (
                  context,
                  MaterialPageRoute(builder: (context) => GameStage()),
                );
              }),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.00),
          child: FlatButton(
            child: Text(
              'About',
              textScaleFactor: 2,
            ),
            onPressed: () => aboutDialog(context),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.00),
          child: FlatButton(
            child: Text(
              'Words',
              textScaleFactor: 2,
            ),
            onPressed: null,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20.00),
          child: FlatButton(
            child: Text(
              'Exit',
              textScaleFactor: 2,
            ),
            onPressed: () => exitDialog(context),
          ),
        )
      ],
    ));
  }
}
