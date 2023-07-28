import 'package:cifraclub/extensions/build_context.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class ArtistSongsFixedHeader extends StatefulWidget {
  const ArtistSongsFixedHeader({
    super.key,
    required this.isScrolledUnder,
    required this.tabController,
    required this.pageController,
    required this.shouldShowSearch,
  });

  final bool isScrolledUnder;
  final TabController tabController;
  final PageController pageController;
  final bool shouldShowSearch;

  @override
  State<ArtistSongsFixedHeader> createState() => _ArtistSongsFixedHeaderState();
}

class _ArtistSongsFixedHeaderState extends State<ArtistSongsFixedHeader> {
  static const _headerHeightWithSearchAndTabs = 108.0;
  static const _headerHeightWithTabsOnly = 52.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: ArtistSongsFixedHeaderDelegate(
        maxExtend: widget.shouldShowSearch ? _headerHeightWithSearchAndTabs : _headerHeightWithTabsOnly,
        child: Column(
          children: [
            TabBar(
              controller: widget.tabController,
              labelPadding: const EdgeInsets.symmetric(vertical: 15),
              indicatorWeight: 3,
              onTap: widget.pageController.jumpToPage,
              splashFactory: NoSplash.splashFactory,
              overlayColor: MaterialStateProperty.resolveWith((_) => Colors.transparent),
              dividerColor: context.colors.neutralTertiary,
              tabs: [
                Text(
                  context.text.mostAccessed,
                  style: context.typography.subtitle4,
                ),
                Text(
                  context.text.alphabeticalOrder,
                  style: context.typography.subtitle4,
                ),
                Text(
                  context.text.videoLessons,
                  style: context.typography.subtitle4,
                ),
              ],
            ),
            if (widget.shouldShowSearch)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.appDimensionScheme.screenMargin, vertical: 8),
                child: CosmosSearchBar(
                  onChanged: (_) {},
                  onTapClear: () {},
                  textEditingController: TextEditingController(),
                  focusNode: FocusNode(),
                  cancelText: context.text.cancel,
                  hintText: context.text.searchSongs,
                  labelText: context.text.searchSongs,
                  invertColorsOnScroll: true,
                ),
              )
          ],
        ),
        haveScroll: widget.isScrolledUnder,
      ),
    );
  }
}

class ArtistSongsFixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double maxExtend;
  final Widget child;
  final bool haveScroll;

  ArtistSongsFixedHeaderDelegate({
    required this.maxExtend,
    required this.child,
    required this.haveScroll,
  });

  @override
  double get maxExtent => maxExtend;

  @override
  double get minExtent => maxExtend;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: maxExtend,
      color: haveScroll ? context.colors.neutralSecondary : context.colors.neutralPrimary,
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate is! ArtistSongsFixedHeaderDelegate ||
        oldDelegate.haveScroll != haveScroll ||
        oldDelegate.child != child;
  }
}
