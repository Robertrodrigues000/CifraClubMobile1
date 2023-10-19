import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ListAnimation extends StatelessWidget {
  final Widget child;
  final double? verticalOffset;
  final double? horizontalOffset;
  const ListAnimation({
    super.key,
    required this.child,
    this.verticalOffset = 75,
    this.horizontalOffset,
  });

  static const Duration duration = Duration(milliseconds: 400);

  @override
  Widget build(BuildContext context) {
    return SlideAnimation(
      verticalOffset: verticalOffset,
      horizontalOffset: horizontalOffset,
      child: FadeInAnimation(
        curve: Curves.linear,
        child: child,
      ),
    );
  }
}
