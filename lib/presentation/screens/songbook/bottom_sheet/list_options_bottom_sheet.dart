import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/default_bottom_sheet.dart';
import 'package:cifraclub/presentation/widgets/icon_text_tile.dart';
import 'package:flutter/material.dart';

class ListOptionsBottomSheet extends StatelessWidget {
  final Function(OptionsBottomSheet) onTap;
  final bool isUserList;
  final ScrollController? scrollController;

  const ListOptionsBottomSheet({super.key, required this.isUserList, required this.onTap, this.scrollController});

  void show(BuildContext context) {
    final controller = ScrollController();

    DefaultBottomSheet.showBottomSheet(
      child: ListOptionsBottomSheet(
        isUserList: isUserList,
        onTap: onTap,
        scrollController: controller,
      ),
      context: context,
      scrollController: controller,
    );
  }

  @override
  Widget build(BuildContext context) {
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
            ...OptionsBottomSheet.values.map(
              (e) {
                return IconTextTile(
                  onClick: () {
                    DefaultBottomSheet.close(context);
                    onTap(e);
                  },
                  text: e.getText(context),
                  leadingIconAsset: e.icon,
                );
              },
            )
          else
            IconTextTile(
              onClick: () {
                onTap(OptionsBottomSheet.clear);
                DefaultBottomSheet.close(context);
              },
              text: OptionsBottomSheet.clear.getText(context),
              leadingIconAsset: OptionsBottomSheet.clear.icon,
            ),
          const SizedBox(height: 16)
        ],
      ),
    );
  }
}

enum OptionsBottomSheet {
  share(AppSvgs.shareIcon),
  rename(AppSvgs.musicalStylesIcon),
  clear(AppSvgs.clearIcon),
  delete(AppSvgs.deleteIcon),
  privacy(AppSvgs.privacyIcon);

  final String icon;

  const OptionsBottomSheet(this.icon);

  String getText(BuildContext context) {
    switch (this) {
      case OptionsBottomSheet.share:
        return context.text.shareList;
      case OptionsBottomSheet.rename:
        return context.text.renameList;
      case OptionsBottomSheet.clear:
        return context.text.clearList;
      case OptionsBottomSheet.delete:
        return context.text.deleteList;
      case OptionsBottomSheet.privacy:
        return context.text.privacyList;
    }
  }
}
