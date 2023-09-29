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
      default:
        break;
    }
  }
}
