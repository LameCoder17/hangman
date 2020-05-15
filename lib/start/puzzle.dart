import 'package:flutter/material.dart';
import 'logic.dart';

class Puzzle extends StatefulWidget {
  final String guessWord;

  final GameStageBloc gameStageBloc;

  const Puzzle(
      {Key key, @required this.guessWord, @required this.gameStageBloc})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PuzzleState();
}

class _PuzzleState extends State<Puzzle> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.gameStageBloc.guessedCharacters,
        builder: (BuildContext context,
            AsyncSnapshot<List<String>> guessedLettersSnap) {
          if (!guessedLettersSnap.hasData) return CircularProgressIndicator();

          return Container(
              child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: List.generate(widget.guessWord.length, (i) {
                    var letter = widget.guessWord[i];
                    var letterGuessedCorrectly = guessedLettersSnap.data.contains(letter);

                      return _buildSingleCharacterBox(
                          letter, letterGuessedCorrectly);
                  })));
        });
  }

  Widget _buildSingleCharacterBox(String letter, bool letterGuessedCorrectly) {
    return Container(
      height: 42.0,
      width: 42.0,
      decoration: BoxDecoration(
          color: letterGuessedCorrectly ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: Colors.black, width: 3)
      ),
      child: letterGuessedCorrectly
          ? Center(
        child: Text(
          letter,
          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold,),
          textAlign: TextAlign.center,
        ),
      )
          : null,
    );
  }
}