import 'package:cifraclub/domain/section/factories/single_line_chords_section_factory.dart';
import 'package:cifraclub/domain/section/models/chord_text.dart';
import 'package:cifraclub/domain/section/models/single_line_chords_section.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('when match is called,', () {
    test('a single line with chords should create a SingleLineChordsSection', () {
      const rawChords = '<b>A</b> <b>B</b>\n';

      final result = SingleLineChordsSectionFactory().match(rawChords, 0);
      expect(result?.sections, [isA<SingleLineChordsSection>()]);

      final section = result!.sections.first as SingleLineChordsSection;
      expect(section.text, "A B");
      expect(section.chords, [
        isA<ChordText>().having((e) => e.name, "name", "A"),
        isA<ChordText>().having((e) => e.name, "name", "B"),
      ]);
    });

    test('a multi-line with chords should create a SingleLineChordsSection with the first line', () {
      const rawChords = '<b>A</b>\n<b>B</b>\n';

      final result = SingleLineChordsSectionFactory().match(rawChords, 0);
      expect(result?.sections, [isA<SingleLineChordsSection>()]);

      final section = result!.sections.first as SingleLineChordsSection;
      expect(section.text, "A");
      expect(section.chords, [
        isA<ChordText>().having((e) => e.name, "name", "A"),
      ]);
    });

    test('a default text should return null', () {
      const text = 'A default text with no chords\n';

      final result = SingleLineChordsSectionFactory().match(text, 0);
      expect(result, isNull);
    });
  });
}
