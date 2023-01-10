import 'dart:math';
import 'package:flutter/material.dart';

import 'flip_controler.dart';

/// This widget creates an animation of a flipping card.
/// It takes three required parameters: `front`, `back`, and `controller`.
/// `front` and `back` are the `Widget`s that will be displayed on the front and back of the card, respectively.
/// `controller` is an instance of the `FlipController` class, which is responsible for controlling the animation of the flip.
/// It also takes two optional parameters: `clickable` and `flipDuration`.
/// `clickable` is a boolean that indicates whether the card should be clickable or not.
/// If `clickable` is true, then the card will flip when it is tapped. If `clickable` is false, then the card will not respond to taps.
/// `flipDuration` is a `Duration` type that specifies how long the flipping animation should take. The default value is 400 milliseconds.
/// `direction` is an enumeration that indicates the direction of flipping, either horizontally or vertically. The default value is vertical.
class AnimatedFlipWidget extends StatefulWidget {
  const AnimatedFlipWidget({
    required this.front,
    required this.back,
    required this.controller,
    this.clickable = true,
    this.flipDuration = const Duration(milliseconds: 400),
    this.direction = FlipDirection.Vertical,
    Key? key,
  }) : super(key: key);

  /// Widget that will be displayed on the front of the card
  final Widget front;

  /// Widget that will be displayed on the back of the card
  final Widget back;

  /// `FlipController` class is used to control the animation of the flip.
  final FlipController controller;

  /// indicates whether the card should be clickable or not.
  final bool clickable;

  /// specifies how long the flipping animation should take
  final Duration flipDuration;

  /// Indicates the direction of flipping, either horizontally or vertically
  final FlipDirection direction;

  @override
  State<AnimatedFlipWidget> createState() => _AnimatedFlipWidgetState();
}

class _AnimatedFlipWidgetState extends State<AnimatedFlipWidget> {
  bool isBack = true;

  @override
  void initState() {
    super.initState();

    // adds listener to the widget's controller to be notified of change in controller's angle
    widget.controller.addListener(_listener);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.clickable
          ? () {
              widget.controller.flip();
            }
          : null,
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: widget.controller.angle),
        duration: widget.flipDuration,
        builder: (BuildContext context, double val, __) {
          if (val >= (pi / 2)) {
            isBack = false;
          } else {
            isBack = true;
          }
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(widget.direction == FlipDirection.Vertical ? val : 0)
              ..rotateY(widget.direction == FlipDirection.Horizontal ? val : 0),
            child: isBack
                ? widget.back
                : Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..rotateX(
                          widget.direction == FlipDirection.Vertical ? pi : 0)
                      ..rotateY(widget.direction == FlipDirection.Horizontal
                          ? pi
                          : 0),
                    child: widget.front,
                  ),
          );
        },
      ),
    );
  }

  void _listener() {
    setState(() {});
  }
}
