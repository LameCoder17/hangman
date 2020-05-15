import 'package:flutter/material.dart';
import 'skeleton.dart';
import 'puzzle.dart';
import 'guess_letters.dart';
import 'logic.dart';
import 'enums.dart';

class GameStage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GameStage();
  }
}

class _GameStage extends State<GameStage> {
  GameStageBloc _gameStageBloc;

  @override
  void initState() {
    super.initState();
    _gameStageBloc = GameStageBloc();
  }

  @override
  void dispose() {
    _gameStageBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQd = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Hangman'),
        leading: IconButton(icon:
        Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(24.0),
          width: mediaQd.width,
          height: mediaQd.height,
          child: Column(
            children: <Widget>[
              Container(
                width: 270,
                height: mediaQd.height/2.5,
                child: CustomPaint(
                  painter: HangingFrameAndNoose(_gameStageBloc),
                  size: Size(
                    (270 - 24.0),
                    (mediaQd.height - 24.0),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                    child: ValueListenableBuilder(
                      valueListenable: _gameStageBloc.curGuessWord,
                      builder: (BuildContext context, String guessWord, Widget child) {
                        if (guessWord == null || guessWord == '') {
                          return Center(
                              child: RaisedButton(
                                child: Text('Begin'),
                                onPressed: () {
                                  _gameStageBloc.createNewGame();
                                },
                              ));
                        }

                        return ValueListenableBuilder(
                            valueListenable: _gameStageBloc.curGameState,
                            builder: (BuildContext context, GameState gameState,
                                Widget child) {
                              if (gameState == GameState.succeded) {
                                return Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text('Well done! You got the right answer.',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24.0)),
                                      RaisedButton(
                                        child: Text('Play Again'),
                                        onPressed: () {
                                          _gameStageBloc.createNewGame();
                                        },
                                      ),
                                      RaisedButton(
                                        child: Text('Exit'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ]);
                              }

                              if (gameState == GameState.failed) {
                                return Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text('Oops you failed!',
                                          style: TextStyle(
                                             color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24.0)),
                                      RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: 'The correct word was: ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 24.0)),
                                          TextSpan(
                                              text:
                                              _gameStageBloc.curGuessWord.value,
                                              style: TextStyle(
                                                   color: Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 24.0))
                                        ]),
                                      ),
                                      RaisedButton(
                                        child: Text('Try Again'),
                                        onPressed: () {
                                          _gameStageBloc.createNewGame();
                                        },
                                      ),
                                      RaisedButton(
                                        child: Text('Exit'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ]);
                              }

                              return Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Guess the correct word...',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.restore,
                                          color: Colors.black,
                                          size: 24.0,
                                        ),
                                        onPressed: () {
                                          _gameStageBloc.createNewGame();
                                        },
                                      ),
                                    ],
                                  ),
                                  Puzzle(
                                    guessWord: guessWord,
                                    gameStageBloc: _gameStageBloc,
                                  ),
                                  CharacterPicker(
                                    gameStageBloc: _gameStageBloc,
                                  ),
                                ],
                              );
                            });
                      },
                    )),
              )
            ],
          )),
    );
  }
}
