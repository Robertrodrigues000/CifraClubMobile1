// coverage:ignore-file
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/widgets/filter_capsule/filter.dart';
import 'package:cifraclub/presentation/widgets/filter_capsule/filter_capsule.dart';
import 'package:flutter/material.dart';

class FilterCapsuleList extends StatelessWidget {
  final List<Filter> filters;
  final EdgeInsets capsulePadding;
  final Alignment? alignment;
  const FilterCapsuleList({
    super.key,
    required this.filters,
    this.capsulePadding = EdgeInsets.zero,
    this.scrollController,
    this.alignment,
  });

  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32 + capsulePadding.vertical,
      alignment: alignment,
      child: ListView.builder(
        shrinkWrap: alignment == null ? false : true,
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        controller: scrollController,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isFirstCapsule = index == 0;
          final isLastCapsule = index == filters.length - 1;
          return Padding(
            padding: EdgeInsets.only(
                left: isFirstCapsule ? context.appDimensionScheme.screenMargin : capsulePadding.left,
                right: isLastCapsule ? context.appDimensionScheme.screenMargin : 0,
                top: capsulePadding.top,
                bottom: capsulePadding.bottom),
            child: FilterCapsule(
              key: ValueKey(filter.label),
              label: filter.label,
              isSelected: filter.isSelected,
              onTap: filter.onTap,
              trailingIconUri: filter.trailingIconUri,
              leadingIconUri: filter.leadingIconUri,
            ),
          );
        },
      ),
    );
  }
}
