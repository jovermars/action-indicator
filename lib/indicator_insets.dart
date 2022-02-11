enum InsetDiagonal {
  leftRight,
  rightLeft,
}

class IndicatorInsets {
  final bool topLeft;
  final bool topRight;
  final bool bottomLeft;
  final bool bottomRight;

  IndicatorInsets({
    required this.topLeft,
    required this.topRight,
    required this.bottomLeft,
    required this.bottomRight,
  });

  IndicatorInsets.diagonal({required InsetDiagonal diagonal})
      : topLeft = diagonal == InsetDiagonal.leftRight,
        topRight = diagonal == InsetDiagonal.rightLeft,
        bottomLeft = diagonal == InsetDiagonal.rightLeft,
        bottomRight = diagonal == InsetDiagonal.leftRight;

  IndicatorInsets.all()
      : topLeft = true,
        topRight = true,
        bottomLeft = true,
        bottomRight = true;

  IndicatorInsets.only({
    bool? topLeft,
    bool? topRight,
    bool? bottomLeft,
    bool? bottomRight,
  })  : topLeft = topLeft ?? false,
        topRight = topRight ?? false,
        bottomLeft = bottomLeft ?? false,
        bottomRight = bottomRight ?? false;
}
