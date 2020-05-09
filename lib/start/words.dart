import 'dart:math';

class GuessWordHelper {
  var _allowedWords = [
    'INDIA',
    'CHINA',
    'PAKISTHAN',
    'BANGLADESH',
    'BRAZIL'
  ];

  String generateRandomWord() {
    var randomGenerator = Random();
    var randomIndex = randomGenerator.nextInt(_allowedWords.length);
    return _allowedWords[randomIndex].toUpperCase();
  }
}