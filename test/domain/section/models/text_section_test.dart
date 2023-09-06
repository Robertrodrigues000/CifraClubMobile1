import 'package:cifraclub/domain/section/models/text_section.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('when TextSection is created,', () {
    test('should not parse any tag', () {
      const text = "#t1#<b>A</b>#t2##/t1##/t2#\n";
      final section = TextSection(text);
      expect(section.displayText, text);
      expect(section.chords, isEmpty);
      expect(section.displayChords, isEmpty);
    });
  });

  group('when processLineBreak is called,', () {
    test('should not rearrange the text', () {
      final section = TextSection("123456\n");
      section.processLineBreak(3);
      expect(section.text, "123456\n");
    });
  });
}
