import 'package:cifraclub/domain/chord/models/bar.dart';
import 'package:cifraclub/domain/chord/models/neck.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';

part 'chord_ui_settings.g.dart';

@CopyWith()
class ChordUISettings {
  final double spaceBetweenStrings;
  final double spaceBetweenFrets;
  final double startX;
  final double startY;
  final double ballSize;
  final double noteSize;
  final double barHeight;
  final double width;
  final double chordGridWidth;
  final double chordGridHeight;
  final int numStrings;
  final double ballFontSize;
  final double barPadding;
  final double stringPlayIndicationPadding;
  final double titleHeight;
  final double titleFontSize;
  final double titlePadding;
  final double neckFontSize;
  final double neckIndicatorWidth;

  ChordUISettings({
    required this.numStrings,
    required this.chordGridWidth,
    required this.width,
    this.spaceBetweenStrings = 18,
    this.spaceBetweenFrets = 24,
    this.startX = 9,
    this.startY = 5,
    this.ballSize = 18,
    this.noteSize = 10,
    this.chordGridHeight = 130,
    this.stringPlayIndicationPadding = 8,
    this.barHeight = 12,
    this.ballFontSize = 10,
    this.barPadding = 12,
    this.titleHeight = 24,
    this.titleFontSize = 20,
    this.titlePadding = 8,
    this.neckFontSize = 12,
    this.neckIndicatorWidth = 24,
  });

  ChordUISettings.guitar() : this(numStrings: 6, chordGridWidth: 108, width: 156);

  ChordUISettings scaledToFit({double? width, double? height}) {
    final double currentWidth = this.width;
    final double currentHeight = titleHeight + titlePadding + chordGridHeight + stringPlayIndicationPadding + noteSize;
    final double currentAspectRatio = currentHeight / currentWidth;
    final double factor;

    if (width == null) {
      assert(height != null);
      factor = height! / currentHeight;
    } else if (height == null) {
      factor = width / currentWidth;
    } else if (height / width > currentAspectRatio) {
      factor = width / currentWidth;
    } else {
      factor = height / currentHeight;
    }
    return scaledBy(factor);
  }

  ChordUISettings scaledBy(double factor) {
    return copyWith(
      spaceBetweenStrings: spaceBetweenStrings * factor,
      spaceBetweenFrets: spaceBetweenFrets * factor,
      startX: startX * factor,
      startY: startY * factor,
      ballSize: ballSize * factor,
      noteSize: noteSize * factor,
      chordGridWidth: chordGridWidth * factor,
      chordGridHeight: chordGridHeight * factor,
      stringPlayIndicationPadding: stringPlayIndicationPadding * factor,
      width: width * factor,
      barHeight: barHeight * factor,
      ballFontSize: ballFontSize * factor,
      barPadding: barPadding * factor,
      titleHeight: titleHeight * factor,
      titleFontSize: titleFontSize * factor,
      titlePadding: titlePadding * factor,
      neckFontSize: neckFontSize * factor,
      neckIndicatorWidth: neckIndicatorWidth * factor,
    );
  }

  Offset getFingerPosition({required int fret, required int string}) {
    final ballRadius = ballSize / 2;
    //calculo de offset para left handed =  width - ((numStrings - string) * ballSize) - ballRadius

    final positionX = startX + ((numStrings - string) * ballSize) - ballRadius;
    final positionY = startY + spaceBetweenFrets * (fret - 1) + (spaceBetweenFrets - ballSize) / 2;

    return Offset(positionX.floorToDouble(), positionY.floorToDouble());
  }

  Offset getBarPosition({required Bar bar}) {
    //calculo de offset para lefthanded =  width - (bar.string - 1) * spaceBetweenStrings - barPadding/2

    final positionX = startX + (numStrings - bar.string - 1) * spaceBetweenStrings + barPadding;
    final positionY = startY + spaceBetweenFrets * (bar.fret - 1) + (spaceBetweenFrets - barHeight) / 2;
    return Offset(positionX.floorToDouble(), positionY.floorToDouble());
  }

  double getBarWidth({required Bar bar}) {
    return (spaceBetweenStrings * (bar.string - 1)).floorToDouble() + barPadding;
  }

  Offset getNeckPosition({required Neck neck}) {
    final positionY = startY;

    return Offset(0.0, positionY.floorToDouble());
  }
}