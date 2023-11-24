import 'package:cifraclub/domain/chord/models/bar.dart';
import 'package:cifraclub/domain/chord/models/neck.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';

part 'chord_ui_settings.g.dart';

@CopyWith()
class ChordUISettings {
  final double spaceBetweenStrings;
  final double spaceBetweenFrets;
  final double stringsPadding;
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
  final double titlePaddingToSubtitle;
  final double neckFontSize;
  final double neckIndicatorWidth;
  final double nutBorderPixel;
  final double countFontSize;
  final double countHeight;
  final double countPadding;
  final double subtitleFontSize;
  final double subtitleHeight;
  final double subtitlePadding;
  final double capoHeight;
  final double capoPadding;
  final double capoFontSize;
  final double capoWordSpacing;
  final double capoNutHeight;
  final double selectorHeight;
  final double selectorPadding;

  ChordUISettings({
    required this.numStrings,
    required this.chordGridWidth,
    required this.width,
    this.spaceBetweenStrings = 18,
    this.spaceBetweenFrets = 24,
    this.stringsPadding = 8,
    this.startX = 9,
    this.startY = 5,
    this.ballSize = 18,
    this.noteSize = 10,
    this.chordGridHeight = 130,
    this.stringPlayIndicationPadding = 8,
    this.barHeight = 14,
    this.ballFontSize = 16,
    this.barPadding = 8,
    this.titleHeight = 24,
    this.titleFontSize = 24,
    this.titlePadding = 8,
    this.titlePaddingToSubtitle = 2,
    this.neckFontSize = 12,
    this.neckIndicatorWidth = 24,
    this.nutBorderPixel = 1,
    this.countFontSize = 12,
    this.countHeight = 16,
    this.countPadding = 8,
    this.subtitleFontSize = 14,
    this.subtitleHeight = 18,
    this.subtitlePadding = 16,
    this.capoHeight = 30,
    this.capoPadding = 12,
    this.capoFontSize = 14,
    this.capoWordSpacing = 8,
    this.capoNutHeight = 3,
    this.selectorHeight = 4,
    this.selectorPadding = 8,
  });

  ChordUISettings.guitar() : this(numStrings: 6, chordGridWidth: 108, width: 156);

  ChordUISettings scaledToFit(
      {double? width,
      double? height,
      bool hasSubtitle = false,
      bool hasCount = false,
      bool hasCapo = false,
      bool hasSelector = false}) {
    final double currentWidth = this.width;
    final double currentHeight = titleHeight +
        (hasSubtitle ? titlePaddingToSubtitle : titlePadding) +
        chordGridHeight +
        stringPlayIndicationPadding +
        noteSize +
        (hasCount ? countHeight + countPadding : 0) +
        (hasSubtitle ? subtitleHeight + subtitlePadding : 0) +
        (hasCapo ? capoHeight + capoPadding : 0) +
        (hasSelector ? selectorHeight + selectorPadding : 0);
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
      titlePaddingToSubtitle: titlePaddingToSubtitle * factor,
      neckFontSize: neckFontSize * factor,
      neckIndicatorWidth: neckIndicatorWidth * factor,
      nutBorderPixel: nutBorderPixel * factor,
      countFontSize: countFontSize * factor,
      countHeight: countHeight * factor,
      countPadding: countPadding * factor,
      subtitleFontSize: subtitleFontSize * factor,
      subtitleHeight: subtitleHeight * factor,
      subtitlePadding: subtitlePadding * factor,
      capoHeight: capoHeight * factor,
      capoPadding: capoPadding * factor,
      capoFontSize: capoFontSize * factor,
      capoWordSpacing: capoWordSpacing * factor,
      capoNutHeight: capoNutHeight * factor,
      stringsPadding: stringsPadding * factor,
      selectorHeight: selectorHeight * factor,
      selectorPadding: selectorPadding * factor,
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

    final positionX = startX + ((numStrings - bar.string) * spaceBetweenStrings) - barPadding / 2;
    final positionY = startY + spaceBetweenFrets * (bar.fret - 1) + (spaceBetweenFrets - barHeight) / 2;
    return Offset(positionX.floorToDouble(), positionY.floorToDouble());
  }

  double getBarWidth({Bar? bar}) {
    return (spaceBetweenStrings * ((bar?.string ?? 6) - 1)).floorToDouble() + barPadding;
  }

  Offset getNeckPosition({required Neck neck}) {
    final positionY = startY + (spaceBetweenFrets - barHeight) / 3;

    return Offset(0.0, positionY.ceilToDouble());
  }
}
