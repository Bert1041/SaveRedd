import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:save_redd/controllers/BaseWidget.dart';

class TextedButton extends BaseWidget {
  /*
  need x and y variables to set position on the screen,
  also a string which will be our displayed text
  text painter to paint our text and also text style
   */
  final double _xRatio;
  final double _yRatio;
  final String _text;

  TextPainter _painter;
  TextStyle _textStyle;

  Offset _position;

  TextedButton(this._text, this._xRatio, this._yRatio) {
    //initialize our painter
    _painter = TextPainter(
        textAlign: TextAlign.center, textDirection: TextDirection.ltr);

    _textStyle = TextStyle(
      color: Colors.white,
      fontSize: 0,
    );

    // initialize the painter text using the string which we received during construction phase and the text style we just initialised
    _painter.text = TextSpan(text: _text, style: _textStyle);

    // we call the layout method of the painter and store the text position on the screen
    _painter.layout();
    _position = Offset(0, 0);
  }
  /* in the constructor we have initialized most of our objects using some defaults values
  * but the key method here is the resize method this is where we have to resize everything based on the screen size*/

  @override
  void render(Canvas canvas) {
    //we'll choose our painter to paint our text on the defined position
    _painter.paint(canvas, _position);
  }

  @override
  void resize(Size size) {
    //re-initialize our text style, font size to 10% of the screen width
    _textStyle = TextStyle(
      color: Colors.white,
      fontSize: size.width * 0.1,
    );
    //re-initialize painter again and call the layout method again
    _painter.text = TextSpan(text: _text, style: _textStyle);
    _painter.layout();
    //define the starting position of the screen: x and y ratios of the screen the screen size and the painters size
    _position = Offset(
      //we want to subtract the painter size from the starting position to make sure that the text is centered on the screen
      size.width * _xRatio - (_painter.width * _xRatio),
      size.height * _yRatio - (_painter.height * _yRatio),
    );
  }

  @override
  void update(double t) {
    // TODO: implement update
  }

  //when on tap method gets called we receive the tab position on the screen in a nutshell we can extract the exact position and make sure it is within our painted text
  void onTapDown(TapDownDetails details, Function fn) {
    var pos = details.globalPosition;
    if(pos.dx >= _position.dx && pos.dx <= _position.dx + _painter.width) {
      if(pos.dy >= _position.dy && pos.dy <= _position.dy + _painter.height) {
        fn();
      }
    }
  }
}
