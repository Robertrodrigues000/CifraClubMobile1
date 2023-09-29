import 'package:cifraclub/domain/version/models/instrument.dart';

class Chord {
  final String name;
  final String shapeName;
  final List<String>? guitar;
  final List<String>? cavaco;
  final List<String>? keyboard;
  final List<String>? ukulele;
  final List<String>? viola;
  final List<String>? violaMi;
  final List<String>? violaRa;

  Chord({
    required this.name,
    required this.shapeName,
    required this.guitar,
    required this.cavaco,
    required this.keyboard,
    required this.ukulele,
    required this.viola,
    required this.violaMi,
    required this.violaRa,
  });

  List<String>? getChordsForInstrument(Instrument instrument) {
    return switch (instrument) {
      Instrument.guitar => guitar,
      Instrument.cavaco => cavaco,
      Instrument.keyboard => keyboard,
      Instrument.ukulele => ukulele,
      Instrument.violaCaipira => viola,
      _ => null,
    };
  }
}
