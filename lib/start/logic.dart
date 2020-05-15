import 'package:flutter/widgets.dart';
import 'package:hangman/model/theWords.dart';
import 'package:hangman/start/words.dart';
import 'package:hangman/utils/database_helper.dart';
import 'package:rxdart/rxdart.dart';
import 'enums.dart';

class GameStageBloc {
  ValueNotifier<GameState> curGameState =
      ValueNotifier<GameState>(GameState.idle);
  ValueNotifier<String> curGuessWord = ValueNotifier<String>('');
  ValueNotifier<List<BodyPart>> lostParts = ValueNotifier<List<BodyPart>>([]);
  var _guessedCharactersController = BehaviorSubject<List<String>>();
  Stream<List<String>> get guessedCharacters =>
      _guessedCharactersController.stream;

  void createNewGame() {
    //generateWords();
    curGameState.value = GameState.running;
    lostParts.value.clear();
    var guessWord = GuessWordHelper().generateRandomWord();
    print(guessWord);
    curGuessWord.value = guessWord;
    _guessedCharactersController.sink.add([]);
  }

  void updateGuessedCharacter(List<String> updatedGuessedCharacters) {
    _guessedCharactersController.sink.add(updatedGuessedCharacters);
    _concludeGameOnWordGuessedCorrectly(updatedGuessedCharacters);
  }

  void _concludeGameOnWordGuessedCorrectly(List<String> guessedCharacters) {
    //check if user identified all correct words
    var allValuesIdentified = true;
    var characters = curGuessWord.value.split('');
    characters.forEach((letter) {
      if (!guessedCharacters.contains(letter)) {
        allValuesIdentified = false;
        return;
      }
    });

    if (allValuesIdentified) {
      curGameState.value = GameState.succeded;
    }
  }

  void updateLostBodyParts() {
    print('removing ');
    if (!lostParts.value.contains(BodyPart.head)) {
      print('head...');
      lostParts.value.add(BodyPart.head);
      return;
    }

    if (!lostParts.value.contains(BodyPart.body)) {
      print('body...');
      lostParts.value.add(BodyPart.body);
      return;
    }

    if (!lostParts.value.contains(BodyPart.leftLeg)) {
      print('left leg...');
      lostParts.value.add(BodyPart.leftLeg);
      return;
    }

    if (!lostParts.value.contains(BodyPart.rightLeg)) {
      print('right leg...');
      lostParts.value.add(BodyPart.rightLeg);
      return;
    }

    if (!lostParts.value.contains(BodyPart.leftHand)) {
      print('left hand...');
      lostParts.value.add(BodyPart.leftHand);
      return;
    }

    if (!lostParts.value.contains(BodyPart.rightHand)) {
      print('right hand...');
      lostParts.value.add(BodyPart.rightHand);

      // player has lost all body parts.
      curGameState.value = GameState.failed;
      return;
    }
  }

  dispose() {
    _guessedCharactersController.close();
  }
/*
  Future<void> generateWords() async {
    List<Map<String, dynamic>> _results = await DB.query(Words.table);
    List<Words> _listOfWords =
        _results.map((item) => Words.fromMap(item)).toList();
    for (Words i in _listOfWords) {
      _validWords.add(i.word);
    }
  }
  */
}
