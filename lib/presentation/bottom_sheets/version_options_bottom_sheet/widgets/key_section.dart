import 'package:cifraclub/domain/version/models/musical_scale.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/widgets/key_button/key_buttons.dart';
import 'package:flutter/material.dart';

class KeySection extends StatelessWidget {
  const KeySection(
      {super.key,
      required this.musicalScale,
      required this.originalKey,
      required this.selectedKey,
      required this.isVersionOptions,
      this.onKeySelected});
  final MusicalScale musicalScale;
  final String originalKey;
  final String selectedKey;
  final bool isVersionOptions;
  final Function(String)? onKeySelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.appDimensionScheme.screenMargin),
          child: Text(
            context.text.key,
            style: isVersionOptions ? context.typography.title6 : context.typography.title5,
          ),
        ),
        SizedBox(
          height: context.appDimensionScheme.screenMargin,
        ),
        KeyButtons(
          musicalScale: musicalScale,
          originalKey: originalKey,
          selectedKey: selectedKey,
          onKeySelected: (key) {
            Navigator.of(context).pop<String>(key);
            if (onKeySelected != null) {
              onKeySelected?.call(key); // coverage:ignore-line
            }
          },
        ),
        if (!isVersionOptions) const SizedBox(height: 16)
      ],
    );
  }
}
