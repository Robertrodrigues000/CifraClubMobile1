import 'package:collection/collection.dart';

enum MusicalScale {
  majorScale(["A", "Bb", "B", "C", "Db", "D", "Eb", "E", "F", "F#", "G", "Ab"]),
  minorScale(["Am", "Bbm", "Bm", "Cm", "C#m", "Dm", "Ebm", "Em", "Fm", "F#m", "Gm", "G#m"]),
  sharpScale(["A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#"]),
  bemolScale(["A", "Bb", "B", "C", "Db", "D", "Eb", "E", "F", "Gb", "G", "Ab"]);

  final List<String> notes;

  const MusicalScale(this.notes);

  static int? getMusicalScale(String key) {
    return MusicalScale.values.firstWhereOrNull((element) => element.notes.contains(key))?.notes.indexOf(key);
  }

  static MusicalScale? getMusicalScaleByKey(String? key) {
    return MusicalScale.values.firstWhereOrNull((e) => e.notes.contains(key));
  }
}
