import 'package:cifraclub/extensions/build_context.dart';
import 'package:flutter/material.dart';

class ArtistSongsCollapsedHeader extends StatelessWidget {
  const ArtistSongsCollapsedHeader({
    super.key,
    required this.isScrolledUnder,
    required this.artist,
    required this.filter,
    required this.totalSongs,
  });

  final bool isScrolledUnder;
  final String artist;
  final String filter;
  final int totalSongs;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isScrolledUnder ? context.colors.neutralSecondary : context.colors.neutralPrimary,
      child: Padding(
        padding: EdgeInsets.only(
          left: context.appDimensionScheme.screenMargin,
          right: context.appDimensionScheme.screenMargin,
        ),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.appDimensionScheme.screenMargin),
              Text(
                artist,
                style: context.typography.title5,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                context.text.artistTotalSongsAndFilter(totalSongs, filter),
                style: context.typography.subtitle5,
              ),
              SizedBox(
                height: context.appDimensionScheme.artistSongsHeaderSpace,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
