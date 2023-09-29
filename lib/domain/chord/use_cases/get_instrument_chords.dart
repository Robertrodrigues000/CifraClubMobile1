import 'package:cifraclub/domain/chord/models/instrument_chord.dart';
import 'package:cifraclub/domain/version/models/chord.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetInstrumentChords {
  List<InstrumentChord> call(List<Chord> chords, Instrument instrument) {
    return chords
        .map((chord) {
          final fretDiagram = chord.getChordsForInstrument(instrument)?.firstOrNull;
          if (fretDiagram == null) {
            return null;
          }
          return InstrumentChord(name: chord.name, fretDiagram: fretDiagram, shapeName: chord.shapeName);
        })
        .whereNotNull()
        .toList();
  }
}
