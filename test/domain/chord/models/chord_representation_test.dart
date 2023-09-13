import 'package:cifraclub/domain/chord/models/bar.dart';
import 'package:cifraclub/domain/chord/models/chord_representation.dart';
import 'package:cifraclub/domain/chord/models/finger.dart';
import 'package:cifraclub/domain/chord/models/instrument_chord_representation.dart';
import 'package:cifraclub/domain/chord/models/neck.dart';
import 'package:cifraclub/domain/chord/models/note.dart';
import 'package:cifraclub/domain/chord/models/note_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("When copyWith is called should return new object with the values updated", () {
    final chordRepresentation = ChordRepresentation(
        name: "A",
        original: "X02220",
        neck: const Neck(start: 0),
        bar: const Bar(string: 2, fret: 5),
        fingers: const [
          Finger(id: 1, fret: 2, string: 2),
          Finger(id: 2, fret: 2, string: 3),
          Finger(id: 3, fret: 2, string: 4)
        ],
        notes: const [
          Note(NoteState.notPicked),
          Note(NoteState.bassNote),
          Note(NoteState.picked),
          Note(NoteState.picked),
          Note(NoteState.picked),
          Note(NoteState.picked)
        ],
        instrument: GuitarChordRepresentation());

    final chordRepresentationCopy = chordRepresentation.copyWith(original: "002210");

    expect(chordRepresentation == chordRepresentationCopy, true);
    expect(chordRepresentationCopy.original, "002210");
    expect(chordRepresentationCopy.neck, chordRepresentation.neck);
    expect(
      chordRepresentationCopy.fingers,
      chordRepresentation.fingers,
    );
    expect(chordRepresentationCopy.notes, chordRepresentation.notes);
  });

  test("When copyRemovingBar is called should return new object without bar", () {
    final chordRepresentation = ChordRepresentation(
        name: "A",
        original: "X02220",
        neck: const Neck(start: 0),
        bar: const Bar(string: 4, fret: 2, endString: null),
        fingers: const [
          Finger(id: 1, fret: 2, string: 2),
          Finger(id: 2, fret: 2, string: 3),
          Finger(id: 3, fret: 2, string: 4)
        ],
        notes: const [
          Note(NoteState.notPicked),
          Note(NoteState.bassNote),
          Note(NoteState.picked),
          Note(NoteState.picked),
          Note(NoteState.picked),
          Note(NoteState.picked)
        ],
        instrument: GuitarChordRepresentation());

    final chordRepresentationCopy = chordRepresentation.copyRemovingBar();

    expect(chordRepresentation == chordRepresentationCopy, false);
    expect(chordRepresentationCopy.original, chordRepresentation.original);
    expect(chordRepresentationCopy.notes, chordRepresentation.notes);
    expect(chordRepresentationCopy.fingers, chordRepresentation.fingers);
    expect(chordRepresentationCopy.bar, null);
  });
}
