import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/thumb_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SongbookInformationSection extends StatelessWidget {
  const SongbookInformationSection({
    super.key,
    required this.isScrolledUnder,
    required this.songbookName,
    required this.isPublic,
    required this.preview,
    required this.listType,
    this.isPro,
    this.userName,
  });

  final bool isScrolledUnder;
  final String songbookName;
  final bool isPublic;
  final List<String> preview;
  final ListType listType;
  final bool? isPro;
  final String? userName;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isScrolledUnder ? context.colors.neutralSecondary : context.colors.neutralPrimary,
      padding: EdgeInsets.only(
        top: context.appDimensionScheme.screenMargin,
        left: context.appDimensionScheme.screenMargin,
        right: context.appDimensionScheme.screenMargin,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 36,
            child: listType == ListType.user
                ? ThumbRow.forCommonList(
                    context: context,
                    imageUrls: preview,
                    placeholder: AppSvgs.artistsAvatarPlaceHolder,
                  )
                : ThumbRow.forSpecialList(
                    imagePath: ListType.getListIconAsset(listType),
                    backgroundColor: ListType.getListIconColor(listType, context),
                    context: context,
                  ),
          ),
          SizedBox(height: context.appDimensionScheme.screenMargin),
          RichText(
            text: TextSpan(
              children: [
                if (!isPublic && listType == ListType.user)
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
                  text: songbookName,
                  style: context.typography.title5,
                ),
              ],
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          if (userName != null)
            Text(
              userName!,
              style: context.typography.subtitle3,
            ),
          if (isPro == false || listType != ListType.user)
            SizedBox(
              height: context.appDimensionScheme.scrollContentToBottom,
            ),
        ],
      ),
    );
  }
}
