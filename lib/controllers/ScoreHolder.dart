import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:save_redd/controllers/BaseWidget.dart';

class ScoreHolder extends BaseWidget {

  final double _xRatio;
  final double _yRatio;

  TextPainter _painter;
  TextStyle _textStyle;

  Offset _position;

  double _score;

  DateTime _lastCalc;

  Function _fnUpdate;
  int _digits;

  Size _size = Size(0, 0);

  ScoreHolder(this._xRatio, this._yRatio) {
    _score = 0;
    _digits = 1;

    //initialize our painter
    _painter = TextPainter(
        textAlign: TextAlign.center, textDirection: TextDirection.ltr);

    _textStyle = TextStyle(
      color: Colors.white,
      fontSize: 0,
    );

    _painter.text =
        TextSpan(text: _score.toInt().toString(), style: _textStyle);

    _painter.layout();
    _position = Offset(0, 0);

    _fnUpdate = _init;
  }

  @override
  void render(Canvas canvas) {
    _painter.paint(canvas, _position);
  }

  // we calc the score based on how much time the user played but for this we'll have to store the initial score
  // we'll store the initial time and always do a div between cycles
  @override
  void resize(Size size) {
    //re-initialize our text style, font size to 10% of the screen width
    _textStyle = TextStyle(
      color: Colors.white,
      fontSize: size.width * 0.1,
    );

    //re-initialize painter again and call the layout method again
    _painter.text =
        TextSpan(text: _score.toInt().toString(), style: _textStyle);
    _painter.layout();
    //define the starting position of the screen: x and y ratios of the screen the screen size and the painters size
    _position = Offset(
      //we want to subtract the painter size from the starting position to make sure that the text is centered on the screen
      size.width * _xRatio - (_painter.width * _xRatio),
      size.height * _yRatio - (_painter.height * _yRatio),
    );

    _size = size;
  }

  /*
  in the first cycle it will store the start time then the function the variables needs to update the score based on how much time it passed

  * */
  void _update() {
    //the score will increase by the time difference between the current time and the last time we did this increase we / 100 to make sure the score doesn't change that much
    // also update the last cal variable
    _score += (DateTime.now().difference(_lastCalc).inMilliseconds) / 100;
    _lastCalc = DateTime.now();

    //if we want to have our score being centered on the screen we correlate the number of digits to the current score and if we detect any discrepancies we call resize method
    if (_score > 10 && _digits < 2 ||
        (_score > 100 && _digits < 3) ||
        (_score > 1000 && _digits < 4)) {
      _digits++;
      resize(_size);
    } else {
      _painter.text =
          TextSpan(text: _score.toInt().toString(), style: _textStyle);
      _painter.layout();
    }
  }

  void _init() {
    _fnUpdate = _update;
    //last calc will store the time when the previous calculation was done
    _lastCalc = DateTime.now();
  }

  @override
  void update(double t) {
    _fnUpdate();
  }

  Future<void> onTapDown(TapDownDetails details, Function fn) {}
}
