import 'package:cifraclub/domain/version/models/musical_scale.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/bottom_sheets/default_bottom_sheet.dart';
import 'package:cifraclub/presentation/widgets/key_button/key_buttons.dart';
import 'package:flutter/material.dart';

class VersionKeyBottomSheet extends StatelessWidget {
  final MusicalScale musicalScale;
  final String originalKey;
  final String selectedKey;
  const VersionKeyBottomSheet(
      {super.key, required this.musicalScale, required this.originalKey, required this.selectedKey});

  Future<String?> open({required BuildContext context}) {
    return DefaultBottomSheet.showBottomSheet(
      context: context,
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.appDimensionScheme.screenMargin),
            child: Text(
              context.text.key,
              style: context.typography.title3,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          KeyButtons(
            musicalScale: musicalScale,
            originalKey: originalKey,
            selectedKey: selectedKey,
            onKeySelected: (key) {
              Navigator.of(context).pop<String>(key);
            },
          ),
          const SizedBox(height: 16)
        ],
      ),
    );
  }
}
