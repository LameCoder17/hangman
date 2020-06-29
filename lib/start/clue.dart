import 'dart:math';
import 'package:flutter/material.dart';
import 'words.dart';
import 'logic.dart';

clueDialog(BuildContext context) {
  Widget goBack = FlatButton(
    child: Text('Go Back',
      style: TextStyle(color: Color(0xFF72CDf4)),
    ),
    onPressed: (){
      Navigator.of(context).pop();
    },
  );

  AlertDialog clue = AlertDialog(
    title: Text(
      "Hint",
      style: TextStyle(color: Color(0xFF72CDf4)),
    ),
    backgroundColor: Color(0xFF173F5F),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.00)
    ),
    content: retGuessWord(),
    actions: <Widget>[
      goBack
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return clue;
    },
  );
}

Text retGuessWord(){
  /*
  List<String> z = GameStageBloc.alreadyGuessedCharacters;
  print('This is the list $z');
  String word = GuessWordHelper.previousWord;
  print(word);
  String x;
  */
  String x = retLetter(GameStageBloc.alreadyGuessedCharacters, GuessWordHelper.previousWord);
  while(x == null){
    x = retLetter(GameStageBloc.alreadyGuessedCharacters, GuessWordHelper.previousWord);
  }
  print(x);
  return Text(
    "Try $x",
    style: TextStyle(color: Color(0xFF72CDf4)),
  );
}

String retLetter(List<String> alreadyGuessedCharacters, String currentWord){
  String x;
  var randomGenerator = Random();
  var randomIndex = randomGenerator.nextInt(currentWord.length);
  x = currentWord[randomIndex].toUpperCase();
  if(alreadyGuessedCharacters.contains(x)){
    retLetter(alreadyGuessedCharacters, currentWord);
  }
  else {
    print("THis is $x");
    return x;
  }
}