import 'dart:ui';

import 'package:flame/palette.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:save_redd/SaveRed.dart';
import 'package:save_redd/screens/BaseScreen.dart';
import 'package:save_redd/screens/ScreenState.dart';

class MenuScreen extends BaseScreen {
  static const blue = PaletteEntry(Colors.lightBlue);
  Size size = Size(0, 0);

  void onTapDown(TapDownDetails details) {
    // TODO: implement resize
    //Change active screen when user taps
    saveRedSquare.switchScreen(ScreenState.kPlayGroundScreen);
    print("The Menu Screen");
  }

  @override
  void render(Canvas canvas) {
    // TODO: implement render
    // we will use the screen size which is passed by the resize method to draw a rectangle
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), blue.paint);
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
