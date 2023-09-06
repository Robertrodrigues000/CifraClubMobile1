import 'package:cifraclub/domain/section/factories/multi_line_chords_section_factory.dart';
import 'package:cifraclub/domain/section/models/chord_text.dart';
import 'package:cifraclub/domain/section/models/multi_line_chords_section.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('when match is called,', () {
    test('a multi-line string with chords should create a MultiLineChordsSection', () {
      const rawChords = '      <b>G</b>\nOs integrantes da vida noturna\n';

      final result = MultiLineChordsSectionFactory().match(rawChords, 0);
      expect(result?.sections, [isA<MultiLineChordsSection>()]);

      final section = result!.sections.first as MultiLineChordsSection;
      expect(section.text, "      G\nOs integrantes da vida noturna");
      expect(section.chords, [isA<ChordText>().having((e) => e.name, "name", "G")]);
    });
  });
}
