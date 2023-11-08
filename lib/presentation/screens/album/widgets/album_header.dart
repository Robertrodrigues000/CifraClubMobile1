import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/extensions/color.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/constants/app_webp.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/artist_header_placeholder.dart';
import 'package:cifraclub/presentation/widgets/color_approximator.dart';
import 'package:cifraclub/presentation/widgets/default_placeholder.dart';
import 'package:cifraclub/presentation/widgets/remote_image/remote_image.dart';
import 'package:cifraclub/presentation/widgets/svg_image.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nav/nav.dart';

class AlbumHeader extends StatefulWidget {
  const AlbumHeader({
    super.key,
    required this.scrollController,
    required this.maxOffset,
    required this.artistName,
    required this.albumName,
    required this.image,
    required this.color,
    required this.isLoading,
    required this.albumThumbSize,
    required this.totalSongs,
    required this.releaseYear,
    required this.onShare,
    required this.isError,
    required this.onTapArtistName,
  });

  final ScrollController scrollController;
  final double maxOffset;
  final String artistName;
  final String albumName;
  final int totalSongs;
  final int? releaseYear;
  final String image;
  final double albumThumbSize;
  final String color;
  final bool isLoading;
  final bool isError;
  final VoidCallback onShare;
  final VoidCallback onTapArtistName;

  @override
  State<AlbumHeader> createState() => _ArtistHeaderState();
}

class _ArtistHeaderState extends State<AlbumHeader> {
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
      expandedHeight: context.appDimensionScheme.albumHeaderHeight,
      leadingWidth: context.appDimensionScheme.appBarLeadingWidth,
      automaticallyImplyLeading: false,
      title: Opacity(
        key: const Key("collapsed title"),
        opacity: _collapsedOpacity,
        child: Text(
          widget.albumName,
          style: context.typography.title5.copyWith(color: Colors.white),
        ),
      ),
      actions: [
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
        )
      ],
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
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1.0,
        titlePadding: EdgeInsetsDirectional.only(
          start: context.appDimensionScheme.screenMargin,
        ),
        background: widget.isLoading || widget.isError
            ? HeaderPlaceholder(
                height: context.appDimensionScheme.artistHeaderHeight,
                placeholder: widget.isError ? AppWebp.artistPlaceholder : AppWebp.largePlaceholder)
            : null,
        title: !widget.isLoading && !widget.isError
            ? Opacity(
                key: const Key("Header content"),
                opacity: _expandedOpacity,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: SizedBox(
                    height: context.appDimensionScheme.albumHeaderThumbHeight + 32,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RemoteImage(
                          // coverage:ignore-start
                          imageUrl: widget.image,
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              width: widget.albumThumbSize,
                              height: widget.albumThumbSize,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                          // coverage:ignore-end
                          placeholder: DefaultPlaceholder(
                            height: widget.albumThumbSize,
                            width: widget.albumThumbSize,
                            svgIcon: AppSvgs.albumPlaceholder,
                            isLarge: true,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.ideographic,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                child: RichText(
                                  text: TextSpan(
                                    text: "${context.text.albumOf} ",
                                    style: context.typography.subtitle7.copyWith(color: Colors.white),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: widget.artistName,
                                        recognizer: TapGestureRecognizer()..onTap = widget.onTapArtistName,
                                        style: const TextStyle(
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  widget.albumName,
                                  style: context.typography.title5.copyWith(color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                  textWidthBasis: TextWidthBasis.longestLine,
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  "${widget.totalSongs} ${context.text.songs(widget.totalSongs)}${widget.releaseYear != null ? ' • ${widget.releaseYear}' : ''}",
                                  style: context.typography.subtitle5.copyWith(color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : null,
      ),
    );
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }
}
