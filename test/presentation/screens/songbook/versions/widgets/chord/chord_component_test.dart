import 'package:cifraclub/domain/chord/models/bar.dart';
import 'package:cifraclub/domain/chord/models/chord_representation.dart';
import 'package:cifraclub/domain/chord/models/finger.dart';
import 'package:cifraclub/domain/chord/models/instrument_chord_representation.dart';
import 'package:cifraclub/domain/chord/models/neck.dart';
import 'package:cifraclub/domain/chord/models/note.dart';
import 'package:cifraclub/domain/chord/models/note_state.dart';
import 'package:cifraclub/presentation/screens/version/widgets/chord/bar_widget.dart';
import 'package:cifraclub/presentation/screens/version/widgets/chord/chord_widget.dart';
import 'package:cifraclub/presentation/screens/version/widgets/chord/chord_ui_settings.dart';
import 'package:cifraclub/presentation/screens/version/widgets/chord/finger_widget.dart';
import 'package:cifraclub/presentation/screens/version/widgets/chord/fret_number_widget.dart';
import 'package:cifraclub/presentation/screens/version/widgets/chord/note_box.dart';
import 'package:cifraclub/presentation/screens/version/widgets/chord/string_play_indication_widget.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When chord representation has one finger, should show one finger component", (widgetTester) async {
    final chordRepresentation = ChordRepresentation(
        original: "X00100",
        neck: const Neck(start: 0),
        fingers: const [
          Finger(id: 3, fret: 4, string: 5),
        ],
        notes: const [],
        instrument: GuitarChordRepresentation(),
        name: "A");

    await widgetTester.pumpWidget(
      TestWrapper(
        child: ChordWidget(
          chordUiSettings: ChordUISettings.guitar(),
          chordRepresentation: chordRepresentation,
          isLeftHanded: false,
          isSelected: false,
        ),
      ),
    );

    expect(find.byType(FingerWidget), findsOneWidget);
  });

  testWidgets("When chord representation has 4 fingers, should show one 4 finger components", (widgetTester) async {
    final chordRepresentation = ChordRepresentation(
        original: "X02222",
        neck: const Neck(start: 0),
        fingers: const [
          Finger(id: 1, fret: 2, string: 4),
          Finger(id: 2, fret: 2, string: 3),
          Finger(id: 3, fret: 2, string: 2),
          Finger(id: 4, fret: 2, string: 1)
        ],
        notes: const [],
        instrument: GuitarChordRepresentation(),
        name: "A");

    await widgetTester.pumpWidget(
      TestWrapper(
        child: ChordWidget(
          chordUiSettings: ChordUISettings.guitar(),
          chordRepresentation: chordRepresentation,
          isLeftHanded: false,
          isSelected: false,
        ),
      ),
    );

    expect(find.byType(FingerWidget), findsNWidgets(4));
  });

  testWidgets("When chord has bar, should show bar component", (widgetTester) async {
    final chordRepresentation = ChordRepresentation(
        original: "2 4 4 2 2 2",
        neck: const Neck(start: 0),
        bar: const Bar(string: 6, fret: 2, endString: null),
        fingers: const [
          Finger(id: 3, fret: 4, string: 5),
          Finger(id: 4, fret: 4, string: 4),
        ],
        notes: const [],
        instrument: GuitarChordRepresentation(),
        name: "A");

    await widgetTester.pumpWidget(
      TestWrapper(
        child: ChordWidget(
          chordUiSettings: ChordUISettings.guitar(),
          chordRepresentation: chordRepresentation,
          isLeftHanded: false,
          isSelected: false,
        ),
      ),
    );

    expect(find.byType(FingerWidget), findsNWidgets(2));
    expect(find.byType(BarWidget), findsOneWidget);
  });

  testWidgets("When chord has neck start !=0, should show Neck indicator", (widgetTester) async {
    final chordRepresentation = ChordRepresentation(
        original: "2 4 4 2 2 2",
        neck: const Neck(start: 5),
        bar: const Bar(string: 6, fret: 2, endString: null),
        fingers: const [
          Finger(id: 3, fret: 4, string: 5),
          Finger(id: 4, fret: 4, string: 4),
        ],
        notes: const [],
        instrument: GuitarChordRepresentation(),
        name: "A");

    await widgetTester.pumpWidget(
      TestWrapper(
        child: ChordWidget(
          chordUiSettings: ChordUISettings.guitar(),
          chordRepresentation: chordRepresentation,
          isLeftHanded: false,
          isSelected: false,
        ),
      ),
    );

    expect(find.byType(FingerWidget), findsNWidgets(2));
    expect(find.byType(BarWidget), findsOneWidget);
    expect(find.byType(FretNumberWidget), findsOneWidget);
  });

  testWidgets("When chord representation instrument is Guitar, should show valid note components",
      (widgetTester) async {
    final chordRepresentation = ChordRepresentation(
        original: "X02222",
        neck: const Neck(start: 0),
        fingers: const [
          Finger(id: 1, fret: 2, string: 4),
          Finger(id: 2, fret: 2, string: 3),
          Finger(id: 3, fret: 2, string: 2),
          Finger(id: 4, fret: 2, string: 1)
        ],
        notes: const [
          Note(NoteState.notPicked),
          Note(NoteState.bassNote),
          Note(NoteState.picked),
          Note(NoteState.picked),
          Note(NoteState.picked),
          Note(NoteState.picked),
        ],
        instrument: GuitarChordRepresentation(),
        name: "A");

    await widgetTester.pumpWidget(
      TestWrapper(
        child: ChordWidget(
          chordUiSettings: ChordUISettings.guitar(),
          chordRepresentation: chordRepresentation,
          isLeftHanded: false,
          isSelected: false,
        ),
      ),
    );

    expect(find.byType(FingerWidget), findsNWidgets(4));
    expect(find.byType(StringPlayIndicationWidget), findsOneWidget);
    expect(find.byType(NoteBox), findsNWidgets(6));
  });
}
