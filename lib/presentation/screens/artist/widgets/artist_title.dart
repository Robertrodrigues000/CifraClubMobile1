// coverage:ignore-file
import 'package:cifraclub/extensions/build_context.dart';
import 'package:flutter/material.dart';

class ArtistTitle extends StatelessWidget {
  const ArtistTitle({
    super.key,
    required this.title,
    required this.verticalPadding,
  });
  final String title;
  final double verticalPadding;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: verticalPadding),
        child: Text(
          title,
          style: context.typography.title5,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
