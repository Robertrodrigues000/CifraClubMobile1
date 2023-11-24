import 'package:cifraclub/domain/chord/models/chord_representation.dart';
import 'package:cifraclub/domain/chord/models/instrument_chord.dart';
import 'package:cifraclub/domain/chord/models/instrument_chord_representation.dart';
import 'package:cifraclub/domain/version/models/capo.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetChordsRepresentation {
  GetChordsRepresentation();

  List<ChordRepresentation> call({
    required List<InstrumentChord> chords,
    required Instrument instrument,
    Capo? capo,
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
      chordsRepresentation.add(instrumentChordRepresentations.buildChord(instrumentChord: chord, capo: capo));
    }
    return chordsRepresentation;
  }
}
