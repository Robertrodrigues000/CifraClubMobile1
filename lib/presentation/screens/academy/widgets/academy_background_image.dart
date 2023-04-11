import 'package:cifraclub/extensions/build_context.dart';
import 'package:flutter/material.dart';

class AcademyBackgroundImage extends StatelessWidget {
  const AcademyBackgroundImage({super.key, required this.backgroundImagePath});
  final String backgroundImagePath;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        begin: const Alignment(0, 0.6),
        end: Alignment.bottomCenter,
        colors: [
          context.colors.primaryContainer,
          context.colors.neutralPrimary,
        ],
      ).createShader(bounds),
      blendMode: BlendMode.dstOver,
      child: Image.asset(
        backgroundImagePath,
        fit: BoxFit.fitWidth,
        alignment: Alignment.topLeft,
      ),
    );
  }
}
