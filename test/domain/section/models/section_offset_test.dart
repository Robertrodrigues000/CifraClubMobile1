import 'package:cifraclub/domain/section/models/section_offset.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('when copyWith is called,', () {
    test('should create a new instance with provided start and end values', () {
      const oldOffset = SectionOffset(start: 1, end: 1);
      final newOffset = oldOffset.copyWith(start: 2, end: 2);

      expect(identical(oldOffset, newOffset), isFalse);
      expect(oldOffset.start, 1);
      expect(oldOffset.end, 1);
      expect(newOffset.start, 2);
      expect(newOffset.end, 2);
    });

    test('should create a new instance with current values if omitted', () {
      const oldOffset = SectionOffset(start: 5, end: 5);
      final newOffset = oldOffset.copyWith();

      expect(identical(oldOffset, newOffset), isFalse);
      expect(newOffset.start, oldOffset.start);
      expect(newOffset.end, oldOffset.end);
    });
  });
}
