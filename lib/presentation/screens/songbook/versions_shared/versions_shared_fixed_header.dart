import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/widgets/list_order_type.dart';
import 'package:cifraclub/presentation/widgets/filter_capsule/filter.dart';
import 'package:cifraclub/presentation/widgets/filter_capsule/filter_capsule_list.dart';
import 'package:flutter/material.dart';

class VersionsSharedFixedHeader extends StatefulWidget {
  const VersionsSharedFixedHeader({
    super.key,
    required this.isScrolledUnder,
    required this.selectedOrderType,
    required this.onSelectedOrderType,
    required this.listType,
  });

  final bool isScrolledUnder;
  final ListOrderType selectedOrderType;
  final Function(ListOrderType) onSelectedOrderType;
  final ListType listType;

  @override
  State<VersionsSharedFixedHeader> createState() => _VersionsFixedHeaderState();
}

class _VersionsFixedHeaderState extends State<VersionsSharedFixedHeader> {
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: false,
      delegate: VersionFixedHeaderDelegate(
        maxExtend: 56,
        child: Padding(
          padding: EdgeInsets.only(bottom: context.appDimensionScheme.screenMargin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FilterCapsuleList(
                alignment: Alignment.center,
                capsulePadding: const EdgeInsets.symmetric(horizontal: 8),
                filters: [
                  ...ListOrderType.getValuesForSharedList().map(
                    (order) {
                      return Filter(
                        label: order.getName(context),
                        onTap: () => widget.onSelectedOrderType(order), // coverage:ignore-line
                        isSelected: order == widget.selectedOrderType,
                      );
                    },
                  ).toList()
                ],
              ),
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
