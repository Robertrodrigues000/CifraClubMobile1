import 'package:cifraclub/domain/version/models/chord.dart';
import 'package:isar/isar.dart';

part 'user_chord_dto.g.dart';

@embedded
class UserChordDto {
  late final String chord;
  late final String alt;
  late final List<String>? guitar;
  late final List<String>? cavaco;
  late final List<String>? keyboard;
  late final List<String>? ukulele;
  late final List<String>? viola;
  late final List<String>? violaMi;
  late final List<String>? violaRa;

  UserChordDto();

  UserChordDto.fromDomain(Chord chords) {
    chord = chords.chord;
    alt = chords.alt;
    guitar = chords.guitar;
    cavaco = chords.cavaco;
    keyboard = chords.keyboard;
    ukulele = chords.ukulele;
    viola = chords.viola;
    violaMi = chords.violaMi;
    violaRa = chords.violaRa;
  }
}
