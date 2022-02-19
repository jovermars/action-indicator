import 'package:flutter/material.dart';

const defaultColor = Colors.white;

class Indicator {
  final Color color;
  Indicator({this.color = defaultColor});
}

enum InsetDiagonal {
  leftRight,
  rightLeft,
}

class IndicatorInsets {
  final Indicator? left;
  final Indicator? top;
  final Indicator? right;
  final Indicator? bottom;

  final Indicator? topLeft;
  final Indicator? topRight;
  final Indicator? bottomLeft;
  final Indicator? bottomRight;

  IndicatorInsets({
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.topLeft,
    this.topRight,
    this.bottomLeft,
    this.bottomRight,
  });

  IndicatorInsets.diagonal(
      {required InsetDiagonal diagonal, Color color = defaultColor})
      : topLeft = diagonal == InsetDiagonal.leftRight
            ? Indicator(color: color)
            : null,
        topRight = diagonal == InsetDiagonal.rightLeft
            ? Indicator(color: color)
            : null,
        bottomLeft = diagonal == InsetDiagonal.rightLeft
            ? Indicator(color: color)
            : null,
        bottomRight = diagonal == InsetDiagonal.leftRight
            ? Indicator(color: color)
            : null,
        left = null,
        top = null,
        right = null,
        bottom = null;

  IndicatorInsets.all({color = defaultColor})
      : topLeft = Indicator(color: color),
        topRight = Indicator(color: color),
        bottomLeft = Indicator(color: color),
        bottomRight = Indicator(color: color),
        left = Indicator(color: color),
        top = Indicator(color: color),
        right = Indicator(color: color),
        bottom = Indicator(color: color);

  int get count =>
      (topLeft != null ? 1 : 0) +
      (topRight != null ? 1 : 0) +
      (bottomLeft != null ? 1 : 0) +
      (bottomRight != null ? 1 : 0) +
      (left != null ? 1 : 0) +
      (top != null ? 1 : 0) +
      (right != null ? 1 : 0) +
      (bottom != null ? 1 : 0);
}
