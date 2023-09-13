import 'package:cifraclub/presentation/screens/version/widgets/chord/chord_ui_settings.dart';
import 'package:flutter/material.dart';
import 'package:cosmos/cosmos.dart';
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
            height: 1.2,
            fontFamily: FontFamilies.roboto,
            fontSize: settings.titleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
