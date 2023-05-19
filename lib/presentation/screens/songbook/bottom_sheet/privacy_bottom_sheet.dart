import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/default_bottom_sheet.dart';
import 'package:cifraclub/presentation/widgets/selectable_item.dart';
import 'package:flutter/material.dart';

class PrivacyBottomSheet extends StatelessWidget {
  final Function(bool) onTap;
  final bool isPublic;

  const PrivacyBottomSheet({super.key, required this.onTap, required this.isPublic});

  void show(BuildContext context) {
    DefaultBottomSheet.showBottomSheet(
        context: context,
        child: PrivacyBottomSheet(
          onTap: onTap,
          isPublic: isPublic,
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
            context.text.privacyTitle,
            style: context.typography.title3,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        SelectableItem(
          isSelected: isPublic,
          onTap: () {
            DefaultBottomSheet.close(context);
            onTap(true);
          },
          icon: AppSvgs.privacyAllIcon,
          text: context.text.public,
        ),
        SelectableItem(
          isSelected: !isPublic,
          onTap: () {
            DefaultBottomSheet.close(context);
            onTap(false);
          },
          icon: AppSvgs.privacyJustMeIcon,
          text: context.text.private,
        ),
        const SizedBox(height: 16)
      ],
    );
  }
}
