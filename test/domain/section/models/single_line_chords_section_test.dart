import 'package:cifraclub/domain/section/models/chord_text.dart';
import 'package:cifraclub/domain/section/models/section_offset.dart';
import 'package:cifraclub/domain/section/models/single_line_chords_section.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('when processLineBreak is called,', () {
    test('should not break lines', () {
      const chordA = '<b>A</b>';
      const chordB = '<b>B</b>';
      const text = '$chordA $chordB';
      final section = SingleLineChordsSection(
        text,
        [
          ChordText(
            name: "A",
            offset: SectionOffset(
              start: text.indexOf(chordA),
              end: text.indexOf(chordA) + chordA.length,
            ),
          ),
          ChordText(
            name: "B",
            offset: SectionOffset(
              start: text.indexOf(chordB),
              end: text.indexOf(chordB) + chordB.length,
            ),
          ),
        ],
      );

      section.processLineBreak(2);
      expect(section.displayText, "A B");
    });

    test('should have different instances of ChordText', () {
      const text = 'abc <b>A</b> abc';
      final chords = [
        ChordText(
          name: "A",
          offset: SectionOffset(
            start: text.indexOf('<b>A</b>'),
            end: text.indexOf('<b>A</b>') + '<b>A</b>'.length,
          ),
        )
      ];
      final section = SingleLineChordsSection(text, chords);

      section.processLineBreak(2);

      expect(section.displayText, "abc A abc");
      expect(identical(section.chords, chords), isTrue);
      expect(identical(section.displayChords, chords), isFalse);
      expect(identical(section.displayChords.first, chords.first), isFalse);
      expect(section.displayChords.first.name, "A");
      expect(section.displayChords.first.offset.start, chords.first.offset.start);
      expect(section.displayChords.first.offset.end, chords.first.offset.end);
    });
  });

  group('when getSpans is called,', () {
    test('should mix spans of texts and chords', () {
      const chordA = '<b>A</b>';
      const text = 'Abc $chordA 123';
      final section = SingleLineChordsSection(
        text,
        [
          ChordText(
            name: "A",
            offset: SectionOffset(
              start: text.indexOf(chordA),
              end: text.indexOf(chordA) + chordA.length,
            ),
          ),
        ],
      );

      section.processLineBreak(20);
      final spans = section.getSpans();

      expect(spans, [
        predicate<TextSpan>((e) => e.text == "Abc " && e.style?.color == null),
        predicate<TextSpan>((e) => e.text == "A" && e.style?.color != null),
        predicate<TextSpan>((e) => e.text == " 123" && e.style?.color == null),
      ]);
    });
  });
}
