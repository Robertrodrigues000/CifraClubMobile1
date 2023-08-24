import 'package:cifraclub/extensions/build_context.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class ArtistSongsFixedHeader extends StatefulWidget {
  const ArtistSongsFixedHeader({
    super.key,
    required this.isScrolledUnder,
    required this.tabController,
    required this.onSearchStringChanged,
    required this.shouldShowSearch,
  });

  final bool isScrolledUnder;
  final TabController tabController;
  final Function(String) onSearchStringChanged;
  final bool shouldShowSearch;

  @override
  State<ArtistSongsFixedHeader> createState() => _ArtistSongsFixedHeaderState();
}

class _ArtistSongsFixedHeaderState extends State<ArtistSongsFixedHeader> {
  late double _headerHeightWithSearchAndTabs;
  static const _headerHeightWithTabsOnly = 49.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // tab bar height + search bar height + divider + search vertical padding
    _headerHeightWithSearchAndTabs = 49 + 40 + (2 * context.appDimensionScheme.highlightCardBorderRadius);
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.shouldShowSearch) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
    return SliverPersistentHeader(
      pinned: true,
      delegate: ArtistSongsFixedHeaderDelegate(
        maxExtend: widget.shouldShowSearch ? _headerHeightWithSearchAndTabs : _headerHeightWithTabsOnly,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: context.colors.neutralTertiary))),
                child: TabBar(
                  controller: widget.tabController,
                  labelPadding: EdgeInsets.symmetric(horizontal: context.appDimensionScheme.screenMargin),
                  indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(color: context.colors.primary, width: 2),
                      borderRadius: BorderRadius.circular(3)),
                  unselectedLabelColor: context.colors.textSecondary,
                  labelStyle: context.typography.subtitle4,
                  labelColor: context.colors.textPrimary,
                  indicatorSize: TabBarIndicatorSize.label,
                  //onTap: widget.pageController.jumpToPage,
                  isScrollable: true,
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: MaterialStateProperty.resolveWith((_) => Colors.transparent),
                  dividerColor: Colors.transparent,
                  tabs: [
                    Tab(
                      text: context.text.mostAccessed,
                    ),
                    Tab(
                      text: context.text.alphabeticalOrder,
                    ),
                    Tab(
                      text: context.text.videoLessons,
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: widget.shouldShowSearch,
              maintainState: true,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.appDimensionScheme.screenMargin,
                    vertical: context.appDimensionScheme.highlightCardBorderRadius),
                child: CosmosSearchBar(
                  // coverage:ignore-start
                  onChanged: widget.onSearchStringChanged,
                  onTapClear: () {
                    widget.onSearchStringChanged("");
                  },
                  // coverage:ignore-end
                  textEditingController: TextEditingController(),
                  focusNode: FocusNode(),
                  cancelText: context.text.cancel,
                  hintText: context.text.searchSongs,
                  labelText: context.text.searchSongs,
                  invertColorsOnScroll: true,
                ),
              ),
            ),
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
