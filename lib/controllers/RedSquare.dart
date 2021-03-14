import 'dart:ui';

import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:save_redd/controllers/BaseWidget.dart';

class RedSquare extends BaseWidget {
  /* we will need to store the x and y position and let's make them private
  * */
  double _horizontalSpeed = 5;
  double _horizontalSign = 1;

  double _x = 0;
  double _y = 0;

  double _width = 0;
  double _height = 0;

  static const blue = PaletteEntry(Colors.blueAccent);
  Size size = Size(0,0);

  @override
  void render(Canvas canvas) {
    canvas.drawRect(Rect.fromLTWH(_x, _y, _width, _height), blue.paint);
  }

  // we store the screen size
  @override
  void resize(Size size) {
    this.size = size;
    /* to ensure it is a square we have to calculate the ratio, width and height and use it when we choose the size
    10% of the screen for the width we have to consider the ratio as well*/
    final ratio = size.height/size.width;

    _width = size.width * 0.1 * ratio;
    _height = size.height * 0.1;

    // lets enter the square on the y axis
    _x = 0;
    _y = (size.height - _height) / 2;
  }

  @override
  void update(double t) {
    _updateSpeed();
    _calcSign();
    _calcPosition();
  }

  void _updateSpeed() {
    if(_horizontalSpeed < 10)
      _horizontalSpeed += 0.001;
  }

  /*
  let's implement the moving logic: update the square speed to make sure the game is still palyable
  use update the square speed we want to cap the vertical speed.
  we use 10 as a higher limit for the vertical speed so if the speed didn't reach its limit we increase it by 0.08
  * */

  void _calcSign() {
    if(_x > size.width - _width * 2){
      _horizontalSign = -1;
    }
    else if(_x < _width * 2){
      _horizontalSign = 1;
    }

  }
  /*
  we'll change the sign whenever the square is too close to one of the edges
  later this will be done in the on tap event
  sign = 1 move to the right
  sign = -1 move left
  * */

//calculate current position based on the speed and the sign as long as the sign is 1
  // the x will be increased by the speed, once the sign is -1 x will start decreasing
  void _calcPosition() {
    _x += _horizontalSpeed * _horizontalSign;
  }

}