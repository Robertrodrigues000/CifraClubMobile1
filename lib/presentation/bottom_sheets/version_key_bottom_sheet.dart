import 'package:cifraclub/domain/version/models/musical_scale.dart';
import 'package:cifraclub/presentation/bottom_sheets/default_bottom_sheet.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/widgets/key_section.dart';
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
      child: KeySection(
        musicalScale: musicalScale,
        originalKey: originalKey,
        selectedKey: selectedKey,
        isVersionOptions: false,
      ),
    );
  }
}
