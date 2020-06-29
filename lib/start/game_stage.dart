import 'package:flutter/material.dart';
import 'skeleton.dart';
import 'puzzle.dart';
import 'guess_letters.dart';
import 'logic.dart';
import 'enums.dart';
import 'clue.dart';

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
      backgroundColor: Color(0xBF20639B),
      appBar: AppBar(
        backgroundColor: Color(0xFF173F5F),
        title: Text('Hangman'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.lightbulb_outline,
              color: Colors.white,
            ),
            onPressed: () {
              clueDialog(context);
            },
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(24.0),
          width: mediaQd.width,
          height: mediaQd.height,
          child: Column(
            children: <Widget>[
              Container(
                width: 270,
                height: mediaQd.height / 2.5,
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
                  builder:
                      (BuildContext context, String guessWord, Widget child) {
                    if (guessWord == null || guessWord == '') {
                      return Center(
                        child: FlatButton(
                            color: Color(0xFF173F5F),
                            onPressed: () {
                              _gameStageBloc.createNewGame();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.00),
                                side: BorderSide(
                                    color: Color(0xFFF6D55C), width: 2)),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 30.00,
                                  right: 30.00,
                                  top: 10.00,
                                  bottom: 10.00),
                              child: Text(
                                'Begin',
                                style: TextStyle(color: Color(0xFF72CDf4)),
                                textScaleFactor: 1.8,
                              ),
                            )),
                      );
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
                                          color: Color(0xFF72CDf4),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24.0)),
                                  FlatButton(
                                      color: Color(0xFF173F5F),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.00),
                                          side: BorderSide(
                                              color: Color(0xFFF6D55C),
                                              width: 2)),
                                      onPressed: () {
                                        _gameStageBloc.createNewGame();
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 30.00,
                                            right: 30.00,
                                            top: 10.00,
                                            bottom: 10.00),
                                        child: Text(
                                          'Play Again',
                                          style: TextStyle(
                                            color: Color(0xFF72CDf4),
                                          ),
                                          textScaleFactor: 1.7,
                                        ),
                                      )),
                                  FlatButton(
                                      color: Color(0xFF173F5F),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.00),
                                          side: BorderSide(
                                              color: Color(0xFFF6D55C),
                                              width: 2)),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 30.00,
                                            right: 30.00,
                                            top: 10.00,
                                            bottom: 10.00),
                                        child: Text(
                                          'Exit',
                                          style: TextStyle(
                                            color: Color(0xFF72CDf4),
                                          ),
                                          textScaleFactor: 1.5,
                                        ),
                                      )),
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
                                          color: Color(0xFFED553B),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 32.0)),
                                  RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: 'The correct word was: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF72CDf4),
                                              fontSize: 24.0)),
                                      TextSpan(
                                          text:
                                              _gameStageBloc.curGuessWord.value,
                                          style: TextStyle(
                                              color: Color(0xFFED553B),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24.0))
                                    ]),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.all(10.00),
                                      child: Column(children: <Widget>[
                                        FlatButton(
                                            color: Color(0xFF173F5F),
                                            onPressed: () {
                                              _gameStageBloc.createNewGame();
                                            },
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        16.00),
                                                side: BorderSide(
                                                    color: Color(0xFFF6D55C),
                                                    width: 2)),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 30.00,
                                                  right: 30.00,
                                                  top: 10.00,
                                                  bottom: 10.00),
                                              child: Text(
                                                'Try Again',
                                                style: TextStyle(
                                                  color: Color(0xFF72CDf4),
                                                ),
                                                textScaleFactor: 1.7,
                                              ),
                                            )),
                                        Container(
                                          height: 30.00,
                                        ),
                                        FlatButton(
                                            color: Color(0xFF173F5F),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        16.00),
                                                side: BorderSide(
                                                    color: Color(0xFFF6D55C),
                                                    width: 2)),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 30.00,
                                                  right: 30.00,
                                                  top: 10.00,
                                                  bottom: 10.00),
                                              child: Text(
                                                'Exit',
                                                style: TextStyle(
                                                  color: Color(0xFF72CDf4),
                                                ),
                                                textScaleFactor: 1.5,
                                              ),
                                            )),
                                      ]))
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
                                        color: Color(0xFF72CDf4),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.restore,
                                      color: Color(0xFF72CDf4),
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
