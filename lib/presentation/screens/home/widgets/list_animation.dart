import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ListAnimation extends StatelessWidget {
  final Widget child;
  final double? verticalOffset;
  final double? horziontalOffset;
  const ListAnimation({
    super.key,
    required this.child,
    this.verticalOffset = 75,
    this.horziontalOffset,
  });

  static const Duration duration = Duration(milliseconds: 400);

  @override
  Widget build(BuildContext context) {
    return SlideAnimation(
      verticalOffset: verticalOffset,
      horizontalOffset: horziontalOffset,
      child: FadeInAnimation(
        curve: Curves.linear,
        child: child,
      ),
    );
  }
}
