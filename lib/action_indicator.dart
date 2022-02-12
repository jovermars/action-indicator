library action_indicators;

import 'package:flutter/material.dart';

import 'indicator_insets.dart';
import 'arrow_painter.dart';

class ActionIndicator extends StatefulWidget {
  final Color color;
  final double width;
  final double thickness;
  final Duration speed;
  final bool enabled;
  final IndicatorInsets indicator;

  const ActionIndicator(
      {Key? key,
      required this.indicator,
      required this.color,
      this.width = 24,
      this.thickness = 5,
      this.speed = const Duration(milliseconds: 900),
      this.enabled = true})
      : super(key: key);

  @override
  State<ActionIndicator> createState() => _ActionIndicatorsState();
}

class _ActionIndicatorsState extends State<ActionIndicator>
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
    assert(widget.indicator.count == 1);

    _offsetTween = Tween(begin: 0, end: widget.width);
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

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

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
          Future.delayed(const Duration(milliseconds: 500),
              () => _controller.forward(from: 0));
        }
      });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: widget.enabled
          ? ArrowPainter(
              width: widget.width,
              thickness: widget.thickness,
              color: _colorAnimation.value!,
              offset: _offsetAnimation.value,
              indicators: widget.indicator)
          : null,
    );
  }
}
