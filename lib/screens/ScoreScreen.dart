import 'dart:ui';

import 'package:flame/palette.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:save_redd/screens/BaseScreen.dart';

import '../SaveRed.dart';
import 'ScreenState.dart';

class ScoreScreen extends BaseScreen {
  static const green = PaletteEntry(Colors.lightGreenAccent);
  Size size = Size(0, 0);

  void onTapDown(TapDownDetails details) {
    // TODO: implement resize
    saveRedSquare.switchScreen(ScreenState.kPlayGroundScreen);
    print("The Score screen");
  }

  @override
  void render(Canvas canvas) {
    // TODO: implement render
    // we will use the screen size which is passed by the resize method to draw a rectangle
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), green.paint);
  }

  @override
  void resize(Size size) {
    // TODO: implement resize
    //store screen size when resize method gets called
    this.size = size;
  }

  @override
  void update(double t) {
    // TODO: implement update
  }

}
