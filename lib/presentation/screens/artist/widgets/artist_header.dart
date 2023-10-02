import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/extensions/color.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/constants/app_webp.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/artist_header_placeholder.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/artist_header_tag.dart';
import 'package:cifraclub/presentation/widgets/color_approximator.dart';
import 'package:cifraclub/presentation/widgets/remote_image/remote_image.dart';
import 'package:cifraclub/presentation/widgets/svg_image.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nav/nav.dart';

class ArtistHeader extends StatefulWidget {
  const ArtistHeader({
    super.key,
    required this.scrollController,
    required this.maxOffset,
    required this.genreName,
    required this.artistName,
    required this.image,
    required this.color,
    required this.onFavorite,
    required this.onShare,
    required this.isLoading,
    required this.isFavorite,
  });

  final ScrollController scrollController;
  final double maxOffset;
  final String genreName;
  final String artistName;
  final String image;
  final String color;
  final VoidCallback onFavorite;
  final VoidCallback onShare;
  final bool isLoading;
  final bool isFavorite;

  @override
  State<ArtistHeader> createState() => _ArtistHeaderState();
}

class _ArtistHeaderState extends State<ArtistHeader> {
  var isScrolledUnder = false;
  double _expandedOpacity = 1.0;
  double _collapsedOpacity = 0.0;

  void _onScroll() {
    final currentOffset = widget.scrollController.offset;
    final oldIsScrollUnder = isScrolledUnder;
    isScrolledUnder = currentOffset > widget.maxOffset ? true : false;
    double scrollPercentage = (currentOffset / widget.maxOffset).clamp(0, 1);

    if (currentOffset <= widget.maxOffset || isScrolledUnder != oldIsScrollUnder) {
      setState(() {
        _expandedOpacity = isScrolledUnder ? 0.0 : 1.0 - Curves.easeOutCirc.transform(scrollPercentage);
        _collapsedOpacity = isScrolledUnder ? 1.0 : 1.0 - _expandedOpacity;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      expandedHeight: context.appDimensionScheme.artistHeaderHeight,
      leadingWidth: context.appDimensionScheme.appBarLeadingWidth,
      automaticallyImplyLeading: false,
      title: Opacity(
        key: const Key("collapsed title"),
        opacity: _collapsedOpacity,
        child: Text(
          widget.artistName,
          style: context.typography.title5.copyWith(color: Colors.white),
        ),
      ),
      leading: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(width: context.appDimensionScheme.appBarMargin),
          IconButton(
            // coverage:ignore-start
            onPressed: () => Nav.of(context).pop(),
            // coverage:ignore-end
            splashRadius: 28,
            padding: const EdgeInsets.all(12),
            highlightColor: Theme.of(context).splashColor,
            icon: SizedBox(
              height: 24,
              width: 24,
              child: SvgPicture.asset(
                AppSvgs.backArrowIcon,
                fit: BoxFit.none,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: widget.color.isNotEmpty
          ? ColorApproximator.of(context).getNearestColor(context, HexColor.fromHex(widget.color))
          : CosmosColors.grey40,
      actions: !widget.isLoading
          ? [
              IconButton(
                key: const Key("favorite button"),
                onPressed: widget.onFavorite,
                splashRadius: 28,
                padding: const EdgeInsets.all(12),
                highlightColor: Theme.of(context).splashColor,
                icon: SvgImage(
                  assetPath: widget.isFavorite ? AppSvgs.filledFavoriteIcon : AppSvgs.favoriteIcon,
                  color: Colors.white,
                  height: 24,
                  width: 24,
                ),
              ),
              IconButton(
                key: const Key("share button"),
                onPressed: widget.onShare,
                splashRadius: 28,
                padding: const EdgeInsets.all(12),
                highlightColor: Theme.of(context).splashColor,
                icon: const SvgImage(
                  assetPath: AppSvgs.shareIcon,
                  color: Colors.white,
                  height: 24,
                  width: 24,
                ),
              ),
              SizedBox(
                width: context.appDimensionScheme.appBarMargin,
              ),
            ]
          : null,
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1.25,
        titlePadding: EdgeInsetsDirectional.only(
          start: context.appDimensionScheme.screenMargin,
          bottom: 16.0,
        ),
        title: Opacity(
          opacity: _expandedOpacity,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.genreName.isNotEmpty)
                  ArtistHeaderTag(
                    color: widget.color.isNotEmpty ? HexColor.fromHex(widget.color) : CosmosColors.grey40,
                    genreName: widget.genreName,
                  ),
                Text(
                  widget.artistName,
                  style: context.typography.title5.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        background: widget.isLoading
            ? HeaderPlaceholder(
                height: context.appDimensionScheme.artistHeaderHeight, placeholder: AppWebp.largePlaceholder)
            : RemoteImage(
                // coverage:ignore-start
                imageUrl: widget.image,
                imageBuilder: (context, imageProvider) {
                  return Opacity(
                    opacity: _expandedOpacity,
                    child: ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          CosmosColors.black.withOpacity(1),
                          CosmosColors.black.withOpacity(0),
                        ],
                      ).createShader(bounds),
                      blendMode: BlendMode.srcOver,
                      child: Container(
                        height: context.appDimensionScheme.artistHeaderHeight,
                        decoration: BoxDecoration(
                          color: HexColor.fromHex(widget.color),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                placeholder: HeaderPlaceholder(
                    height: context.appDimensionScheme.artistHeaderHeight, placeholder: AppWebp.artistPlaceholder),
                errorWidget: !widget.isLoading
                    ? (context, _, __) => HeaderPlaceholder(
                        height: context.appDimensionScheme.artistHeaderHeight, placeholder: AppWebp.artistPlaceholder)
                    : null,
                // coverage:ignore-end
              ),
      ),
    );
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }
}
