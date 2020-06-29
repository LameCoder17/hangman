import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hangman/screens/about.dart';
import 'package:hangman/screens/exit.dart';
import 'package:hangman/screens/word_list.dart';
import 'package:hangman/start/game_stage.dart';
import 'package:hangman/start/words.dart';
import 'package:hangman/utils/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.init();
  GuessWordHelper().generateWords();

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
      backgroundColor: Color(0xBF20639B),
        body: Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 270.00),
          child: Center(
            child: Text(
              'Hangman',
              style: TextStyle(color: Color(0xFF72CDf4)),
              textScaleFactor: 5,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 90.00),
          child: FlatButton(
            color: Color(0xFF173F5F),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.00),
                  side: BorderSide(
                      color: Color(0xFFF6D55C),
                      width: 2)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameStage()),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(
                    left: 40.00, right: 40.00, top: 10.00, bottom: 10.00),
                child: Text(
                  'Start',
                  style: TextStyle(color: Color(0xFF72CDf4)),
                  textScaleFactor: 2,
                ),
              )),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.00),
          child: FlatButton(
              color: Color(0xFF173F5F),
              onPressed: () => aboutDialog(context),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.00),
                  side: BorderSide(color: Color(0xFFF6D55C), width: 2)),
              child: Padding(
                padding: EdgeInsets.only(
                    left: 35.00, right: 35.00, top: 10.00, bottom: 10.00),
                child: Text(
                  'About',
                  style: TextStyle(color: Color(0xFF72CDf4)),
                  textScaleFactor: 2,
                ),
              )),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.00),
          child: FlatButton(
              color: Color(0xFF173F5F),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.00),
                  side: BorderSide(color: Color(0xFFF6D55C), width: 2)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WordList()),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(
                    left: 35.00, right: 35.00, top: 10.00, bottom: 10.00),
                child: Text(
                  'Words',
                  style: TextStyle(color: Color(0xFF72CDf4)),
                  textScaleFactor: 2,
                ),
              )),
        ),
        Padding(
          padding: EdgeInsets.all(20.00),
          child: FlatButton(
              color: Color(0xFF173F5F),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.00),
                  side: BorderSide(color: Color(0xFFF6D55C), width: 2)),
              onPressed: () => exitDialog(context),
              child: Padding(
                padding: EdgeInsets.only(
                    left: 50.00, right: 50.00, top: 10.00, bottom: 10.00),
                child: Text(
                  'Exit',
                  style: TextStyle(color: Color(0xFF72CDf4)),
                  textScaleFactor: 2,
                ),
              )),
        )
      ],
    ));
  }
}
