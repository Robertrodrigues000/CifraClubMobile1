import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/version/widgets/chord/chord_ui_settings.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class FretNumberWidget extends StatelessWidget {
  final int fret;
  final ChordUISettings settings;
  const FretNumberWidget({
    Key? key,
    required this.settings,
    required this.fret,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: settings.neckIndicatorWidth,
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.only(
          right: settings.fretNumberPadding,
        ),
        child: Text(
          fret.toString(),
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: settings.neckFontSize,
              color: context.colors.textSecondary,
              fontFamily: FontFamilies.montserrat),
        ),
      ),
    );
  }
}
