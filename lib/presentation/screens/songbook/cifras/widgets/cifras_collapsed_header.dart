import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/extensions/text_style.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CifrasCollapsedHeader extends StatefulWidget {
  const CifrasCollapsedHeader({
    super.key,
    required this.isScrolledUnder,
    required this.songbookName,
    required this.isPublic,
  });
  final bool isScrolledUnder;
  final String songbookName;
  final bool isPublic;

  @override
  State<CifrasCollapsedHeader> createState() => _CifrasCollapsedHeaderState();
}

class _CifrasCollapsedHeaderState extends State<CifrasCollapsedHeader> {
  late double heightCollapseHeader;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final textHeight = _getTextHeight(
      widget.songbookName,
      context.typography.title3,
      context,
      context.appDimensionScheme.screenMargin,
      !widget.isPublic,
    );
    heightCollapseHeader = 36 + (context.appDimensionScheme.screenMargin * 2) + 16 + textHeight;
  }

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: false,
      delegate: CifrasCollapsedHeaderDelegate(
        maxExtend: heightCollapseHeader,
        isScrolledUnder: widget.isScrolledUnder,
        isPublic: widget.isPublic,
        songbookName: widget.songbookName,
      ),
    );
  }

  double _getTextHeight(String richText, TextStyle style, BuildContext context, double padding, bool havePreffix) {
    final screenWidth = MediaQuery.of(context).size.width;
    double maxWidth = screenWidth - (padding * 2);
    if (havePreffix) {
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

class CifrasCollapsedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double maxExtend;
  final bool isScrolledUnder;
  final String songbookName;
  final bool isPublic;

  CifrasCollapsedHeaderDelegate({
    required this.maxExtend,
    required this.isScrolledUnder,
    required this.isPublic,
    required this.songbookName,
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
      child: Padding(
        padding: EdgeInsets.only(
          left: context.appDimensionScheme.screenMargin,
          right: context.appDimensionScheme.screenMargin,
          bottom: 16,
        ),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              SizedBox(height: context.appDimensionScheme.screenMargin),
              Container(
                height: 36,
                color: Colors.blue,
              ),
              SizedBox(height: context.appDimensionScheme.screenMargin),
              RichText(
                text: TextSpan(
                  children: [
                    if (!isPublic)
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 4, bottom: 4),
                          child: SvgPicture.asset(
                            AppSvgs.privacyJustMeIcon,
                            width: 16,
                            height: 16,
                            color: context.colors.textSecondary,
                          ),
                        ),
                      ),
                    TextSpan(
                      text: songbookName,
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
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate is! CifrasCollapsedHeaderDelegate ||
        oldDelegate.isScrolledUnder != isScrolledUnder ||
        oldDelegate.isPublic != isPublic ||
        oldDelegate.songbookName != songbookName;
  }
}
