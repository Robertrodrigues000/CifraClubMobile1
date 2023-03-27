import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/filter_capsule/filter.dart';
import 'package:cifraclub/presentation/widgets/filter_capsule/filter_capsule_list.dart';
import 'package:flutter/material.dart';

class GenresCapsule extends StatelessWidget {
  GenresCapsule({
    super.key,
    required this.genres,
    required this.selectedGenre,
    required this.onGenreSelected,
    required this.onMore,
  });

  final List<Genre> genres;
  final String? selectedGenre;
  final Function(String?) onGenreSelected;
  final Future<bool> Function() onMore;

  final ScrollController _scrollController = ScrollController();

  void _scrollToInit() {
    _scrollController.animateTo(
      _scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.decelerate,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FilterCapsuleList(
      capsulePadding: const EdgeInsets.symmetric(horizontal: 8),
      scrollController: _scrollController,
      filters: [
        Filter(
          label: context.text.all,
          onTap: () => onGenreSelected(null),
          isSelected: selectedGenre == null,
        ),
        if (genres.isNotEmpty)
          ...genres
              .map(
                (genre) => Filter(
                  label: genre.name,
                  onTap: () => onGenreSelected(genre.url),
                  isSelected: selectedGenre == genre.url,
                ),
              )
              .toList(),
        Filter(
          label: context.text.more,
          onTap: () async {
            final isSuccess = await onMore();
            if (isSuccess) {
              _scrollToInit();
            }
          },
          isSelected: false,
          trailingIconUri: AppSvgs.dropdownIcon,
        ),
      ],
    );
  }
}
