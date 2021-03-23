import 'dart:async';
import 'dart:ui';

import 'package:flame/game/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
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

  Function _fnUpdate;
  Size _size = Size(0,0);

  SaveRedSquare() {
    _screenState = ScreenState.kMenuScreen;

    _menuScreen = MenuScreen();
    _playGroundScreen = PlayGroundScreen();
    _scoreScreen = ScoreScreen();
    _fnUpdate = _init;
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
    //_getActiveScreen()?.update(t);
    _fnUpdate();
  }

  @override
  void resize(Size size) {
    // TODO: implement resize
    //_getActiveScreen()?.resize(size);
    // make sure resize method get called on all objects not just active one
    _menuScreen?.resize(size);
    _playGroundScreen?.resize(size);
    _scoreScreen?.resize(size);

    _size = size;

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
 //   _screenState = newScreen;
// we delay this using a timer, after 3 seconds
      switch (newScreen) {
        case ScreenState.kScoreScreen:
          Timer(new Duration(seconds: 3), () {
            _scoreScreen = ScoreScreen();
            _scoreScreen.resize(_size);
            _screenState = newScreen;
          });
          break;
        case ScreenState.kPlayGroundScreen:
          _playGroundScreen = PlayGroundScreen();
          _playGroundScreen.resize(_size);
          Timer(new Duration(milliseconds: 10), () {
            _screenState = newScreen;
          });
          break;
        case ScreenState.kMenuScreen:
          _screenState = newScreen;
          _menuScreen = MenuScreen();
          _menuScreen.resize(_size);
          Timer(new Duration(milliseconds: 10), () {
            _screenState = newScreen;
          });
          break;
          break;
        default:
          _screenState = newScreen;
      }
    }

// the new update will pass the job to hte active screen
  Future<void> _init() async {
    _fnUpdate = _update;
    // then we need flame utils variable
    Util flameUtil = Util();
    await flameUtil.fullScreen();
    await flameUtil.setOrientation(DeviceOrientation.portraitDown);
  }

  void _update() {
    _getActiveScreen()?.update();
  }
}
