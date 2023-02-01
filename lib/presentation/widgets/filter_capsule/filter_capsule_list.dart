// coverage:ignore-file
import 'package:cifraclub/presentation/widgets/filter_capsule/filter.dart';
import 'package:cifraclub/presentation/widgets/filter_capsule/filter_capsule.dart';
import 'package:flutter/material.dart';

class FilterCapsuleList extends StatelessWidget {
  final List<Filter> filters;
  final EdgeInsets padding;
  const FilterCapsuleList({
    super.key,
    required this.filters,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32 + padding.vertical,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          return Padding(
            padding: padding,
            child: FilterCapsule(
              key: ValueKey(filter.label),
              label: filter.label,
              isSelected: filter.isSelected,
              onTap: filter.onTap,
            ),
          );
        },
      ),
    );
  }
}
