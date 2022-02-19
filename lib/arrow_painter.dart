import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'indicator_insets.dart';

class ArrowPainter extends CustomPainter {
  final double width;
  final double thickness;
  final double opacity;
  final double offset;
  final IndicatorInsets indicators;
  final Paint _painter;

  ArrowPainter({
    required this.indicators,
    required this.width,
    required this.thickness,
    required this.opacity,
    required this.offset,
  }) : _painter = Paint()
          ..strokeWidth = thickness
          ..style = PaintingStyle.stroke
          ..strokeJoin = StrokeJoin.round
          ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.moveTo(0, width);
    path.lineTo(0, 0);
    path.lineTo(width, 0);

    // top
    if (indicators.top != null) {
      var topCenter = Offset(size.width / 2, -offset - width / 2);
      drawRotated(canvas, path, topCenter, math.pi * 0.25, indicators.top!);
    }

    if (indicators.bottom != null) {
      var bottomCenter =
          Offset(size.width / 2, size.height + offset + width / 2);
      drawRotated(
          canvas, path, bottomCenter, math.pi * -0.75, indicators.bottom!);
    }

    if (indicators.left != null) {
      var leftCenter = Offset(-offset - width / 2, size.height / 2);
      drawRotated(canvas, path, leftCenter, math.pi * -0.25, indicators.left!);
    }

    if (indicators.right != null) {
      var rightCenter =
          Offset(size.width + offset + width / 2, size.height / 2);
      drawRotated(canvas, path, rightCenter, math.pi * 0.75, indicators.right!);
    }

    if (indicators.topLeft != null) {
      var topLeft = Offset(-offset, -offset);
      drawRotated(canvas, path, topLeft, 0, indicators.topLeft!);
    }

    if (indicators.topRight != null) {
      var topRight = Offset(size.width + offset, -offset);
      drawRotated(canvas, path, topRight, math.pi * 0.5, indicators.topRight!);
    }

    if (indicators.bottomLeft != null) {
      var bottomLeft = Offset(-offset, size.height + offset);
      drawRotated(
          canvas, path, bottomLeft, math.pi * -0.5, indicators.bottomLeft!);
    }

    if (indicators.bottomRight != null) {
      var bottomRight = Offset(size.width + offset, size.height + offset);
      drawRotated(canvas, path, bottomRight, math.pi, indicators.bottomRight!);
    }
  }

  void drawRotated(Canvas canvas, Path p, Offset position, double rotation,
      Indicator indicator) {
    _painter.color = indicator.color.withOpacity(opacity);
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
        other.opacity == opacity &&
        other.offset == offset &&
        other.width == width &&
        other.thickness == thickness;
  }
}
