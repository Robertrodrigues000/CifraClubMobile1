import 'package:cifraclub/domain/version/models/musical_scale.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("When `getMusicalScale` should return a scale of a key string", () {
    final resultDm = MusicalScale.getMusicalScale("Dm");
    final resultFsharp = MusicalScale.getMusicalScale("F#");

    expect(resultDm, 5);
    expect(resultFsharp, 9);
  });
}
