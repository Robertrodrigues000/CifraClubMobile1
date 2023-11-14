import 'dart:async';

import 'package:cifraclub/domain/chord/use_cases/get_chords_representation.dart';
import 'package:cifraclub/domain/chord/use_cases/get_instrument_chords.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/presentation/screens/version/middlewares/chord_middleware.dart';
import 'package:cifraclub/presentation/screens/version/version_action.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../shared_mocks/domain/chord/chord_representation_mock.dart';
import '../../../../shared_mocks/domain/chord/instrument_chord_mock.dart';
import '../../../../shared_mocks/domain/version/models/version_data_mock.dart';

class _GetInstrumentChordsMock extends Mock implements GetInstrumentChords {}

class _GetChordsRepresentation extends Mock implements GetChordsRepresentation {}

void main() {
  setUpAll(() {
    registerFallbackValue(Instrument.guitar);
  });
  group('When action is OnVersionLoaded', () {
    test('should emit OnChordsListLoaded action with the chords representations', () async {
      final getChordsRepresentation = _GetChordsRepresentation();
      final getInstrumentChords = _GetInstrumentChordsMock();
      final chords = [getFakeChordRepresentation(), getFakeChordRepresentation()];

      when(() => getInstrumentChords(any(), any())).thenReturn([getFakeInstrumentChord(), getFakeInstrumentChord()]);
      when(() => getChordsRepresentation(chords: any(named: "chords"), instrument: any(named: "instrument")))
          .thenReturn(chords);

      final versionData = getFakeVersionData();
      final completer = Completer<VersionAction>();
      final chordMiddleware = ChordMiddleware(getChordsRepresentation, getInstrumentChords);

      chordMiddleware.onAction(
        OnVersionLoaded(versionData),
        const VersionState(),
        completer.complete,
      );

      final versionAction = await completer.future;

      verify(() => getInstrumentChords(any(), any())).called(1);
      verify(() => getChordsRepresentation(chords: any(named: "chords"), instrument: any(named: "instrument")))
          .called(1);

      expect(versionAction, isA<OnChordListLoaded>().having((action) => action.chords, "chords", chords));
    });
  });

  test('When action is OnChordShapeChange should emit OnChordsListLoaded action with the chord index shape changed',
      () async {
    final getChordsRepresentation = _GetChordsRepresentation();
    final getInstrumentChords = _GetInstrumentChordsMock();
    final chords = [getFakeChordRepresentation(name: "A", original: "X2001"), getFakeChordRepresentation(name: "B")];
    final chord = getFakeChordRepresentation(name: "A", original: "X1023");

    when(() => getInstrumentChords(any(), any())).thenReturn([]);
    when(() => getChordsRepresentation(chords: any(named: "chords"), instrument: any(named: "instrument")))
        .thenReturn([]);

    final completer = Completer<VersionAction>();
    final chordMiddleware = ChordMiddleware(getChordsRepresentation, getInstrumentChords);

    chordMiddleware.onAction(
      OnChordShapeChange(chord: chord),
      VersionState(chordState: ChordState(chordRepresentations: chords)),
      completer.complete,
    );

    final versionAction = await completer.future;

    expect(
        versionAction, isA<OnChordListLoaded>().having((action) => action.chords[0].original, "chord", chord.original));
  });

  test('when action is OnChordTap should emit OnShowChordShapeBottomSheet action with the shapes of the chord',
      () async {
    final getChordsRepresentation = _GetChordsRepresentation();
    final getInstrumentChords = _GetInstrumentChordsMock();
    final chords = [
      getFakeChordRepresentation(),
      getFakeChordRepresentation(),
      getFakeChordRepresentation(),
      getFakeChordRepresentation()
    ];

    when(() => getInstrumentChords(any(), any())).thenReturn(
        [getFakeInstrumentChord(), getFakeInstrumentChord(), getFakeInstrumentChord(), getFakeInstrumentChord()]);
    when(() => getChordsRepresentation(chords: any(named: "chords"), instrument: any(named: "instrument")))
        .thenReturn(chords);

    final versionData = getFakeVersionData();
    final completer = Completer<VersionAction>();
    final chordMiddleware = ChordMiddleware(getChordsRepresentation, getInstrumentChords);

    final selectedChord = getFakeChordRepresentation(name: versionData.chords!.first.name);

    chordMiddleware.onAction(
      OnChordTap(instrument: Instrument.guitar, selectedChord: selectedChord),
      VersionState(version: versionData),
      completer.complete,
    );

    final versionAction = await completer.future;

    verify(() => getChordsRepresentation(chords: any(named: "chords"), instrument: any(named: "instrument"))).called(1);

    expect(
        versionAction,
        isA<OnShowChordShapeBottomSheet>()
            .having((action) => action.chords, "chords", chords)
            .having((action) => action.selectedChord, "selected chord", selectedChord)
            .having((action) => action.instrument, "instrument", Instrument.guitar));
  });
}
