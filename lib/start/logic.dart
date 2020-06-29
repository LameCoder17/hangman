import 'package:flutter/widgets.dart';
import 'package:hangman/start/words.dart';
import 'package:rxdart/rxdart.dart';
import 'enums.dart';

class GameStageBloc {
  ValueNotifier<GameState> curGameState = ValueNotifier<GameState>(GameState.idle);
  ValueNotifier<String> curGuessWord = ValueNotifier<String>('');
  ValueNotifier<List<BodyPart>> lostParts = ValueNotifier<List<BodyPart>>([]);
  var guessedCharactersController = BehaviorSubject<List<String>>();
  Stream<List<String>> get guessedCharacters => guessedCharactersController.stream;
  static List<String> alreadyGuessedCharacters = [];

  void createNewGame() {
    curGameState.value = GameState.running;
    lostParts.value.clear();
    var guessWord = GuessWordHelper().generateRandomWord();
    print(guessWord);
    curGuessWord.value = guessWord;
    alreadyGuessedCharacters.clear();
    guessedCharactersController.sink.add([]);
  }

  void updateGuessedCharacter(List<String> updatedGuessedCharacters) {
    guessedCharactersController.sink.add(updatedGuessedCharacters);
    guessed(updatedGuessedCharacters);
    print(updatedGuessedCharacters);
    _concludeGameOnWordGuessedCorrectly(updatedGuessedCharacters);
  }

  void _concludeGameOnWordGuessedCorrectly(List<String> guessedCharacters) {
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
    guessedCharactersController.close();
  }

  void guessed(List<String> characters){
    for(String s in characters){
      if(alreadyGuessedCharacters.contains(s)){
        continue;
      }
      else{
        alreadyGuessedCharacters.add(s);
      }
    }
  }
}


