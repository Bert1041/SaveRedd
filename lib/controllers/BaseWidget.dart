// an abstract class to provide the basic interfaces
import 'dart:ui';

import 'package:flutter/gestures.dart';

abstract class BaseWidget {
  void render(Canvas canvas);
  void update();
  void resize(Size size);


  // add a new parameter which will be a function
  //we will execute the received set of instruction when the widget get tapped
  void onTapDown(TapDownDetails details, Function fn) {
    print("TAP!");
  }


}