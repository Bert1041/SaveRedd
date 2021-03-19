import 'dart:ui';

import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:save_redd/controllers/BaseWidget.dart';

class RedSquare extends BaseWidget {
  /* we will need to store the x and y position and let's make them private
  * */
  double _horizontalSpeed = 5;
  double _horizontalSign = 1;
  // we will need to store the vertical speed and vertical sign
  double _verticalSpeed = 0;
  double _verticalSign = 1;



  double _x = 0;
  double _y = 0;

  double _width = 0;
  double _height = 0;

  static const blue = PaletteEntry(Colors.blueAccent);
  static const red = PaletteEntry(Colors.redAccent);

  Size size = Size(0, 0);

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
      Rect.fromLTWH(_x, _y, _width, _height),
      (_isSquareSafe() ? blue.paint : red.paint),
    );
  }

  // we store the screen size
  @override
  void resize(Size size) {
    this.size = size;
    /* to ensure it is a square we have to calculate the ratio, width and height and use it when we choose the size
    10% of the screen for the width we have to consider the ratio as well*/
    final ratio = size.height / size.width;

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
    if (_horizontalSpeed < 10) _horizontalSpeed += 0.002;
//cut horizontal speed, both vertical and horizontal speed reaches their caps
    if(_horizontalSpeed > 6 && _horizontalSpeed < 10)
      _verticalSpeed += 0.002;
  }

  /*
  let's implement the moving logic: update the square speed to make sure the game is still palyable
  use update the square speed we want to cap the vertical speed.
  we use 10 as a higher limit for the vertical speed so if the speed didn't reach its limit we increase it by 0.08
  * */

  void _calcSign() {
    if (_x > size.width - _width) {
      _horizontalSign = -1;
    } else if (_x < _horizontalSpeed) {
      _horizontalSign = 1;
    }

    //we'll change the vertical speed sign in the same way as we did for the horizontal speed
    if(_y > size.height - _height) {
      _verticalSign = -1;
    } else if (_x < _verticalSpeed) {
      _verticalSign = -1;
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
    // update y based on the vertical speed
    _y += _verticalSpeed * _verticalSign;

  }

/*
implement a method witch will return true if the square is in the safe area
* */
  bool _isSquareSafe() {
    return _isXSafe() && _isYSafe();
  }

  bool _isXSafe() {
    if (_x < size.width - _width * 2 && _x > _width) {
      return true;
    }
    return false;
  }

  bool _isYSafe() {
    if (_y < size.height - _height * 2 && _y > _height) {
      return true;
    }
    return false;
  }
}
