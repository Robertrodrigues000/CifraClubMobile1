import 'package:cifraclub/domain/chord/models/chord_representation.dart';
import 'package:cifraclub/presentation/constants/app_webp.dart';
import 'package:cifraclub/presentation/screens/version/widgets/chord/bar_widget.dart';
import 'package:cifraclub/presentation/screens/version/widgets/chord/finger_widget.dart';
import 'package:cifraclub/presentation/screens/version/widgets/chord/chord_ui_settings.dart';
import 'package:flutter/material.dart';

class ChordGridWidget extends StatelessWidget {
  final ChordRepresentation chordRepresentation;
  final ChordUISettings chordUiSettings;
  final bool isLeftHanded;

  const ChordGridWidget({
    super.key,
    required this.chordRepresentation,
    required this.chordUiSettings,
    required this.isLeftHanded,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: chordUiSettings.chordGridWidth,
      child: Transform.flip(
        flipX: isLeftHanded,
        transformHitTests: false,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              AppWebp.guitarChordGrid,
              width: chordUiSettings.chordGridWidth - chordUiSettings.startX,
              height: chordUiSettings.chordGridHeight,
              fit: BoxFit.fill,
            ),
            for (var finger in chordRepresentation.fingers)
              Positioned(
                left: chordUiSettings.getFingerPosition(fret: finger.fret, string: finger.string).dx,
                top: chordUiSettings.getFingerPosition(fret: finger.fret, string: finger.string).dy,
                child: Transform.flip(
                  flipX: isLeftHanded,
                  child: FingerWidget(
                    ballSize: chordUiSettings.ballSize.toDouble(),
                    fontSize: chordUiSettings.ballFontSize,
                    id: finger.id,
                  ),
                ),
              ),
            if (chordRepresentation.bar != null)
              Positioned(
                  left: chordUiSettings.getBarPosition(bar: chordRepresentation.bar!).dx,
                  top: chordUiSettings.getBarPosition(bar: chordRepresentation.bar!).dy,
                  child: BarWidget(bar: chordRepresentation.bar!, gridUiSettings: chordUiSettings))
          ],
        ),
      ),
    );
  }
}
