import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet_bloc.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/bottom_sheets/default_bottom_sheet.dart';
import 'package:cifraclub/presentation/widgets/icon_text_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VersionOptionsBottomSheet {
  const VersionOptionsBottomSheet();

  // coverage:ignore-start
  Future<void> open({
    required BuildContext context,
    VersionOptionsBottomSheetBloc? bloc,
  }) {
    return _show(context, bloc ?? VersionOptionsBottomSheetBloc());
  }
  // coverage:ignore-end

  Future<void> _show(
    BuildContext context,
    VersionOptionsBottomSheetBloc bloc,
  ) {
    final controller = ScrollController();

    final options = List<VersionOptionsBottomSheetItem>.from(VersionOptionsBottomSheetItem.values);

    return DefaultBottomSheet.showBottomSheet(
      child: BlocProvider(
        create: (_) => bloc,
        child: BlocBuilder<VersionOptionsBottomSheetBloc, dynamic>(
          builder: (_, __) {
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
      ),
      context: context,
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
