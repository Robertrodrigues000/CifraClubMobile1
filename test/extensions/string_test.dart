import 'package:cifraclub/extensions/string.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('when splitLines is called', () {
    test('should split elements between lines', () {
      expect("a\nb".splitLines(), ["a", "b"]);
    });

    test('should not create an empty string if last character is an end-line character', () {
      expect("a\n".splitLines(), ["a"]);
    });
  });
}
