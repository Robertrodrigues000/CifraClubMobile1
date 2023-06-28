import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/bottom_sheets/default_bottom_sheet.dart';
import 'package:cifraclub/presentation/widgets/icon_text_tile.dart';
import 'package:flutter/material.dart';

class ListOptionsBottomSheet extends StatelessWidget {
  final Function(ListOptionsBottomSheetItem, [Rect?]) onTap;
  final bool isUserList;
  final int? ccid;
  final int? songbookId;
  final bool isPublic;
  final ScrollController? scrollController;

  const ListOptionsBottomSheet({
    super.key,
    required this.isUserList,
    required this.onTap,
    required this.isPublic,
    this.scrollController,
    this.ccid,
    this.songbookId,
  });

  void show(BuildContext context) {
    final controller = ScrollController();

    DefaultBottomSheet.showBottomSheet(
      child: ListOptionsBottomSheet(
        isUserList: isUserList,
        onTap: onTap,
        scrollController: controller,
        ccid: ccid,
        songbookId: songbookId,
        isPublic: isPublic,
      ),
      context: context,
      scrollController: controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    final options = List<ListOptionsBottomSheetItem>.from(ListOptionsBottomSheetItem.values);
    if (songbookId == null || ccid == null || !isPublic) {
      options.removeWhere((element) => element == ListOptionsBottomSheetItem.share);
    }

    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.appDimensionScheme.screenMargin),
            child: Text(
              context.text.listOptions,
              style: context.typography.title3,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          if (isUserList)
            ...options.map(
              (e) {
                if (e == ListOptionsBottomSheetItem.share) {
                  return IconTextTile(
                    onClick: () {
                      final box = context.findRenderObject() as RenderBox?;
                      final rect = box != null ? box.localToGlobal(Offset.zero) & box.size : null;
                      DefaultBottomSheet.close(context);
                      onTap(e, rect);
                    },
                    text: e.getText(context),
                    leadingIconAsset: e.icon,
                  );
                } else {
                  return IconTextTile(
                    onClick: () {
                      DefaultBottomSheet.close(context);
                      onTap(e);
                    },
                    text: e.getText(context),
                    leadingIconAsset: e.icon,
                  );
                }
              },
            )
          else
            IconTextTile(
              onClick: () {
                onTap(ListOptionsBottomSheetItem.clear);
                DefaultBottomSheet.close(context);
              },
              text: ListOptionsBottomSheetItem.clear.getText(context),
              leadingIconAsset: ListOptionsBottomSheetItem.clear.icon,
            ),
          const SizedBox(height: 16)
        ],
      ),
    );
  }
}

enum ListOptionsBottomSheetItem {
  share(AppSvgs.shareIcon),
  rename(AppSvgs.musicalStylesIcon),
  clear(AppSvgs.clearIcon),
  delete(AppSvgs.deleteIcon),
  privacy(AppSvgs.privacyIcon);

  final String icon;

  const ListOptionsBottomSheetItem(this.icon);

  String getText(BuildContext context) {
    switch (this) {
      case ListOptionsBottomSheetItem.share:
        return context.text.shareList;
      case ListOptionsBottomSheetItem.rename:
        return context.text.renameList;
      case ListOptionsBottomSheetItem.clear:
        return context.text.clearList;
      case ListOptionsBottomSheetItem.delete:
        return context.text.deleteList;
      case ListOptionsBottomSheetItem.privacy:
        return context.text.privacyList;
    }
  }
}
