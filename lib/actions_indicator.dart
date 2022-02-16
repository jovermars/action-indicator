library action_indicators;

import 'package:flutter/widgets.dart';

import 'indicator_controller.dart';
import 'indicator_insets.dart';
import 'arrow_painter.dart';

class ActionsIndicator extends StatefulWidget {
  final Color color;
  final double width;
  final double thickness;
  final Duration duration;
  final Duration timeout;
  final IndicatorInsets indicators;
  final bool enabled;
  final Widget child;
  final double offset;

  const ActionsIndicator(
      {Key? key,
      required this.indicators,
      required this.child,
      required this.color,
      this.offset = 8,
      this.width = 5,
      this.thickness = 3,
      this.duration = const Duration(milliseconds: 1000),
      this.timeout = const Duration(milliseconds: 500),
      this.enabled = true})
      : super(key: key);

  @override
  State<ActionsIndicator> createState() => _ActionsIndicatorState();
}

class _ActionsIndicatorState extends State<ActionsIndicator>
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
    _controller = IndicatorController(
        vsync: this,
        color: widget.color,
        duration: widget.duration,
        timeout: widget.timeout,
        offset: widget.offset)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: widget.child,
      foregroundPainter: widget.enabled
          ? ArrowPainter(
              width: widget.width,
              thickness: widget.thickness,
              color: _controller.currentColor,
              offset: _controller.currentOffset,
              indicators: widget.indicators,
            )
          : null,
    );
  }
}
