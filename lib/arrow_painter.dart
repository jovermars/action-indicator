import 'package:flutter/material.dart';

import 'indicator_insets.dart';

class ArrowPainter extends CustomPainter {
  final double width;
  final double thickness;
  final Color color;
  final double offset;
  final IndicatorInsets indicators;

  ArrowPainter({
    required this.indicators,
    required this.width,
    required this.thickness,
    required this.color,
    required this.offset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;

    var p = Path();
    // top left
    if (indicators.topLeft) {
      p.moveTo(width + offset, offset);
      p.relativeLineTo(-width, 0);
      p.relativeLineTo(0, width);
    }

    // top right
    if (indicators.topRight) {
      p.moveTo(size.width - width - offset, offset);
      p.relativeLineTo(width, 0);
      p.relativeLineTo(0, width);
    }

    // bottom left
    if (indicators.bottomLeft) {
      p.moveTo(offset + width, size.height - offset);
      p.relativeLineTo(-width, 0);
      p.relativeLineTo(0, -width);
    }

    // bottom right
    if (indicators.bottomRight) {
      p.moveTo(size.width - offset - width, size.height - offset);
      p.relativeLineTo(width, 0);
      p.relativeLineTo(0, -width);
    }

    canvas.drawPath(p, paint);
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
