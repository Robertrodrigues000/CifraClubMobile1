import 'dart:isolate';

import 'package:cifraclub/domain/section/factories/multi_line_chords_section_factory.dart';
import 'package:cifraclub/domain/section/models/chord_text.dart';
import 'package:cifraclub/domain/section/models/multi_line_chords_section.dart';
import 'package:cifraclub/domain/section/models/section_match_result.dart';
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

  test('should not match with a long line of chords and an empty line after', () async {
    // Based on https://github.com/StudioSol/CifraClubMobile/issues/3316
    const rawChords =
        '''<b>A5</b> <b>A5</b> <b>A5</b> <b>A5</b> <b>A5</b> <b>A5</b> <b>A5</b> <b>A5</b> <b>A5</b> <b>A5</b> <b>A5</b> <b>A5</b> <b>A5</b> <b>A5</b> <b>A5</b> <b>A5</b> <b>A5</b> <b>A5</b> <b>G5</b> <b>G5</b> <b>G5</b> <b>G5</b> <b>A5</b> <b>A5</b> <b>A5</b> <b>A5</b> <b>G#5</b> <b>G#5</b> <b>G#5</b> <b>G#5</b>



Refrão:

<b>G5</b> <b>A5</b> <b>A5</b> <b>A5</b> <b>A5</b> <b>A5</b> <b>A5</b> <b>A5</b> (X4)
''';

    final result = await Isolate.run<SectionMatchResult?>(() {
      return MultiLineChordsSectionFactory().match(rawChords, 0);
    });

    expect(result?.sections, isNull);
  }, timeout: const Timeout(Duration(seconds: 1)));
}
