import 'package:cifraclub/domain/chord/models/chord_representation.dart';
import 'package:cifraclub/domain/chord/models/instrument_chord_representation.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetChordsRepresentation {
  GetChordsRepresentation();

  List<ChordRepresentation> call({
    required List<String> chords,
    required Instrument instrument,
    bool isLeftHanded = false,
  }) {
    final chordsRepresentation = <ChordRepresentation>[];
    InstrumentChordRepresentation instrumentChordRepresentations = GuitarChordRepresentation();
    switch (instrument) {
      case Instrument.cavaco:
        instrumentChordRepresentations = CavacoChordRepresentation();
      case Instrument.ukulele:
        instrumentChordRepresentations = UkuleleChordRepresentation();
      case Instrument.violaCaipira:
        instrumentChordRepresentations = ViolaChordRepresentation();
      default:
        instrumentChordRepresentations = GuitarChordRepresentation();
    }
    for (var chord in chords) {
      chordsRepresentation.add(instrumentChordRepresentations.buildChord(original: chord, isLeftHanded: isLeftHanded));
    }
    return chordsRepresentation;
  }
}
