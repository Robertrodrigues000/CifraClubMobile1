import 'package:cifraclub/domain/chord/models/instrument_chord.dart';
import 'package:cifraclub/domain/chord/use_cases/get_chords_representation.dart';
import 'package:cifraclub/domain/chord/use_cases/get_instrument_chords.dart';
import 'package:cifraclub/presentation/screens/version/middlewares/version_middleware.dart';
import 'package:cifraclub/presentation/screens/version/version_action.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChordMiddleware extends VersionMiddleware {
  final GetChordsRepresentation _getChordsRepresentation;
  final GetInstrumentChords _getInstrumentChords;

  ChordMiddleware(this._getChordsRepresentation, this._getInstrumentChords);

  @override
  void onAction(VersionAction action, VersionState state, ActionEmitter addAction) {
    switch (action) {
      case OnVersionLoaded():
        final instrumentChords = _getInstrumentChords(action.versionData.chords ?? [], action.versionData.instrument);
        final chordRepresentation =
            _getChordsRepresentation(chords: instrumentChords, instrument: action.versionData.instrument);
        addAction(OnChordListLoaded(chordRepresentation));
      case OnChordShapeChange():
        final changedIndex =
            state.chordState.chordRepresentations.indexWhere((element) => element.name == action.chord.name);
        final chordRepresentation = state.chordState.chordRepresentations..[changedIndex] = action.chord;
        addAction(OnChordListLoaded(chordRepresentation));
      case OnChordTap():
        final chords = _getChordsRepresentation(
            chords: state.version!.chords!
                .firstWhere((element) => element.name == action.selectedChord.name)
                .getChordsForInstrument(action.instrument)!
                .map((e) => InstrumentChord(
                      name: action.selectedChord.name,
                      fretDiagram: e,
                      shapeName: action.selectedChord.name,
                    ))
                .toList(),
            instrument: action.instrument);
        addAction(
          OnShowChordShapeBottomSheet(
            instrument: action.instrument,
            selectedChord: action.selectedChord,
            chords: chords,
          ),
        );

      default:
        break;
    }
  }
}
