import 'package:cifraclub/domain/songbook/models/version_options_result.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/bottom_sheets/default_bottom_sheet.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/icon_text_tile.dart';
import 'package:flutter/material.dart';

class VersionOptionsSection extends StatelessWidget {
  const VersionOptionsSection(
      {super.key,
      required this.onSaveVersionToList,
      required this.onFavoriteVersion,
      required this.onShareVersion,
      required this.isVersionBottomSheet,
      required this.onFontSizeChanged,
      required this.isFavorite,
      required this.isPro});

  final VoidCallback onSaveVersionToList;
  final VoidCallback onFavoriteVersion;
  final VoidCallback onShareVersion;
  final VoidCallback onFontSizeChanged;
  final bool isVersionBottomSheet;
  final bool isFavorite;
  final bool isPro;

  @override
  Widget build(BuildContext context) {
    final options = isVersionBottomSheet
        ? List<VersionOptionsBottomSheetItem>.from(VersionOptionsBottomSheetItem.values)
        : (List<VersionOptionsBottomSheetItem>.from(VersionOptionsBottomSheetItem.values)
          ..remove(VersionOptionsBottomSheetItem.fontSize));

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.appDimensionScheme.screenMargin),
          child: Text(
            context.text.versionOptionsBottomSheet,
            style: context.typography.title5,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        ...options.map(
          (e) {
            return IconTextTile(
              // coverage:ignore-start
              onClick: () async {
                switch (e) {
                  case VersionOptionsBottomSheetItem.saveVersion:
                    if (context.mounted) {
                      DefaultBottomSheet.close(context);
                    }
                    onSaveVersionToList();
                  case VersionOptionsBottomSheetItem.favoriteVersion:
                    if (context.mounted) {
                      DefaultBottomSheet.close(context);
                    }
                    onFavoriteVersion();
                  case VersionOptionsBottomSheetItem.share:
                    onShareVersion();
                  case VersionOptionsBottomSheetItem.fontSize:
                    if (isPro) {
                      if (context.mounted) {
                        DefaultBottomSheet.close(context);
                      }
                      onFontSizeChanged();
                    }
                  case VersionOptionsBottomSheetItem.correctVersion:
                  //TODO
                }
              },
              // coverage:ignore-end
              text: e.getText(context, (e == VersionOptionsBottomSheetItem.favoriteVersion ? isFavorite : false)),
              leadingIconAsset: e.icon,
              trailingIcon: !isPro && e == VersionOptionsBottomSheetItem.fontSize ? AppSvgs.privacyJustMeIcon : null,
            );
          },
        )
      ],
    );
  }
}

// coverage:ignore-start
void handleResult(BuildContext context, VersionOptionsResult result) {
  switch (result) {
    case FavoriteVersionSuccess():
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.text.favoriteVersionMessage)));
    case UnFavoriteVersionSuccess():
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.text.unFavoriteVersionMessage)));
    case FavoriteVersionError():
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.text.favoriteVersionErrorMessage)));
    case UnFavoriteVersionError():
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.text.unFavoriteVersionErrorMessage)));
  }
}
// coverage:ignore-end

enum VersionOptionsBottomSheetItem {
  saveVersion(AppSvgs.saveVersionIcon),
  favoriteVersion(AppSvgs.favoriteVersionIcon),
  correctVersion(AppSvgs.correctVersionIcon),
  share(AppSvgs.shareIcon),
  fontSize(AppSvgs.fontSizeIcon);

  final String icon;

  const VersionOptionsBottomSheetItem(this.icon);

  String getText(BuildContext context, bool isFavorite) {
    switch (this) {
      case VersionOptionsBottomSheetItem.saveVersion:
        return context.text.saveVersionToList;
      case VersionOptionsBottomSheetItem.favoriteVersion:
        return isFavorite ? context.text.unFavoriteVersion : context.text.favoriteVersion;
      case VersionOptionsBottomSheetItem.correctVersion:
        return context.text.correctVersion;
      case VersionOptionsBottomSheetItem.share:
        return context.text.share;
      case VersionOptionsBottomSheetItem.fontSize:
        return context.text.fontSize;
    }
  }
}
