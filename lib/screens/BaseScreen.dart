// an abstract class to provide the basic interfaces
import 'dart:ui';

import 'package:flutter/gestures.dart';

abstract class BaseScreen {
  void render(Canvas canvas);
  void update();
  void resize(Size size);

  void onTapDown(TapDownDetails details) {
    // TODO: implement resize
    print("TAP!");
  }


}