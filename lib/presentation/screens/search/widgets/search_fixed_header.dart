import 'package:cifraclub/domain/search/models/search_filter.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/widgets/filter_capsule/filter.dart';
import 'package:cifraclub/presentation/widgets/filter_capsule/filter_capsule_list.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class SearchFixedHeader extends StatefulWidget {
  const SearchFixedHeader({super.key, required this.onTapFilter, required this.selectedFilter});

  final Function(SearchFilter?) onTapFilter;
  final SearchFilter? selectedFilter;

  @override
  State<SearchFixedHeader> createState() => _SearchFixedHeaderState();
}

class _SearchFixedHeaderState extends State<SearchFixedHeader> {
  final _scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SearchFixedHeaderDelegate(
        maxHeight: 48,
        child: Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 12),
          child: FilterCapsuleList(
            capsulePadding: const EdgeInsets.symmetric(horizontal: 8),
            scrollController: _scrollController,
            filters: [
              Filter(
                label: context.text.all,
                onTap: () => widget.onTapFilter(null),
                isSelected: widget.selectedFilter == null,
              ),
              if (SearchFilter.values.isNotEmpty)
                ...SearchFilter.values
                    .map(
                      (filter) => Filter(
                          label: filter.getSearchFilterName(context),
                          onTap: () => widget.onTapFilter(filter),
                          isSelected: widget.selectedFilter == filter),
                    )
                    .toList()
            ],
          ),
        ),
      ),
    );
  }
}

class SearchFixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  final Widget child;

  SearchFixedHeaderDelegate({
    required this.maxHeight,
    required this.child,
  });

  bool haveScroll = false;

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ScrolledUnderBuilder(
      builder: (context, isScrolledUnder) {
        haveScroll = isScrolledUnder;
        return Container(
          height: maxHeight,
          color: isScrolledUnder ? context.colors.neutralSecondary : context.colors.neutralPrimary,
          child: child,
        );
      },
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate is! SearchFixedHeaderDelegate ||
        oldDelegate.haveScroll != haveScroll ||
        oldDelegate.child != child;
  }
}
