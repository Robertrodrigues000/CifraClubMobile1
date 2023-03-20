import 'package:cifraclub/extensions/build_context.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

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
    return SliverToBoxAdapter(
      child: InkWell(
        onTap: onClick,
        highlightColor: CosmosColors.transparent,
        splashColor: CosmosColors.transparent,
        splashFactory: NoSplash.splashFactory,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Row(
            children: [
              Text(
                text,
                style: context.typography.title3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
