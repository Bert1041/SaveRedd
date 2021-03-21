import 'dart:ui';

import 'package:flame/palette.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:save_redd/controllers/RedSquare.dart';
import 'package:save_redd/controllers/ScoreHolder.dart';
import 'package:save_redd/screens/BaseScreen.dart';

import '../SaveRed.dart';
import 'ScreenState.dart';

class PlayGroundScreen extends BaseScreen {
  RedSquare _redSquare;
  ScoreHolder _scoreHolder;

  bool _isGameOver = false;


  PlayGroundScreen() {
    _redSquare = RedSquare();
    _scoreHolder = ScoreHolder(0.5, 0.1);
  }
// delegate all the jobs to the new created object

  void onTapDown(TapDownDetails details) {
    //Change active screen when user taps
    //saveRedSquare.switchScreen(ScreenState.kScoreScreen);
    _redSquare.onTapDown(details, () {});
  }

  @override
  void render(Canvas canvas) {
    // we will use the screen size which is passed by the resize method to draw a rectangle
    //canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), red.paint);
    _redSquare.render(canvas);
    _scoreHolder.render(canvas);
  }

  @override
  void resize(Size size) {
    //store screen size when resize method gets called
    //this.size = size;
    _redSquare.resize(size);
    _scoreHolder.resize(size);
  }

  @override
  void update() {
    // if the game is over we have to stop calling the update method on the square and score holder to make them stop
    if (!_isGameOver) {
      _redSquare.update();
      _scoreHolder.update();

      if (_redSquare.isGameOver()) {
        _isGameOver = true;
      }
    }
  }
}
