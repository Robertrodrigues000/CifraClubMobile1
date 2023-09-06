import 'package:cifraclub/domain/section/models/chord_text.dart';
import 'package:cifraclub/domain/section/models/section_offset.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('when clone is called,', () {
    test('should create a new instance with current values', () {
      final oldChordText = ChordText(
        name: "A",
        offset: const SectionOffset(start: 10, end: 18),
      );
      final newChordText = oldChordText.clone();

      expect(identical(oldChordText, newChordText), isFalse);
      expect(identical(oldChordText.offset, newChordText.offset), isFalse);
      expect(newChordText.name, oldChordText.name);
      expect(newChordText.offset.start, oldChordText.offset.start);
      expect(newChordText.offset.end, oldChordText.offset.end);
    });
  });
}
