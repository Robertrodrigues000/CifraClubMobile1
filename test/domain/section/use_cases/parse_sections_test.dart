import 'package:cifraclub/domain/section/models/multi_line_chords_section.dart';
import 'package:cifraclub/domain/section/models/single_line_chords_section.dart';
import 'package:cifraclub/domain/section/models/tab_section.dart';
import 'package:cifraclub/domain/section/models/text_section.dart';
import 'package:cifraclub/domain/section/use_cases/parse_sections.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('when use case is called,', () {
    test('a simple text should return a single TextSection', () {
      final sections = ParseSections().call('a simple line');
      expect(sections, [isA<TextSection>().having((e) => e.text, "text", "a simple line\n")]);
    });

    test('a single line with chords should return a single SingleLineChordsSection', () {
      final sections = ParseSections().call('<b>A</b>\n');
      expect(sections, [
        isA<SingleLineChordsSection>()
            .having((e) => e.text, "text", "A")
            .having((e) => e.chords, "chordSections", hasLength(1))
      ]);
    });

    test('a multi line with only chords should return multiples SingleLineChordsSection', () {
      const text = '''[Intro] <b>E</b>  <b>E5+</b>  <b>A</b>  <b>F#m</b>  <b>A/B</b>
        <b>E</b>  <b>E5+</b>  <b>A</b>  <b>E/G#</b>  <b>F#m</b>  <b>A/B</b>
        <b>E</b>  <b>A/B</b>
''';

      final sections = ParseSections().call(text);
      expect(sections, hasLength(3));
      expect(sections, everyElement(isA<SingleLineChordsSection>()));
    });

    test('a multi line with chords and text should return a single MultiLineChordsSection', () {
      final sections = ParseSections().call('<b>A</b>\nAbacate\n');
      expect(sections, [
        isA<MultiLineChordsSection>()
            .having((e) => e.text, "text", "A\nAbacate")
            .having((e) => e.chords, "chordSections", hasLength(1))
      ]);
    });

    test('a tab return a single TabSection', () {
      const rawTab = '''#t1#<b>A</b>
#t2#E|-11b12r11~~-b15r14p12-x-x-x---------------|
B|------------------------------------------|
G|------------------------------------------|
D|-------0-------0-------0-------0----------|
A|---5-------5-------5-------5--------------|
E|-7---7---7---7---7---7---7---7------------|#/t2##/t1#''';

      final sections = ParseSections().call(rawTab);
      expect(sections, [
        isA<TabSection>()
            .having((e) => e.preTabsTextLines, "preTabsTextLines", ["A"])
            .having((e) => e.chords, "chordSections", hasLength(1))
            .having((e) => e.tabLines, "tabLines", hasLength(6))
      ]);
    });

    test('should correctly parse a content that contains tab, text and chords', () {
      const content = '''[Primeira Parte]

#t1#[Tab - Primeira Parte]

Parte 1 de 4
   <b>Bm</b>   
#t2#E|------------------------------------------|
B|------------------------------------------|
G|------------------------------------------|
D|-------0-------0-------0-------0----------|
A|---5-------5-------5-------5--------------|
E|-7---7---7---7---7---7---7---7------------|#/t2##/t1#

<b>Bm</b>                   <b>A11</b>
   És adorado entre nós
<b>G</b>                 <b>Em7</b>
  Tão desejado aqui
<b>Bm</b>                     <b>A11</b>
   Mas nada se comparará
                        <b>Em7</b>  <b>G</b>  <b>A11</b>
Com a glória que há de vir,  oh

[Segunda Parte]
        <b>G7M</b>                 <b>A9</b>    
Eu não sou daqui, pra casa voltarei
''';

      final sections = ParseSections().call(content);

      expect(sections, [
        isA<TextSection>().having((e) => e.text, "text", "[Primeira Parte]\n\n"),
        isA<TabSection>(),
        isA<TextSection>().having((e) => e.text, "text", '\n\n'),
        isA<MultiLineChordsSection>()
            .having((e) => e.text, "text", "Bm                   A11\n   És adorado entre nós"),
        isA<MultiLineChordsSection>().having((e) => e.text, "text", "G                 Em7\n  Tão desejado aqui"),
        isA<MultiLineChordsSection>()
            .having((e) => e.text, "text", "Bm                     A11\n   Mas nada se comparará"),
        isA<MultiLineChordsSection>()
            .having((e) => e.text, "text", "                        Em7  G  A11\nCom a glória que há de vir,  oh"),
        isA<TextSection>().having((e) => e.text, "text", '\n\n'),
        isA<TextSection>().having((e) => e.text, "text", "[Segunda Parte]\n"),
        isA<MultiLineChordsSection>()
            .having((e) => e.text, "text", "        G7M                 A9    \nEu não sou daqui, pra casa voltarei"),
      ]);
    });

    test('should remove all zero-width characters from the string', () {
      final sections = ParseSections().call("\u{200C}Kare \u{200C}Uta\u{200C}");
      expect(sections, [isA<TextSection>().having((e) => e.text, "text", "Kare Uta\n")]);
    });

    test('an empty string should return an empty array', () {
      final sections = ParseSections().call('');
      expect(sections, isEmpty);
    });
  });
}
