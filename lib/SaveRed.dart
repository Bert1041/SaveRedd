import 'dart:ui';

import 'package:flame/game/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/gestures.dart';
import 'package:save_redd/screens/BaseScreen.dart';
import 'package:save_redd/screens/MenuScreen.dart';
import 'package:save_redd/screens/PlayGroundScreen.dart';
import 'package:save_redd/screens/ScoreScreen.dart';
import 'package:save_redd/screens/ScreenState.dart';

SaveRedSquare saveRedSquare = SaveRedSquare();


class SaveRedSquare extends Game with TapDetector {


  ScreenState _screenState;
  BaseScreen _menuScreen;
  BaseScreen _playGroundScreen;
  BaseScreen _scoreScreen;

  SaveRedSquare() {
    _screenState = ScreenState.kMenuScreen;

    _menuScreen = MenuScreen();
    _playGroundScreen = PlayGroundScreen();
    _scoreScreen = ScoreScreen();
  }


  @override
  void render(Canvas canvas) {
    //print("Render");
    // question mark means if the object is being initialized call the following method
    _getActiveScreen()?.render(canvas);
  }

  @override
  void update(double t) {
    //print("UPDATE");
    _getActiveScreen()?.update(t);
  }

  @override
  void resize(Size size) {
    // TODO: implement resize
    //_getActiveScreen()?.resize(size);
    // make sure resize method get called on all objects not just active one
    _menuScreen?.resize(size);
    _playGroundScreen?.resize(size);
    _scoreScreen?.resize(size);
  }

  void onTapDown(TapDownDetails details) {
    // TODO: implement resize
    //print("TAP!"); no need to print since we have declared the screen
    _getActiveScreen()?.onTapDown(details);
  }


  // return the object screen
  BaseScreen _getActiveScreen() {
    switch (_screenState) {
      case ScreenState.kMenuScreen:
        return _menuScreen;
      case ScreenState.kPlayGroundScreen:
        return _playGroundScreen;
      case ScreenState.kScoreScreen:
        return _scoreScreen;
      default:
        return _menuScreen;
    }
  }


  // method to update active screen
  void switchScreen(ScreenState newScreen) {
    _screenState = newScreen;
  }





}