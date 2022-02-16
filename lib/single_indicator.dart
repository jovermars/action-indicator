library action_indicators;

import 'package:flutter/material.dart';

import 'indicator_controller.dart';
import 'indicator_insets.dart';
import 'arrow_painter.dart';

class SingleIndicator extends StatefulWidget {
  final Color color;
  final double width;
  final double thickness;
  final Duration duration;
  final Duration timeout;
  final bool enabled;
  final IndicatorInsets indicator;

  const SingleIndicator({
    Key? key,
    required this.indicator,
    required this.color,
    this.enabled = true,
    this.width = 24,
    this.thickness = 5,
    this.duration = const Duration(milliseconds: 500),
    this.timeout = const Duration(milliseconds: 500),
  }) : super(key: key);

  @override
  State<SingleIndicator> createState() => _ActionIndicatorsState();
}

class _ActionIndicatorsState extends State<SingleIndicator>
    with TickerProviderStateMixin {
  late IndicatorController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    assert(widget.indicator.count == 1);

    _controller = IndicatorController(
        vsync: this,
        color: widget.color,
        duration: widget.duration,
        timeout: widget.timeout,
        offset: widget.width)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: widget.enabled
          ? ArrowPainter(
              width: widget.width,
              thickness: widget.thickness,
              color: _controller.currentColor,
              offset: _controller.currentOffset,
              indicators: widget.indicator)
          : null,
    );
  }
}
