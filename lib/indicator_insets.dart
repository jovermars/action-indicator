enum InsetDiagonal {
  leftRight,
  rightLeft,
}

class IndicatorInsets {
  final bool left;
  final bool top;
  final bool right;
  final bool bottom;

  final bool topLeft;
  final bool topRight;
  final bool bottomLeft;
  final bool bottomRight;

  IndicatorInsets({
    required this.left,
    required this.top,
    required this.right,
    required this.bottom,
    required this.topLeft,
    required this.topRight,
    required this.bottomLeft,
    required this.bottomRight,
  });

  IndicatorInsets.diagonal({required InsetDiagonal diagonal})
      : topLeft = diagonal == InsetDiagonal.leftRight,
        topRight = diagonal == InsetDiagonal.rightLeft,
        bottomLeft = diagonal == InsetDiagonal.rightLeft,
        bottomRight = diagonal == InsetDiagonal.leftRight,
        left = false,
        top = false,
        right = false,
        bottom = false;

  IndicatorInsets.all()
      : topLeft = true,
        topRight = true,
        bottomLeft = true,
        bottomRight = true,
        left = true,
        top = true,
        right = true,
        bottom = true;

  IndicatorInsets.only({
    bool? left,
    bool? top,
    bool? right,
    bool? bottom,
    bool? topLeft,
    bool? topRight,
    bool? bottomLeft,
    bool? bottomRight,
  })  : topLeft = topLeft ?? false,
        topRight = topRight ?? false,
        bottomLeft = bottomLeft ?? false,
        bottomRight = bottomRight ?? false,
        left = left ?? false,
        top = top ?? false,
        right = right ?? false,
        bottom = bottom ?? false;
}
