import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/bottom_sheets/default_bottom_sheet.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/icon_text_tile.dart';
import 'package:flutter/material.dart';

class ListVersionOptionsBottomSheet extends StatelessWidget {
  const ListVersionOptionsBottomSheet({super.key, required this.onTap});

  final VoidCallback onTap;

  void show(BuildContext context) {
    DefaultBottomSheet.showBottomSheet(
        context: context,
        child: ListVersionOptionsBottomSheet(
          onTap: onTap,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
        IconTextTile(
          onClick: () {
            DefaultBottomSheet.close(context);
            onTap();
          },
          text: context.text.deleteVersionOption,
          leadingIconAsset: AppSvgs.deleteIcon,
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
