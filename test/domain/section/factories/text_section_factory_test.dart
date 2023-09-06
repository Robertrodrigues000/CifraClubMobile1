import 'package:cifraclub/domain/section/factories/text_section_factory.dart';
import 'package:cifraclub/domain/section/models/text_section.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('when match is called,', () {
    test('a multi-line text should create a TextSection with the first line and separators', () {
      const text = 'First line\n\n\nSecond line\n';
      final result = TextSectionFactory().match(text, 0);
      expect(result?.sections, [isA<TextSection>().having((e) => e.text, "text", 'First line\n\n\n')]);
    });

    test('a text with no new-line separator should return null', () {
      const text = '123';
      final result = TextSectionFactory().match(text, 0);
      expect(result, isNull);
    });

    test('a text that contains a chord pattern should not be parsed', () {
      const text = '<b>A</b>\n';
      final result = TextSectionFactory().match(text, 0);
      expect(result?.sections, [isA<TextSection>().having((e) => e.text, "text", text)]);
    });
  });
}
