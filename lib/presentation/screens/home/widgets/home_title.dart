import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/home/widgets/list_animation.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomeTitle extends StatelessWidget {
  const HomeTitle({
    super.key,
    this.onClick,
    required this.text,
    this.horizontalPadding = 0,
  });
  final String text;
  final VoidCallback? onClick;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: SliverToBoxAdapter(
        child: AnimationConfiguration.synchronized(
          duration: ListAnimation.duration,
          child: ListAnimation(
            child: InkWell(
              onTap: onClick,
              highlightColor: CosmosColors.transparent,
              splashColor: CosmosColors.transparent,
              splashFactory: NoSplash.splashFactory,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        text,
                        style: context.typography.title5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
