import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/extensions/text_style.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/thumb_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VersionsCollapsedHeader extends StatefulWidget {
  const VersionsCollapsedHeader({
    super.key,
    required this.isScrolledUnder,
    required this.songbookName,
    required this.isPublic,
    this.preview,
    required this.isTablet,
    this.width,
  });
  final bool isScrolledUnder;
  final String songbookName;
  final bool isPublic;
  final List<String?>? preview;
  final bool isTablet;
  final double? width;

  @override
  State<VersionsCollapsedHeader> createState() => _VersionsCollapsedHeaderState();
}

class _VersionsCollapsedHeaderState extends State<VersionsCollapsedHeader> {
  late double heightCollapseHeader;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _calculateViewHeight();
  }

  @override
  void didUpdateWidget(covariant VersionsCollapsedHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.songbookName != widget.songbookName) {
      _calculateViewHeight(); // coverage:ignore-line
    }
  }

  void _calculateViewHeight() {
    final textHeight = _getTextHeight(
      widget.songbookName,
      context.typography.title3,
      context,
      context.appDimensionScheme.screenMargin,
      !widget.isPublic,
      widget.isTablet,
    );

    heightCollapseHeader = 36 + (context.appDimensionScheme.screenMargin * 2) + 16 + textHeight;
  }

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: false,
      delegate: VersionsCollapsedHeaderDelegate(
        maxExtend: heightCollapseHeader,
        isScrolledUnder: widget.isScrolledUnder,
        child: Padding(
          padding: EdgeInsets.only(
            left: context.appDimensionScheme.screenMargin,
            right: context.appDimensionScheme.screenMargin,
            bottom: 16,
          ),
          child: SingleChildScrollView(
            reverse: true,
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: context.appDimensionScheme.screenMargin),
                SizedBox(
                  height: 36,
                  child: ThumbRow.forCommonList(
                    context: context,
                    imageUrls: widget.preview
                            ?.map((e) => e != null ? "https://akamai.sscdn.co/letras/250x250/fotos/$e" : "")
                            .toList() ??
                        [],
                    placeholder: AppSvgs.artistsAvatarPlaceHolder,
                  ),
                ),
                SizedBox(height: context.appDimensionScheme.screenMargin),
                RichText(
                  text: TextSpan(
                    children: [
                      if (!widget.isPublic)
                        WidgetSpan(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4, bottom: 2),
                            child: SvgPicture.asset(
                              AppSvgs.privacyJustMeIcon,
                              width: 16,
                              height: 16,
                              color: context.colors.textSecondary,
                            ),
                          ),
                        ),
                      TextSpan(
                        text: widget.songbookName,
                        style: context.typography.title3,
                      ),
                    ],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double _getTextHeight(
    String richText,
    TextStyle style,
    BuildContext context,
    double padding,
    bool havePrefix,
    bool isTablet,
  ) {
    var screenWidth = MediaQuery.of(context).size.width;
    if (isTablet) {
      screenWidth -=
          widget.width!; //TODO : Esse valor tem que ser atualizado na issue que vai mudar o tamanho da tela de listas
    }
    double maxWidth = screenWidth - (padding * 2);
    if (havePrefix) {
      maxWidth -= 20;
    }

    final textPainter = style.getTextSize(
      context: context,
      text: richText,
      maxLines: 2,
      maxWidth: maxWidth,
    );

    return textPainter.height;
  }
}

class VersionsCollapsedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double maxExtend;
  final bool isScrolledUnder;
  final Widget child;

  VersionsCollapsedHeaderDelegate({
    required this.maxExtend,
    required this.isScrolledUnder,
    required this.child,
  });

  @override
  double get maxExtent => maxExtend;

  @override
  double get minExtent => 0;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: maxExtend,
      color: isScrolledUnder ? context.colors.neutralSecondary : context.colors.neutralPrimary,
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate is! VersionsCollapsedHeaderDelegate ||
        oldDelegate.isScrolledUnder != isScrolledUnder ||
        oldDelegate.child != child;
  }
}
