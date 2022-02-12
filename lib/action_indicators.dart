library action_indicators;

import 'package:flutter/widgets.dart';

import 'indicator_insets.dart';
import 'arrow_painter.dart';

class ActionIndicators extends StatefulWidget {
  final Widget child;
  final double offset;
  final Color color;
  final double width;
  final double thickness;
  final Duration duration;
  final Duration timeout;
  final bool enabled;
  final IndicatorInsets indicators;

  const ActionIndicators(
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
  State<ActionIndicators> createState() => _ActionIndicatorsState();
}

class _ActionIndicatorsState extends State<ActionIndicators>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _offsetAnimation;
  late Animation<Color?> _colorAnimation;

  late Tween<double> _offsetTween;
  late Animatable<Color?> _colorTween;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _offsetTween = Tween(begin: 0, end: widget.offset);
    _colorTween = TweenSequence<Color?>([
      TweenSequenceItem(
          weight: 2.0,
          tween: ColorTween(
              begin: widget.color.withOpacity(0), end: widget.color)),
      TweenSequenceItem(
          weight: 1.0,
          tween: ColorTween(begin: widget.color, end: widget.color)),
      TweenSequenceItem(
          weight: 2.0,
          tween: ColorTween(
              begin: widget.color, end: widget.color.withOpacity(0))),
    ]);

    _controller = AnimationController(vsync: this, duration: widget.duration);

    _offsetAnimation = _offsetTween.animate(_controller);
    _colorAnimation = _colorTween.animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0, 1.0)));

    _offsetAnimation
      ..addListener(() {
        if (!mounted) return;
        setState(() {});
      })
      ..addStatusListener((status) {
        if (!mounted) return;
        if (status == AnimationStatus.completed) {
          Future.delayed(widget.timeout, () => _controller.forward(from: 0));
        }
      });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: widget.child,
      foregroundPainter: widget.enabled
          ? ArrowPainter(
              width: widget.width,
              thickness: widget.thickness,
              color: _colorAnimation.value!,
              offset: _offsetAnimation.value,
              indicators: widget.indicators)
          : null,
    );
  }
}
