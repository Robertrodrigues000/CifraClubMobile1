import 'package:cifraclub/extensions/build_context.dart';
import 'package:flutter/material.dart';

class CifrasFixedHeader extends StatefulWidget {
  const CifrasFixedHeader({super.key, required this.isScrolledUnder});
  final bool isScrolledUnder;

  @override
  State<CifrasFixedHeader> createState() => _CifrasFixedHeaderState();
}

class _CifrasFixedHeaderState extends State<CifrasFixedHeader> {
  late double heightFixedHeader;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    heightFixedHeader = 50 + 32 + (3 * context.appDimensionScheme.screenMargin);
  }

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: false,
      delegate: CifraFixedHeaderDelegate(
        maxExtend: heightFixedHeader,
        child: Padding(
          padding: EdgeInsets.all(context.appDimensionScheme.screenMargin),
          child: Column(
            children: [
              Container(
                height: 50,
                color: Colors.amber,
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

class CifraFixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double maxExtend;
  final Widget child;
  final bool haveScroll;

  CifraFixedHeaderDelegate({
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
    return oldDelegate is! CifraFixedHeaderDelegate ||
        oldDelegate.haveScroll != haveScroll ||
        oldDelegate.child != child;
  }
}
