import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/extensions/text_style.dart';
import 'package:flutter/material.dart';

class ArtistSongsCollapsedHeader extends StatefulWidget {
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
  State<ArtistSongsCollapsedHeader> createState() => _ArtistSongsCollapsedHeaderState();
}

class _ArtistSongsCollapsedHeaderState extends State<ArtistSongsCollapsedHeader> {
  late double heightCollapseHeader;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final textHeight =
        _getTextHeight(widget.artist, context.typography.title5, context, context.appDimensionScheme.screenMargin);
    heightCollapseHeader = (context.appDimensionScheme.artistSongsHeaderSpace) +
        (context.appDimensionScheme.screenMargin) +
        30 +
        textHeight;
  }

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: true,
      delegate: ArtistSongsCollapsedHeaderDelegate(
        maxExtend: heightCollapseHeader,
        haveScroll: widget.isScrolledUnder,
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
                  widget.artist,
                  style: context.typography.title5,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  context.text.artistTotalSongsAndFilter(widget.totalSongs, widget.filter),
                  style: context.typography.subtitle5,
                ),
                SizedBox(
                  height: context.appDimensionScheme.artistSongsHeaderSpace,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double _getTextHeight(
    String richText,
    TextStyle style,
    BuildContext context,
    double padding,
  ) {
    var screenWidth = MediaQuery.of(context).size.width;
    double maxWidth = screenWidth - (padding * 2);

    final textPainter = style.getTextSize(
      context: context,
      text: richText,
      maxLines: 2,
      maxWidth: maxWidth,
    );

    return textPainter.height;
  }
}

class ArtistSongsCollapsedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double maxExtend;
  final Widget child;
  final bool haveScroll;

  ArtistSongsCollapsedHeaderDelegate({required this.maxExtend, required this.child, required this.haveScroll});

  @override
  double get maxExtent => maxExtend;

  @override
  double get minExtent => 0;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        height: maxExtend,
        color: haveScroll ? context.colors.neutralSecondary : context.colors.neutralPrimary,
        child: child);
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate is! ArtistSongsCollapsedHeaderDelegate ||
        oldDelegate.haveScroll != haveScroll ||
        oldDelegate.child != child;
  }
}
