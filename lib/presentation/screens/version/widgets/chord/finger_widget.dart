import 'package:cifraclub/presentation/style/typography/font_families.dart';
import 'package:flutter/material.dart';

class FingerWidget extends StatelessWidget {
  final int id;
  final double ballSize;
  final Widget? child;
  final double fontSize;
  const FingerWidget({
    super.key,
    required this.id,
    required this.ballSize,
    this.child,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ballSize,
      height: ballSize,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
      child: Center(
        child: Text(
          '$id',
          textScaleFactor: 1,
          textDirection: TextDirection.ltr,
          style: TextStyle(
            textBaseline: TextBaseline.alphabetic,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
            fontFamily: FontFamilies.montserrat,
          ),
        ),
      ),
    );
  }
}
