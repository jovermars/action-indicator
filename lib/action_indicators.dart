library action_indicators;

import 'package:flutter/widgets.dart';

import 'arrow_insets.dart';
import 'arrow_painter.dart';

class ActionIndicators extends StatefulWidget {
  final Widget child;
  final double padding;
  final Color color;
  final double width;
  final double thickness;
  final Duration speed;
  final bool enabled;
  final IndicatorInsets indicators;

  const ActionIndicators({
    Key? key,
    required this.indicators,
    required this.child,
    required this.padding,
    required this.color,
    this.width = 5,
    this.thickness = 3,
    this.speed = const Duration(milliseconds: 900),
    this.enabled = true,
  }) : super(key: key);

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
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    _offsetTween = Tween(begin: widget.padding, end: 0);
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
          _controller.repeat();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Padding(
        padding: EdgeInsets.all(widget.padding),
        child: widget.child,
      ),
      painter: widget.enabled
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
