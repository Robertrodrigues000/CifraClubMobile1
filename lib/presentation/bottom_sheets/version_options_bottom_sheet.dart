import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/bottom_sheets/save_version_to_list_bottom_sheet/save_version_to_list_bottom_sheet.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/bottom_sheets/default_bottom_sheet.dart';
import 'package:cifraclub/presentation/widgets/icon_text_tile.dart';
import 'package:flutter/material.dart';

class VersionOptionsBottomSheet {
  final SaveVersionToListBottomSheet saveToListbottomSheet;
  const VersionOptionsBottomSheet(this.saveToListbottomSheet);

  // coverage:ignore-start
  Future<void> open({
    required BuildContext screenContext,
    required String artistUrl,
    required String songUrl,
  }) {
    return _show(screenContext, artistUrl, songUrl);
  }
  // coverage:ignore-end

  Future<void> _show(
    BuildContext screenContext,
    String artistUrl,
    String songUrl,
  ) {
    final controller = ScrollController();

    final options = List<VersionOptionsBottomSheetItem>.from(VersionOptionsBottomSheetItem.values);

    return DefaultBottomSheet.showBottomSheet(
      child: Builder(
        builder: (context) {
          return SingleChildScrollView(
            controller: controller,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.appDimensionScheme.screenMargin),
                  child: Text(
                    context.text.versionOptionsBottomSheet,
                    style: context.typography.title3,
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
                            Navigator.of(context).pop();
                            await saveToListbottomSheet.show(
                                context: screenContext, artistUrl: artistUrl, songUrl: songUrl);

                          case VersionOptionsBottomSheetItem.favoriteVersion:
                          case VersionOptionsBottomSheetItem.correctVersion:
                          case VersionOptionsBottomSheetItem.share:
                        }
                      },
                      // coverage:ignore-end
                      text: e.getText(context),
                      leadingIconAsset: e.icon,
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
      context: screenContext,
      scrollController: controller,
    );
  }
}

enum VersionOptionsBottomSheetItem {
  saveVersion(AppSvgs.saveVersionIcon),
  favoriteVersion(AppSvgs.favoriteVersionIcon),
  correctVersion(AppSvgs.correctVersionIcon),
  share(AppSvgs.shareIcon);

  final String icon;

  const VersionOptionsBottomSheetItem(this.icon);

  String getText(BuildContext context) {
    switch (this) {
      case VersionOptionsBottomSheetItem.saveVersion:
        return context.text.saveVersionToList;
      case VersionOptionsBottomSheetItem.favoriteVersion:
        return context.text.favoriteVersion;
      case VersionOptionsBottomSheetItem.correctVersion:
        return context.text.correctVersion;
      case VersionOptionsBottomSheetItem.share:
        return context.text.share;
    }
  }
}
