import 'package:cifraclub/presentation/screens/version/widgets/chord/chord_ui_settings.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("ChordUISettings should scale correctly by height", () {
    final originalSettings = ChordUISettings.guitar();
    final scalledSettings = originalSettings.scaledToFit(height: 20);

    const factor = 20.0 / 180;

    expect(scalledSettings.numStrings, originalSettings.numStrings);
    expect(scalledSettings.spaceBetweenStrings, originalSettings.spaceBetweenStrings * factor);
    expect(scalledSettings.spaceBetweenFrets, originalSettings.spaceBetweenFrets * factor);
    expect(scalledSettings.startX, originalSettings.startX * factor);
    expect(scalledSettings.startY, originalSettings.startY * factor);
    expect(scalledSettings.ballSize, originalSettings.ballSize * factor);
    expect(scalledSettings.noteSize, originalSettings.noteSize * factor);
    expect(scalledSettings.barHeight, originalSettings.barHeight * factor);
    expect(scalledSettings.width, originalSettings.width * factor);
    expect(scalledSettings.chordGridWidth, originalSettings.chordGridWidth * factor);
    expect(scalledSettings.chordGridHeight, originalSettings.chordGridHeight * factor);
    expect(scalledSettings.ballFontSize, originalSettings.ballFontSize * factor);
    expect(scalledSettings.barPadding, originalSettings.barPadding * factor);
    expect(scalledSettings.stringPlayIndicationPadding, originalSettings.stringPlayIndicationPadding * factor);
    expect(scalledSettings.titleHeight, originalSettings.titleHeight * factor);
    expect(scalledSettings.titleFontSize, originalSettings.titleFontSize * factor);
    expect(scalledSettings.titlePadding, originalSettings.titlePadding * factor);
    expect(scalledSettings.titlePaddingToSubtitle, originalSettings.titlePaddingToSubtitle * factor);
    expect(scalledSettings.neckFontSize, originalSettings.neckFontSize * factor);
    expect(scalledSettings.neckIndicatorWidth, originalSettings.neckIndicatorWidth * factor);
    expect(scalledSettings.subtitleFontSize, originalSettings.subtitleFontSize * factor);
    expect(scalledSettings.subtitleHeight, originalSettings.subtitleHeight * factor);
    expect(scalledSettings.subtitlePadding, originalSettings.subtitlePadding * factor);
    expect(scalledSettings.countFontSize, originalSettings.countFontSize * factor);
    expect(scalledSettings.countHeight, originalSettings.countHeight * factor);
    expect(scalledSettings.countPadding, originalSettings.countPadding * factor);
    expect(scalledSettings.capoFontSize, originalSettings.capoFontSize * factor);
    expect(scalledSettings.capoHeight, originalSettings.capoHeight * factor);
    expect(scalledSettings.capoNutHeight, originalSettings.capoNutHeight * factor);
    expect(scalledSettings.capoPadding, originalSettings.capoPadding * factor);
    expect(scalledSettings.capoWordSpacing, originalSettings.capoWordSpacing * factor);
    expect(scalledSettings.stringsPadding, originalSettings.stringsPadding * factor);
    expect(scalledSettings.selectorHeight, originalSettings.selectorHeight * factor);
    expect(scalledSettings.selectorPadding, originalSettings.selectorPadding * factor);
  });

  test("ChordUISettings should scale correctly by width", () {
    final originalSettings = ChordUISettings.guitar();
    final scalledSettings = originalSettings.scaledToFit(width: 30);

    const factor = 30.0 / 156;

    expect(scalledSettings.numStrings, originalSettings.numStrings);
    expect(scalledSettings.spaceBetweenStrings, originalSettings.spaceBetweenStrings * factor);
    expect(scalledSettings.spaceBetweenFrets, originalSettings.spaceBetweenFrets * factor);
    expect(scalledSettings.startX, originalSettings.startX * factor);
    expect(scalledSettings.startY, originalSettings.startY * factor);
    expect(scalledSettings.ballSize, originalSettings.ballSize * factor);
    expect(scalledSettings.noteSize, originalSettings.noteSize * factor);
    expect(scalledSettings.barHeight, originalSettings.barHeight * factor);
    expect(scalledSettings.width, originalSettings.width * factor);
    expect(scalledSettings.chordGridWidth, originalSettings.chordGridWidth * factor);
    expect(scalledSettings.chordGridHeight, originalSettings.chordGridHeight * factor);
    expect(scalledSettings.ballFontSize, originalSettings.ballFontSize * factor);
    expect(scalledSettings.barPadding, originalSettings.barPadding * factor);
    expect(scalledSettings.stringPlayIndicationPadding, originalSettings.stringPlayIndicationPadding * factor);
    expect(scalledSettings.titleHeight, originalSettings.titleHeight * factor);
    expect(scalledSettings.titleFontSize, originalSettings.titleFontSize * factor);
    expect(scalledSettings.titlePadding, originalSettings.titlePadding * factor);
    expect(scalledSettings.titlePaddingToSubtitle, originalSettings.titlePaddingToSubtitle * factor);
    expect(scalledSettings.neckFontSize, originalSettings.neckFontSize * factor);
    expect(scalledSettings.neckIndicatorWidth, originalSettings.neckIndicatorWidth * factor);
    expect(scalledSettings.subtitleFontSize, originalSettings.subtitleFontSize * factor);
    expect(scalledSettings.subtitleHeight, originalSettings.subtitleHeight * factor);
    expect(scalledSettings.subtitlePadding, originalSettings.subtitlePadding * factor);
    expect(scalledSettings.countFontSize, originalSettings.countFontSize * factor);
    expect(scalledSettings.countHeight, originalSettings.countHeight * factor);
    expect(scalledSettings.countPadding, originalSettings.countPadding * factor);
    expect(scalledSettings.capoFontSize, originalSettings.capoFontSize * factor);
    expect(scalledSettings.capoHeight, originalSettings.capoHeight * factor);
    expect(scalledSettings.capoNutHeight, originalSettings.capoNutHeight * factor);
    expect(scalledSettings.capoPadding, originalSettings.capoPadding * factor);
    expect(scalledSettings.capoWordSpacing, originalSettings.capoWordSpacing * factor);
    expect(scalledSettings.stringsPadding, originalSettings.stringsPadding * factor);
    expect(scalledSettings.selectorHeight, originalSettings.selectorHeight * factor);
    expect(scalledSettings.selectorPadding, originalSettings.selectorPadding * factor);
  });

  group("ChordUISettings should scale correctly by width", () {
    test("when aspectRatio is larger than original", () {
      final originalSettings = ChordUISettings.guitar();
      final scalledSettings = originalSettings.scaledToFit(height: 300, width: 40);

      const factor = 40.0 / 156;

      expect(scalledSettings.numStrings, originalSettings.numStrings);
      expect(scalledSettings.spaceBetweenStrings, originalSettings.spaceBetweenStrings * factor);
      expect(scalledSettings.spaceBetweenFrets, originalSettings.spaceBetweenFrets * factor);
      expect(scalledSettings.startX, originalSettings.startX * factor);
      expect(scalledSettings.startY, originalSettings.startY * factor);
      expect(scalledSettings.ballSize, originalSettings.ballSize * factor);
      expect(scalledSettings.noteSize, originalSettings.noteSize * factor);
      expect(scalledSettings.barHeight, originalSettings.barHeight * factor);
      expect(scalledSettings.width, originalSettings.width * factor);
      expect(scalledSettings.chordGridWidth, originalSettings.chordGridWidth * factor);
      expect(scalledSettings.chordGridHeight, originalSettings.chordGridHeight * factor);
      expect(scalledSettings.ballFontSize, originalSettings.ballFontSize * factor);
      expect(scalledSettings.barPadding, originalSettings.barPadding * factor);
      expect(scalledSettings.stringPlayIndicationPadding, originalSettings.stringPlayIndicationPadding * factor);
      expect(scalledSettings.titleHeight, originalSettings.titleHeight * factor);
      expect(scalledSettings.titleFontSize, originalSettings.titleFontSize * factor);
      expect(scalledSettings.titlePadding, originalSettings.titlePadding * factor);
      expect(scalledSettings.titlePaddingToSubtitle, originalSettings.titlePaddingToSubtitle * factor);
      expect(scalledSettings.neckFontSize, originalSettings.neckFontSize * factor);
      expect(scalledSettings.neckIndicatorWidth, originalSettings.neckIndicatorWidth * factor);
      expect(scalledSettings.subtitleFontSize, originalSettings.subtitleFontSize * factor);
      expect(scalledSettings.subtitleHeight, originalSettings.subtitleHeight * factor);
      expect(scalledSettings.subtitlePadding, originalSettings.subtitlePadding * factor);
      expect(scalledSettings.countFontSize, originalSettings.countFontSize * factor);
      expect(scalledSettings.countHeight, originalSettings.countHeight * factor);
      expect(scalledSettings.countPadding, originalSettings.countPadding * factor);
      expect(scalledSettings.capoFontSize, originalSettings.capoFontSize * factor);
      expect(scalledSettings.capoHeight, originalSettings.capoHeight * factor);
      expect(scalledSettings.capoNutHeight, originalSettings.capoNutHeight * factor);
      expect(scalledSettings.capoPadding, originalSettings.capoPadding * factor);
      expect(scalledSettings.capoWordSpacing, originalSettings.capoWordSpacing * factor);
      expect(scalledSettings.stringsPadding, originalSettings.stringsPadding * factor);
      expect(scalledSettings.selectorHeight, originalSettings.selectorHeight * factor);
      expect(scalledSettings.selectorPadding, originalSettings.selectorPadding * factor);
    });

    test("when aspectRatio is smaller than original", () {
      final originalSettings = ChordUISettings.guitar();
      final scalledSettings = originalSettings.scaledToFit(height: 42, width: 800);

      const factor = 42.0 / 180;

      expect(scalledSettings.numStrings, originalSettings.numStrings);
      expect(scalledSettings.spaceBetweenStrings, originalSettings.spaceBetweenStrings * factor);
      expect(scalledSettings.spaceBetweenFrets, originalSettings.spaceBetweenFrets * factor);
      expect(scalledSettings.startX, originalSettings.startX * factor);
      expect(scalledSettings.startY, originalSettings.startY * factor);
      expect(scalledSettings.ballSize, originalSettings.ballSize * factor);
      expect(scalledSettings.noteSize, originalSettings.noteSize * factor);
      expect(scalledSettings.barHeight, originalSettings.barHeight * factor);
      expect(scalledSettings.width, originalSettings.width * factor);
      expect(scalledSettings.chordGridWidth, originalSettings.chordGridWidth * factor);
      expect(scalledSettings.chordGridHeight, originalSettings.chordGridHeight * factor);
      expect(scalledSettings.ballFontSize, originalSettings.ballFontSize * factor);
      expect(scalledSettings.barPadding, originalSettings.barPadding * factor);
      expect(scalledSettings.stringPlayIndicationPadding, originalSettings.stringPlayIndicationPadding * factor);
      expect(scalledSettings.titleHeight, originalSettings.titleHeight * factor);
      expect(scalledSettings.titleFontSize, originalSettings.titleFontSize * factor);
      expect(scalledSettings.titlePadding, originalSettings.titlePadding * factor);
      expect(scalledSettings.titlePaddingToSubtitle, originalSettings.titlePaddingToSubtitle * factor);
      expect(scalledSettings.neckFontSize, originalSettings.neckFontSize * factor);
      expect(scalledSettings.neckIndicatorWidth, originalSettings.neckIndicatorWidth * factor);
      expect(scalledSettings.subtitleFontSize, originalSettings.subtitleFontSize * factor);
      expect(scalledSettings.subtitleHeight, originalSettings.subtitleHeight * factor);
      expect(scalledSettings.subtitlePadding, originalSettings.subtitlePadding * factor);
      expect(scalledSettings.countFontSize, originalSettings.countFontSize * factor);
      expect(scalledSettings.countHeight, originalSettings.countHeight * factor);
      expect(scalledSettings.countPadding, originalSettings.countPadding * factor);
      expect(scalledSettings.capoFontSize, originalSettings.capoFontSize * factor);
      expect(scalledSettings.capoHeight, originalSettings.capoHeight * factor);
      expect(scalledSettings.capoNutHeight, originalSettings.capoNutHeight * factor);
      expect(scalledSettings.capoPadding, originalSettings.capoPadding * factor);
      expect(scalledSettings.capoWordSpacing, originalSettings.capoWordSpacing * factor);
      expect(scalledSettings.stringsPadding, originalSettings.stringsPadding * factor);
      expect(scalledSettings.selectorHeight, originalSettings.selectorHeight * factor);
      expect(scalledSettings.selectorPadding, originalSettings.selectorPadding * factor);
    });
  });
}
