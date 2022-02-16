import 'package:flutter/material.dart';

class IndicatorController extends ChangeNotifier {
  final TickerProvider vsync;
  final Color color;
  final Duration duration;
  final Duration timeout;
  final double offset;

  bool _disposed = false;

  late AnimationController _controller;

  late Animation<double> _offsetAnimation;
  late Animation<Color?> _colorAnimation;

  Color get currentColor => _colorAnimation.value!;
  double get currentOffset => _offsetAnimation.value;

  late Tween<double> _offsetTween;
  late Animatable<Color?> _colorTween;

  IndicatorController({
    required this.vsync,
    required this.color,
    required this.duration,
    required this.timeout,
    required this.offset,
  }) {
    _offsetTween = Tween(begin: 0, end: offset);
    _colorTween = TweenSequence<Color?>([
      TweenSequenceItem(
          weight: 2.0,
          tween: ColorTween(begin: color.withOpacity(0), end: color)),
      TweenSequenceItem(
          weight: 1.0, tween: ColorTween(begin: color, end: color)),
      TweenSequenceItem(
          weight: 2.0,
          tween: ColorTween(begin: color, end: color.withOpacity(0))),
    ]);

    _controller = AnimationController(vsync: vsync, duration: duration);

    _colorAnimation = _colorTween.animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0, 1.0)))
      ..addListener(_animationListener);

    _offsetAnimation = _offsetTween.animate(_controller)
      ..addListener(_animationListener)
      ..addStatusListener(_animationStatusListener);

    _controller.forward();
  }

  void _animationStatusListener(status) {
    if (_disposed) return;
    if (status == AnimationStatus.completed) {
      Future.delayed(timeout, () {
        if (_disposed) return;
        _controller.forward(from: 0);
      });
    }
  }

  void _animationListener() {
    if (_disposed) return;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _controller.dispose();
    super.dispose();
  }
}
