import 'dart:math';
import 'package:hangman/model/theWords.dart';
import 'package:hangman/utils/database_helper.dart';

class GuessWordHelper {

  static List<String> _allowedWords = [];

  String generateRandomWord() {
    var randomGenerator = Random();
    var randomIndex = randomGenerator.nextInt(_allowedWords.length);
    return _allowedWords[randomIndex].toUpperCase();
  }

Future<void> generateWords() async {
    _allowedWords.clear();
  List<Map<String, dynamic>> _results = await DB.query(Words.table);
  List<Words> _listOfWords =
  _results.map((item) => Words.fromMap(item)).toList();
  for (Words i in _listOfWords) {
    _allowedWords.add(i.word);
  }
  print(_allowedWords);
}}
