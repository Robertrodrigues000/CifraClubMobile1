import 'package:cifraclub/domain/section/models/chord_text.dart';
import 'package:cifraclub/domain/section/models/section_offset.dart';
import 'package:cifraclub/domain/section/models/tab_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

TabSection _getTabSection(String tab, [List<ChordText> chords = const []]) {
  return TabSection(
    tab,
    chords,
    SectionOffset(
      start: tab.indexOf('#t2#'),
      end: tab.indexOf('#/t2#') + '#/t2#'.length,
    ),
  )..preprocess();
}

void main() {
  group('when processLineBreak is called,', () {
    test('should not break a tab that fits limit', () {
      final tab = _getTabSection('#t1##t2#A|-1-2-3-4-|\nB|-1-2-3-4-|#/t2##/t1#');

      tab.updateOffset(0);
      tab.processLineBreak(100);

      expect(tab.displayText, 'A|-1-2-3-4-|\nB|-1-2-3-4-|\n\n');
    });

    test('should break tab that does not fit limit', () {
      final tab = _getTabSection('#t1##t2#E|-1-2-3-4-|#/t2##/t1#');

      tab.updateOffset(0);
      tab.processLineBreak(3);

      expect(tab.displayText, '''E|-

E|1

E|-

E|2

E|-

E|3

E|-

E|4

''');
    });

    test('should align the text with each tab', () {
      const rawTab = '''#t1#1234567890
abcdefghij
#t2#E|-1-2-3-|
B|-1-2-3-|#/t2##/t1#''';

      final tab = _getTabSection(rawTab);

      tab.updateOffset(0);
      tab.processLineBreak(5);

      expect(tab.displayText, '''12345
abcde
E|-1-
B|-1-

67890
fghij
E|2-3
B|2-3

''');
    });

    test('a tab with no allowed break character should force line break', () {
      final tab = _getTabSection('''#t1##t2#A|----------|
B|----------|
C|1234567890|
D|1234567890|#/t2##/t1#''');

      tab.updateOffset(0);
      tab.processLineBreak(7);

      expect(tab.displayText, '''A|-----
B|-----
C|12345
D|12345

A|-----
B|-----
C|67890
D|67890

''');
    });

    test('a negative limit should not break characters', () {
      final tab = _getTabSection('''#t1##t2#A|-1-2-3-4-5-|#/t2##/t1#''');

      tab.updateOffset(0);
      tab.processLineBreak(-1);

      expect(tab.displayText, "A|-1-2-3-4-5-|");
    });

    test('a limit of zero should not break characters', () {
      final tab = _getTabSection('''#t1##t2#A|-1-2-3-4-5-|#/t2##/t1#''');

      tab.updateOffset(0);
      tab.processLineBreak(0);

      expect(tab.displayText, "A|-1-2-3-4-5-|");
    });

    test('a limit of one should not break characters', () {
      final tab = _getTabSection('''#t1##t2#A|-1-2-3-4-5-|#/t2##/t1#''');

      tab.updateOffset(0);
      tab.processLineBreak(1);

      expect(tab.displayText, "A|-1-2-3-4-5-|");
    });

    test('should break characters only if tab head supports it', () {
      final tab1 = _getTabSection('''#t1##t2#A|-1-2-|#/t2##/t1#''');
      final tab2 = _getTabSection('''#t1##t2#D#|-1-2-|#/t2##/t1#''');

      tab1.updateOffset(0);
      tab1.processLineBreak(3);

      tab2.updateOffset(0);
      tab2.processLineBreak(3);

      expect(tab1.displayText, "A|-\n\nA|1\n\nA|-\n\nA|2\n\n");
      expect(tab2.displayText, "D#|-1-2-|");
    });

    test('a tab should prioritize break characters', () {
      final tab1 = _getTabSection('#t1##t2#A|-----------------1000-1000|#/t2##/t1#');
      final tab2 = _getTabSection('#t1##t2#A|-----------------1000!1000|#/t2##/t1#');

      tab1.updateOffset(0);
      tab1.processLineBreak(25);

      tab2.updateOffset(0);
      tab2.processLineBreak(25);

      expect(tab1.displayText, 'A|-----------------1000-\n\nA|1000|\n\n');
      expect(tab2.displayText, 'A|-----------------1000!\n\nA|1000|\n\n');
    });

    test('should update chords offsets when break occurs', () {
      const rawTab = '''#t1#12345<b>Bm7(11)</b>6789
#t2#E|1234567|#/t2##/t1#''';

      final chord = ChordText(
        name: "Bm7(11)",
        offset: SectionOffset(
          start: rawTab.indexOf('<b>Bm7(11)</b>'),
          end: rawTab.indexOf('<b>Bm7(11)</b>') + '<b>Bm7(11)</b>'.length,
        ),
      );

      final tab = _getTabSection(rawTab, [chord]);

      tab.updateOffset(0);
      tab.processLineBreak(5);

      expect(tab.displayChords.first.offset.start, greaterThan(chord.offset.start));
      expect(tab.displayChords.first.offset.end, greaterThan(chord.offset.end));
    });

    test('should break a headless tab', () {
      final tab = _getTabSection('#t1##t2#|-1-1|\n|-2-2|#/t2##/t1#');
      tab.updateOffset(0);
      tab.processLineBreak(3);

      expect(tab.displayText, '|-1\n|-2\n\n|-1\n|-2\n\n');
    });

    test('should break a tab with different head', () {
      final tab = _getTabSection('''#t1##t2#!|-1-|
:|-1-|
||-1-|#/t2##/t1#''');
      tab.updateOffset(0);
      tab.processLineBreak(20);

      expect(tab.displayText, """!|-1-|
:|-1-|
||-1-|

""");
      expect(tab.tabLineHeads, ['!|', ':|', '||']);
      expect(tab.tabLines, everyElement(equals("-1-|")));
    });

    test('should break a empty head tab', () {
      final tab = _getTabSection('#t1##t2# |-1-1|\n |-2-2|#/t2##/t1#');
      tab.updateOffset(0);
      tab.processLineBreak(4);

      expect(tab.displayText, ' |-1\n |-2\n\n |-1\n |-2\n\n');
    });

    test('should break a head with special characters', () {
      final tab = _getTabSection('#t1##t2#C#|-1--|\nH |-2--|\nEb|-3--|#/t2##/t1#');
      tab.updateOffset(0);
      tab.processLineBreak(10);

      expect(tab.tabLineHeads, ['C#|', 'H |', 'Eb|']);
      expect(tab.displayText, '''C#|-1--|
H |-2--|
Eb|-3--|

''');
    });

    test('should be able to process an empty tab', () {
      final tab = _getTabSection('#t1##t2##/t2##/t1#');
      tab.updateOffset(0);
      tab.processLineBreak(10);

      expect(tab.displayText, "\n");
      expect(tab.tabLineHeads, []);
      expect(tab.tabLines, []);
      expect(tab.getSpans((_) => null), [isA<TextSpan>().having((e) => e.text, "text", "\n")]);
    });

    test('should be able to break tab with no common break', () {
      const text =
          '#t1#Parte 3 de 4\n   <b>D6(9)</b>    <b>A7/C#</b>     <b>B2</b>      <b>Bm</b>    <b>B7(4)</b> <b>Bm</b> \n#t2#E|-5---5--------5----------------2--------2-|\nB|-5---5--------5----------2--3--3---5----3-|\nG|-4---4--------0----------4--4--4---2----4-|\nD|-------------------------4--4------4------|\nA|-5------5-4------4--2---------------------|\nE|------------------------------------------|#/t2##/t1#';

      final chords = [
        ChordText(
          name: "D6(9)",
          offset: SectionOffset(
            start: text.indexOf("<b>D6(9)</b>"),
            end: text.indexOf("<b>D6(9)</b>") + '<b>D6(9)</b>'.length,
          ),
        ),
        ChordText(
          name: "A7/C#",
          offset: SectionOffset(
            start: text.indexOf("<b>A7/C#</b>"),
            end: text.indexOf("<b>A7/C#</b>") + "<b>A7/C#</b>".length,
          ),
        ),
        ChordText(
          name: "B2",
          offset: SectionOffset(
            start: text.indexOf("<b>B2</b>"),
            end: text.indexOf("<b>B2</b>") + "<b>B2</b>".length,
          ),
        ),
        ChordText(
          name: "Bm",
          offset: SectionOffset(
            start: text.indexOf("<b>Bm</b>"),
            end: text.indexOf("<b>Bm</b>") + "<b>Bm</b>".length,
          ),
        ),
        ChordText(
          name: "B7(4)",
          offset: SectionOffset(
            start: text.indexOf("<b>B7(4)</b>"),
            end: text.indexOf("<b>B7(4)</b>") + "<b>B7(4)</b>".length,
          ),
        ),
        ChordText(
          name: "Bm",
          offset: SectionOffset(
            start: text.lastIndexOf("<b>Bm</b>"),
            end: text.lastIndexOf("<b>Bm</b>") + "<b>Bm</b>".length,
          ),
        ),
      ];

      final tab = _getTabSection(text, chords);

      tab.updateOffset(0);
      tab.processLineBreak(40);

      expect(tab.displayText, '''Parte 3 de 4
   D6(9)    A7/C#     B2      Bm    
E|-5---5--------5----------------2--
B|-5---5--------5----------2--3--3--
G|-4---4--------0----------4--4--4--
D|-------------------------4--4-----
A|-5------5-4------4--2-------------
E|----------------------------------

B7(4) Bm 
E|------2-|
B|-5----3-|
G|-2----4-|
D|-4------|
A|--------|
E|--------|

''');
    });

    test('should preserve empty tab if has a text at the end', () {
      final tab = _getTabSection('''#t1#
#t2#A|-0-0-0----------------------| (5x)
B|-0-0-0----------------------|#/t2##/t1#''');

      tab.updateOffset(0);
      tab.processLineBreak(20);

      expect(tab.displayText, '\nA|-0-0-0------------\nB|-0-0-0------------\n\nA|----------| (5x)\nB|----------|\n\n');
    });
  });

  group('when getSpans is called,', () {
    test('should remove chords inside inner tab', () {
      const rawTab = '#t1##t2#E|---<b>A</b>---|#/t2##/t1#';

      final chord = ChordText(
        name: "A",
        offset: SectionOffset(
          start: rawTab.indexOf('<b>A</b>'),
          end: rawTab.indexOf('<b>A</b>') + '<b>A</b>'.length,
        ),
      );

      final tab = _getTabSection(rawTab, [chord]);

      tab.updateOffset(0);
      tab.processLineBreak(20);

      expect(tab.displayText, "E|---A---|\n\n");
      expect(tab.displayChords, isEmpty);
      expect(tab.getSpans((_) => null), [predicate<TextSpan>((e) => e.text == "E|---A---|\n\n")]);
    });

    test('should create chords inside tabs header', () {
      const rawTab = '''#t1#    <b>Bm</b>
#t2#E|------------------------------------------|
B|------------------------------------------|
G|------------------------------------------|
D|-------0-------0-------0-------0----------|
A|---5-------5-------5-------5--------------|
E|-7---7---7---7---7---7---7---7------------|#/t2##/t1#''';

      final chord = ChordText(
        name: "Bm",
        offset: SectionOffset(
          start: rawTab.indexOf('<b>Bm</b>'),
          end: rawTab.indexOf('<b>Bm</b>') + '<b>Bm</b>'.length,
        ),
      );

      final tab = _getTabSection(rawTab, [chord]);

      tab.updateOffset(0);
      tab.processLineBreak(15);

      final spans = tab.getSpans((_) => null);
      expect(spans, hasLength(3));
      expect(spans, [
        predicate<TextSpan>((e) => e.style?.color == null),
        predicate<TextSpan>((e) => e.text == "Bm" && e.style?.color != null),
        predicate<TextSpan>((e) => e.style?.color == null),
      ]);
    });

    test('should ignore chords that are in a breaking empty tab', () {
      const rawTab = '''#t1#<b>A</b>                               <b>B</b>
#t2#A|-0-0-0------------------------------------------|
B|-0-0-0------------------------------------------|
C|-0-0-0------------------------------------------|#/t2##/t1#''';

      final chordA = ChordText(
        name: "A",
        offset: SectionOffset(
          start: rawTab.indexOf('<b>A</b>'),
          end: rawTab.indexOf('<b>A</b>') + '<b>A</b>'.length,
        ),
      );
      final chordB = ChordText(
        name: "B",
        offset: SectionOffset(
          start: rawTab.indexOf('<b>B</b>'),
          end: rawTab.indexOf('<b>B</b>') + '<b>B</b>'.length,
        ),
      );

      final tab = _getTabSection(rawTab, [chordA, chordB]);

      tab.updateOffset(0);
      tab.processLineBreak(10);

      expect(tab.displayText, '''A         
A|-0-0-0--
B|-0-0-0--
C|-0-0-0--

''');

      expect(tab.getSpans((_) => null), [
        predicate<TextSpan>((e) => e.text == "A" && e.style?.color != null),
        predicate<TextSpan>((e) => e.text == "         \nA|-0-0-0--\nB|-0-0-0--\nC|-0-0-0--\n\n"),
      ]);
    });
  });
}
