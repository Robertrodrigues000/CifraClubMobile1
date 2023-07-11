import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/version_limit_card.dart';
import 'package:flutter/material.dart';

class VersionsFixedHeader extends StatefulWidget {
  const VersionsFixedHeader({
    super.key,
    required this.isScrolledUnder,
    required this.isPro,
    required this.tabsLimitState,
    required this.tabsCount,
    required this.tabsLimit,
  });
  final bool isScrolledUnder;
  final bool isPro;
  final ListLimitState tabsLimitState;
  final int tabsCount;
  final int tabsLimit;

  @override
  State<VersionsFixedHeader> createState() => _VersionsFixedHeaderState();
}

class _VersionsFixedHeaderState extends State<VersionsFixedHeader> {
  late double heightFixedHeader;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    heightFixedHeader = 50 + 32 + (2 * context.appDimensionScheme.screenMargin);
  }

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: false,
      delegate: VersionFixedHeaderDelegate(
        maxExtend: heightFixedHeader,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: context.appDimensionScheme.screenMargin,
            left: context.appDimensionScheme.screenMargin,
            right: context.appDimensionScheme.screenMargin,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: VersionLimitCard(
                  isPro: widget.isPro,
                  isWithinLimit: widget.tabsLimitState == ListLimitState.withinLimit,
                  limit: widget.tabsLimit,
                  versionsCount: widget.tabsCount,
                  hasBackground: widget.isPro ? true : false,
                  onTap: () {}, // coverage:ignore-line
                ),
              ),
              SizedBox(height: context.appDimensionScheme.screenMargin),
              Container(
                height: 32,
                color: Colors.purpleAccent,
              )
            ],
          ),
        ),
        haveScroll: widget.isScrolledUnder,
      ),
    );
  }
}

class VersionFixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double maxExtend;
  final Widget child;
  final bool haveScroll;

  VersionFixedHeaderDelegate({
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
    return oldDelegate is! VersionFixedHeaderDelegate ||
        oldDelegate.haveScroll != haveScroll ||
        oldDelegate.child != child;
  }
}
