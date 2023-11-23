// coverage:ignore-file
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/version/models/version_filter.dart';
import 'package:cifraclub/presentation/widgets/filter_capsule/filter.dart';
import 'package:cifraclub/presentation/widgets/filter_capsule/filter_capsule_list.dart';
import 'package:cifraclub/presentation/widgets/svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class VersionHeader extends StatelessWidget {
  final String songName;
  final String artistName;
  final VoidCallback onTapArtistName;
  final bool isFavorite;
  final VoidCallback onTapFavoriteIcon;
  final VoidCallback onTapOptionsIcon;
  final List<VersionFilter> filters;
  final VersionFilter? selectedFilter;
  final Function(VersionFilter) onTapFilter;
  final VoidCallback onTapMoreFilters;
  final bool restrictContent;
  final bool isScrolledUnder;

  const VersionHeader({
    super.key,
    required this.songName,
    required this.artistName,
    required this.onTapArtistName,
    required this.isFavorite,
    required this.onTapFavoriteIcon,
    required this.onTapOptionsIcon,
    required this.filters,
    required this.selectedFilter,
    required this.onTapFilter,
    required this.onTapMoreFilters,
    required this.restrictContent,
    required this.isScrolledUnder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isScrolledUnder ? context.colors.neutralSecondary : context.colors.neutralPrimary,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(context.appDimensionScheme.screenMargin),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: songName,
                              style: context.typography.title6,
                            ),
                            if (restrictContent)
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 4, bottom: 2),
                                  child: SvgPicture.asset(
                                    AppSvgs.blockedContentLock,
                                    width: 16,
                                    height: 16,
                                    color: context.colors.textPrimary,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      InkWell(
                        onTap: onTapArtistName,
                        child: Text(
                          artistName,
                          style: context.typography.title7.copyWith(color: context.colors.primary),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (!restrictContent)
                Padding(
                  padding: EdgeInsets.only(top: context.appDimensionScheme.appBarMargin),
                  child: Row(
                    children: [
                      IconButton(
                        key: const Key("favorite button"),
                        onPressed: onTapFavoriteIcon,
                        splashRadius: 28,
                        padding: const EdgeInsets.all(12),
                        highlightColor: Theme.of(context).splashColor,
                        icon: SvgImage(
                          assetPath: isFavorite ? AppSvgs.filledFavoriteIcon : AppSvgs.favoriteIcon,
                          color: context.colors.textPrimary,
                          height: 24,
                          width: 24,
                        ),
                      ),
                      IconButton(
                        key: const Key("overflow button"),
                        onPressed: onTapOptionsIcon,
                        splashRadius: 28,
                        padding: const EdgeInsets.all(12),
                        highlightColor: Theme.of(context).splashColor,
                        icon: SvgImage(
                          assetPath: AppSvgs.overflowIcon,
                          color: context.colors.textPrimary,
                          height: 24,
                          width: 24,
                        ),
                      ),
                      SizedBox(
                        width: context.appDimensionScheme.appBarMargin,
                      )
                    ],
                  ),
                ),
            ],
          ),
          if (!restrictContent)
            FilterCapsuleList(
              capsulePadding: const EdgeInsets.symmetric(horizontal: 8),
              filters: [
                ...filters
                    .map(
                      (filter) => Filter(
                        label: filter.versionName,
                        isSelected: filter == selectedFilter,
                        onTap: () => onTapFilter(filter),
                        leadingIconUri: filter.isVerified ? AppSvgs.verifiedIcon : null,
                      ),
                    )
                    .toList(),
                Filter(
                  label: context.text.more,
                  onTap: onTapMoreFilters,
                  isSelected: false,
                  trailingIconUri: AppSvgs.dropdownIcon,
                ),
              ],
            ),
          SizedBox(
            height: context.appDimensionScheme.screenMargin,
          ),
        ],
      ),
    );
  }
}
