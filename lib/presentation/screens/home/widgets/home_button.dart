import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/home/widgets/list_animation.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/button_type.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/cifraclub_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomeButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const HomeButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final dimensions = context.appDimensionScheme;
    return AnimationLimiter(
      child: SliverToBoxAdapter(
        child: AnimationConfiguration.synchronized(
          duration: ListAnimation.duration,
          child: ListAnimation(
            child: CifraClubButton(
              type: ButtonType.outline,
              onPressed: onTap,
              padding: EdgeInsets.only(left: dimensions.screenMargin, right: dimensions.screenMargin, bottom: 32),
              child: Text(text),
            ),
          ),
        ),
      ),
    );
  }
}
