// coverage:ignore-file
import 'package:cifraclub/presentation/widgets/filter_capsule/filter.dart';
import 'package:cifraclub/presentation/widgets/filter_capsule/filter_capsule.dart';
import 'package:flutter/material.dart';

class FilterCapsuleList extends StatelessWidget {
  final List<Filter> filters;
  final EdgeInsets capsulePadding;
  const FilterCapsuleList({
    super.key,
    required this.filters,
    this.capsulePadding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32 + capsulePadding.vertical,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isFirstCapsule = index == 0;
          final isLastCapsule = index == filters.length - 1;
          return Padding(
            padding: EdgeInsets.only(
                left: isFirstCapsule ? 16.0 : capsulePadding.left,
                right: isLastCapsule ? 16.0 : capsulePadding.right,
                top: capsulePadding.top,
                bottom: capsulePadding.bottom),
            child: FilterCapsule(
              key: ValueKey(filter.label),
              label: filter.label,
              isSelected: filter.isSelected,
              onTap: filter.onTap,
              trailingIconUri: filter.trailingIconUri,
            ),
          );
        },
      ),
    );
  }
}
