import 'package:cifraclub/domain/section/factories/tab_section_factory.dart';
import 'package:cifraclub/domain/section/models/chord_text.dart';
import 'package:cifraclub/domain/section/models/tab_section.dart';
import 'package:cifraclub/domain/section/models/text_section.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('when match is called,', () {
    test('a tab string should create a TablatureSection', () {
      const rawTab = '''#t1#A primeira linha é essa
<b>A</b> 123 <b>B</b> 456 <b>C</b>
#t2#E|-11b12r11~~-b15r14p12-x-x-x---------------|
B|------------------------------------------|
G|------------------------------------------|
D|-------0-------0-------0-------0----------|
A|---5-------5-------5-------5--------------|
E|-7---7---7---7---7---7---7---7------------|#/t2##/t1#''';

      final result = TabSectionFactory().match(rawTab, 0);
      expect(result?.sections, [isA<TabSection>()]);

      final section = result!.sections.first as TabSection;
      expect(
          section.chords,
          ["A", "B", "C"].map((chord) {
            return isA<ChordText>().having((e) => e.name, "name", chord);
          }));
      expect(section.preTabsTextLines, [
        "A primeira linha é essa",
        "A 123 B 456 C",
      ]);
      expect(section.tabLineHeads, [
        "E|",
        "B|",
        "G|",
        "D|",
        "A|",
        "E|",
      ]);
      expect(section.tabLines, [
        "-11b12r11~~-b15r14p12-x-x-x---------------|",
        "------------------------------------------|",
        "------------------------------------------|",
        "-------0-------0-------0-------0----------|",
        "---5-------5-------5-------5--------------|",
        "-7---7---7---7---7---7---7---7------------|",
      ]);
    });

    test('should create a TextSection if it has text before the mark', () {
      const rawTab = '''Uai#t1##t2#E|-|
B|-|
G|-|
D|-|
A|-|
E|-|#/t2##/t1#''';

      final result = TabSectionFactory().match(rawTab, 0);
      expect(result?.sections, [
        isA<TextSection>().having((e) => e.text, "text", "Uai"),
        isA<TabSection>(),
      ]);
    });

    test('a single line with chords should return null', () {
      const text = ' <b>A</b> \n';

      final result = TabSectionFactory().match(text, 0);
      expect(result, isNull);
    });

    test('a default text should return null', () {
      const text = 'A default text with no chords\n';

      final result = TabSectionFactory().match(text, 0);
      expect(result, isNull);
    });
  });
}
