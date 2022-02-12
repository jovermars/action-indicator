import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'indicator_insets.dart';

class ArrowPainter extends CustomPainter {
  final double width;
  final double thickness;
  final Color color;
  final double offset;
  final IndicatorInsets indicators;
  final Paint _painter;

  ArrowPainter({
    required this.indicators,
    required this.width,
    required this.thickness,
    required this.color,
    required this.offset,
  }) : _painter = Paint()
          ..color = color
          ..strokeWidth = thickness
          ..style = PaintingStyle.stroke
          ..strokeJoin = StrokeJoin.round
          ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    var arrow = Path();
    arrow.moveTo(0, width);
    arrow.lineTo(0, 0);
    arrow.lineTo(width, 0);

    // top
    if (indicators.top) {
      var topCenter = Offset(size.width / 2, -offset - width / 2);
      var rotation = math.pi * 0.25;
      drawRotated(canvas, arrow, topCenter, rotation);
    }

    if (indicators.bottom) {
      var bottomCenter =
          Offset(size.width / 2, size.height + offset + width / 2);
      drawRotated(canvas, arrow, bottomCenter, math.pi * -0.75);
    }

    if (indicators.left) {
      var leftCenter = Offset(-offset - width / 2, size.height / 2);
      drawRotated(canvas, arrow, leftCenter, math.pi * -0.25);
    }

    if (indicators.right) {
      var rightCenter =
          Offset(size.width + offset + width / 2, size.height / 2);
      drawRotated(canvas, arrow, rightCenter, math.pi * 0.75);
    }

    if (indicators.topLeft) {
      var topLeft = Offset(-offset, -offset);
      drawRotated(canvas, arrow, topLeft, 0);
    }

    if (indicators.topRight) {
      var topRight = Offset(size.width + offset, -offset);
      drawRotated(canvas, arrow, topRight, math.pi * 0.5);
    }

    if (indicators.bottomLeft) {
      var bottomLeft = Offset(-offset, size.height + offset);
      drawRotated(canvas, arrow, bottomLeft, math.pi * -0.5);
    }

    if (indicators.bottomRight) {
      var bottomRight = Offset(size.width + offset, size.height + offset);
      drawRotated(canvas, arrow, bottomRight, math.pi);
    }
  }

  void drawRotated(Canvas canvas, Path p, Offset position, double rotation) {
    canvas.save();
    canvas.translate(position.dx, position.dy);
    canvas.rotate(rotation);
    canvas.drawPath(p, _painter);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant ArrowPainter oldDelegate) {
    return oldDelegate != this;
  }

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) {
    return other is ArrowPainter &&
        other.color == color &&
        other.offset == offset &&
        other.width == width &&
        other.thickness == thickness;
  }
}
