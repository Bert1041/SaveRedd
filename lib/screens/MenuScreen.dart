import 'dart:ui';

import 'package:flame/palette.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:save_redd/SaveRed.dart';
import 'package:save_redd/controllers/TextedButton.dart';
import 'package:save_redd/screens/BaseScreen.dart';
import 'package:save_redd/screens/ScreenState.dart';

class MenuScreen extends BaseScreen {
  //static const blue = PaletteEntry(Colors.lightBlue);
  //Size size = Size(0, 0);

  //we create new text button as an object and initialize in the constructor
  TextedButton _startButton;
  TextedButton _scoreButton;


  MenuScreen() {
    _startButton = TextedButton('START', 0.5, 0.4);
    _scoreButton = TextedButton('HIGH SCORE', 0.5, 0.55);
  }



  void onTapDown(TapDownDetails details) {
    //Change active screen when user taps
    // saveRedSquare.switchScreen(ScreenState.kPlayGroundScreen);
    // print("The Menu Screen");
    _startButton.onTapDown(details, () {
      saveRedSquare.switchScreen(ScreenState.kPlayGroundScreen);
    });
    _scoreButton.onTapDown(details, () {
      saveRedSquare.switchScreen(ScreenState.kScoreScreen);
    });
  }

  @override
  void render(Canvas canvas) {
    // we will use the screen size which is passed by the resize method to draw a rectangle
    //canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), blue.paint);
    _startButton.render(canvas);
    _scoreButton.render(canvas);
  }

  @override
  void resize(Size size) {
    //store screen size when resize method gets called
    //this.size = size;
    _startButton.resize(size);
    _scoreButton.resize(size);
  }

  @override
  void update(double t) {
    _startButton.update(t);
  }

}
