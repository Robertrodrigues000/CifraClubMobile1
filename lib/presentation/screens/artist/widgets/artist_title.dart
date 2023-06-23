// coverage:ignore-file
import 'package:cifraclub/extensions/build_context.dart';
import 'package:flutter/material.dart';

class ArtistSectionTitle extends StatelessWidget {
  const ArtistSectionTitle({
    super.key,
    required this.title,
    this.top,
    this.bottom,
  });
  final String title;
  final double? top;
  final double? bottom;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(
          left: context.appDimensionScheme.screenMargin,
          right: context.appDimensionScheme.screenMargin,
          top: top ?? 0,
          bottom: bottom ?? 0,
        ),
        child: Text(
          title,
          style: context.typography.title5,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
