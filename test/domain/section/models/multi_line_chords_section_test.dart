import 'package:cifraclub/domain/section/models/chord_text.dart';
import 'package:cifraclub/domain/section/models/multi_line_chords_section.dart';
import 'package:cifraclub/domain/section/models/section_offset.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('when processLineBreak is called,', () {
    test('should break lines', () {
      const chordA = '<b>A</b>';
      const text = '     $chordA     \nAqui estou mais um dia';
      final section = MultiLineChordsSection(
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

      section.processLineBreak(8);

      expect(section.displayText, """     A 
Aqui es
    
tou mais um dia
""");
    });

    test('should break multiple lines', () {
      const chordA = '<b>A</b>';
      const chordB = '<b>B</b>';
      const text = '     $chordA     \nAqui estou mais um dia\n         $chordB     \nIarnuou... iarnu silver...';
      final section = MultiLineChordsSection(
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

      section.processLineBreak(8);

      expect(section.displayText, """     A 
Aqui es
    
tou mais um dia
       
Iarnuou
  B    
... iar
 
nu silver...
""");
    });

    test('should have different instances of ChordText', () {
      const text = 'abc <b>A</b> abc\n123 456 789';
      final chords = [
        ChordText(
          name: "A",
          offset: SectionOffset(
            start: text.indexOf('<b>A</b>'),
            end: text.indexOf('<b>A</b>') + '<b>A</b>'.length,
          ),
        )
      ];
      final section = MultiLineChordsSection(text, chords);

      section.processLineBreak(20);

      expect(section.displayText, "abc A abc\n123 456 789\n");
      expect(identical(section.chords, chords), isTrue);
      expect(identical(section.displayChords, chords), isFalse);
      expect(identical(section.displayChords.first, chords.first), isFalse);
      expect(section.displayChords.first.name, "A");
      expect(section.displayChords.first.offset.start, chords.first.offset.start);
      expect(section.displayChords.first.offset.end, chords.first.offset.end);
    });

    test('should update chords offsets when break occurs', () {
      const chordA = '<b>A</b>';
      const text = '          $chordA\nAqui estou mais um dia';
      final chords = [
        ChordText(
          name: "A",
          offset: SectionOffset(
            start: text.indexOf(chordA),
            end: text.indexOf(chordA) + chordA.length,
          ),
        ),
      ];

      final section = MultiLineChordsSection(text, chords);
      section.processLineBreak(8);

      expect(section.displayText, '       \nAqui es\n   A\ntou mais um dia\n');
      expect(section.displayChords.first.name, chords.first.name);
      expect(section.displayChords.first.offset.start, greaterThan(chords.first.offset.start));
      expect(section.displayChords.first.offset.end, greaterThan(chords.first.offset.end));
    });

    test('should break text even if has no spaces', () {
      const chordA = '<b>A(11)</b>';
      const text = '123456$chordA\n1234567890';
      final chords = [
        ChordText(
          name: "A",
          offset: SectionOffset(
            start: text.indexOf(chordA),
            end: text.indexOf(chordA) + chordA.length,
          ),
        ),
      ];

      final section = MultiLineChordsSection(text, chords);
      section.processLineBreak(8);

      expect(section.displayText, '''123456A
1234567
(11)
890
''');
    });

    test('should add new line for single lines', () {
      const chordA = '<b>A(11)</b>';
      const text = 'Aqui estou mais um dia $chordA';
      final chords = [
        ChordText(
          name: "A(11)",
          offset: SectionOffset(
            start: text.indexOf(chordA),
            end: text.indexOf(chordA) + chordA.length,
          ),
        ),
      ];
      final section = MultiLineChordsSection(text, chords);

      section.processLineBreak(8);
      expect(section.displayText, "Aqui estou mais um dia A(11)\n");
    });

    test('should break lines with same length', () {
      const text = '1234567890abcdefghij\n1234567890abcdefghij';
      final section = MultiLineChordsSection(text, []);
      section.processLineBreak(10);
      expect(section.displayText, "123456789\n123456789\n0abcdefgh\n0abcdefgh\nij\nij\n");
    });

    test('should break lines if first line has a greater length', () {
      const text = '123456\n1';
      final section = MultiLineChordsSection(text, []);
      section.processLineBreak(6);
      expect(section.displayText, "12345\n1\n6\n");
    });

    test('should break lines if second line has a greater length', () {
      const text = '1\n123456';
      final section = MultiLineChordsSection(text, []);
      section.processLineBreak(6);
      expect(section.displayText, "1\n123456\n");
    });

    test('should break lines with same point of break', () {
      const chordBm = '<b>Bm7(11)</b>';
      const chordA = '<b>A4(7)</b>';
      const chordD = '<b>D</b>';

      const text = '''$chordBm           $chordA                    $chordD
        E eu não deixo os meus passos no chão''';
      final chords = [
        ChordText(
          name: "Bm7(11)",
          offset: SectionOffset(
            start: text.indexOf(chordBm),
            end: text.indexOf(chordBm) + chordBm.length,
          ),
        ),
        ChordText(
          name: "A4(7)",
          offset: SectionOffset(
            start: text.indexOf(chordA),
            end: text.indexOf(chordA) + chordA.length,
          ),
        ),
        ChordText(
          name: "D",
          offset: SectionOffset(
            start: text.indexOf(chordD),
            end: text.indexOf(chordD) + chordD.length,
          ),
        ),
      ];
      final section = MultiLineChordsSection(text, chords);

      section.processLineBreak(40);

      expect(section.displayText, '''Bm7(11)           A4(7)              
        E eu não deixo os meus passos
      D
 no chão
''');
      // Should have same offset for Bm7(11) and A4(7), but not for D
      expect(section.displayChords, hasLength(3));
      expect(section.displayChords[0].offset.start, chords[0].offset.start);
      expect(section.displayChords[0].offset.end, chords[0].offset.end);
      expect(section.displayChords[1].offset.start, chords[1].offset.start);
      expect(section.displayChords[1].offset.end, chords[1].offset.end);
      expect(section.displayChords[2].offset.start, greaterThan(chords[2].offset.start));
      expect(section.displayChords[2].offset.end, greaterThan(chords[2].offset.end));
    });
  });
}
