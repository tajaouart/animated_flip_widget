import 'dart:math';

import 'package:flutter/material.dart';

enum FlipDirection { Vertical, Horizontal }

/// `FlipController` class is used to control the animation of the flip.
class FlipController extends ChangeNotifier {
  double angle = 0;

  FlipController();

  /// updates the `angle` property and calls `notifyListeners()`
  void flip() {
    angle = (angle + pi) % (2 * pi);
    notifyListeners();
  }
}
