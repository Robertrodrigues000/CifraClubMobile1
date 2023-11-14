import 'package:cifraclub/presentation/screens/version/widgets/chord/chord_ui_settings.dart';
import 'package:cifraclub/presentation/style/typography/font_families.dart';
import 'package:flutter/material.dart';
import 'package:cifraclub/extensions/build_context.dart';

class ChordTitleWidget extends StatelessWidget {
  const ChordTitleWidget({
    super.key,
    required this.chordName,
    required this.settings,
  });

  final String chordName;
  final ChordUISettings settings;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: settings.chordGridWidth,
      height: settings.titleHeight,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          chordName,
          maxLines: 1,
          style: TextStyle(
            color: context.colors.primary,
            height: 1.3,
            fontFamily: FontFamilies.montserrat,
            fontSize: settings.titleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
