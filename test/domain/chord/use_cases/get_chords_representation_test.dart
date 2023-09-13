import 'package:cifraclub/domain/chord/models/bar.dart';
import 'package:cifraclub/domain/chord/models/finger.dart';
import 'package:cifraclub/domain/chord/models/instrument_chord.dart';
import 'package:cifraclub/domain/chord/models/instrument_chord_representation.dart';
import 'package:cifraclub/domain/chord/models/neck.dart';
import 'package:cifraclub/domain/chord/models/note.dart';
import 'package:cifraclub/domain/chord/models/note_state.dart';
import 'package:cifraclub/domain/chord/user_cases/get_chords_representation.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("When GetChordsRepresentation is called", () {
    group("when instrument is Guitar", () {
      test('Should return correct ChordRepresentation', () async {
        final List<InstrumentChord> chords = [InstrumentChord(name: "A", original: "X 0 2 2 2 0")];

        final getChordsRepresentation = GetChordsRepresentation();

        final chordRepresentation = getChordsRepresentation(chords: chords, instrument: Instrument.guitar).first;

        expect(chordRepresentation.bar, null);
        expect(chordRepresentation.notes.length, 6);
        expect(chordRepresentation.notes, const [
          Note(NoteState.picked),
          Note(NoteState.picked),
          Note(NoteState.picked),
          Note(NoteState.picked),
          Note(NoteState.bassNote),
          Note(NoteState.notPicked)
        ]);
        expect(chordRepresentation.fingers.length, 3);
        expect(chordRepresentation.fingers.first, const Finger(id: 1, fret: 2, string: 4));
        expect(chordRepresentation.fingers.last, const Finger(id: 3, fret: 2, string: 2));
        expect(chordRepresentation.instrument, isA<GuitarChordRepresentation>());
      });

      test('and chord has two X, should return correct ChordRepresentation', () async {
        final List<InstrumentChord> chords = [InstrumentChord(name: "", original: "X 1 2 1 2 X")];

        final getChordsRepresentation = GetChordsRepresentation();

        final chordRepresentation = getChordsRepresentation(chords: chords, instrument: Instrument.guitar).first;

        expect(chordRepresentation.bar, null);
        expect(chordRepresentation.notes.length, 6);
        expect(chordRepresentation.notes, const [
          Note(NoteState.notPicked),
          Note(NoteState.picked),
          Note(NoteState.picked),
          Note(NoteState.picked),
          Note(NoteState.bassNote),
          Note(NoteState.notPicked),
        ]);
        expect(chordRepresentation.fingers.length, 4);
        expect(chordRepresentation.fingers, const [
          Finger(id: 1, fret: 1, string: 5),
          Finger(id: 2, fret: 1, string: 3),
          Finger(id: 3, fret: 2, string: 4),
          Finger(id: 4, fret: 2, string: 2)
        ]);

        expect(chordRepresentation.instrument, isA<GuitarChordRepresentation>());
      });

      test('and chord has `pestana` should return correct ChordRepresentation', () async {
        final List<InstrumentChord> chords = [InstrumentChord(name: "", original: "X 2 2 2 2 2")];

        final getChordsRepresentation = GetChordsRepresentation();

        final chordRepresentation = getChordsRepresentation(chords: chords, instrument: Instrument.guitar).first;

        expect(chordRepresentation.bar, const Bar(string: 5, fret: 2, endString: null));
        expect(chordRepresentation.notes.length, 6);
        expect(chordRepresentation.notes, const [
          Note(NoteState.picked),
          Note(NoteState.picked),
          Note(NoteState.picked),
          Note(NoteState.picked),
          Note(NoteState.bassNote),
          Note(NoteState.notPicked),
        ]);
        expect(chordRepresentation.fingers.isEmpty, true);
        expect(chordRepresentation.instrument, isA<GuitarChordRepresentation>());
      });

      test('and chord uses more than two frets should return correct ChordRepresentation', () async {
        final List<InstrumentChord> chords = [InstrumentChord(name: "", original: "5 X 5 4 2 X")];
        final getChordsRepresentation = GetChordsRepresentation();

        final chordRepresentation = getChordsRepresentation(chords: chords, instrument: Instrument.guitar).first;

        expect(chordRepresentation.bar, null);
        expect(chordRepresentation.notes.length, 6);
        expect(chordRepresentation.notes, const [
          Note(NoteState.notPicked),
          Note(NoteState.picked),
          Note(NoteState.picked),
          Note(NoteState.picked),
          Note(NoteState.notPicked),
          Note(NoteState.bassNote),
        ]);
        expect(chordRepresentation.fingers, const [
          Finger(id: 1, fret: 2, string: 2),
          Finger(id: 2, fret: 4, string: 3),
          Finger(id: 3, fret: 5, string: 6),
          Finger(id: 4, fret: 5, string: 4),
        ]);
        expect(chordRepresentation.instrument, isA<GuitarChordRepresentation>());
      });

      test('and chord has `pestana` with fingers should return correct ChordRepresentation', () async {
        final List<InstrumentChord> chords = [InstrumentChord(name: "", original: "2 4 4 2 2 2")];
        final getChordsRepresentation = GetChordsRepresentation();

        final chordRepresentation = getChordsRepresentation(chords: chords, instrument: Instrument.guitar).first;

        expect(chordRepresentation.bar, const Bar(string: 6, fret: 2, endString: null));
        expect(chordRepresentation.notes.length, 6);
        expect(chordRepresentation.notes, const [
          Note(NoteState.picked),
          Note(NoteState.picked),
          Note(NoteState.picked),
          Note(NoteState.picked),
          Note(NoteState.picked),
          Note(NoteState.bassNote),
        ]);
        expect(chordRepresentation.fingers, const [
          Finger(id: 3, fret: 4, string: 5),
          Finger(id: 4, fret: 4, string: 4),
        ]);
        expect(chordRepresentation.instrument, isA<GuitarChordRepresentation>());
      });
    });

    group("when instrument is Cavaco", () {
      test('and chord has pestana Should return correct ChordRepresentation', () async {
        final List<InstrumentChord> chords = [InstrumentChord(name: "", original: "P2 2 2 2")];
        final getChordsRepresentation = GetChordsRepresentation();

        final chordRepresentation = getChordsRepresentation(chords: chords, instrument: Instrument.cavaco).first;

        expect(chordRepresentation.bar, const Bar(string: 4, fret: 2, endString: null));
        expect(chordRepresentation.notes.length, 4);
        expect(chordRepresentation.notes, const [
          Note(NoteState.picked),
          Note(NoteState.picked),
          Note(NoteState.picked),
          Note(NoteState.bassNote),
        ]);
        expect(chordRepresentation.fingers.isEmpty, true);
        expect(chordRepresentation.instrument, isA<CavacoChordRepresentation>());
      });
    });

    test('and chord has pestana with fingers should return correct ChordRepresentation', () async {
      final List<InstrumentChord> chords = [InstrumentChord(name: "", original: "8 6 P5 5")];
      final getChordsRepresentation = GetChordsRepresentation();

      final chordRepresentation = getChordsRepresentation(chords: chords, instrument: Instrument.cavaco).first;

      expect(chordRepresentation.bar, const Bar(string: 2, fret: 1, endString: null));
      expect(chordRepresentation.notes.length, 4);
      expect(chordRepresentation.notes, const [
        Note(NoteState.picked),
        Note(NoteState.picked),
        Note(NoteState.picked),
        Note(NoteState.bassNote),
      ]);
      expect(chordRepresentation.fingers, const [
        Finger(id: 3, fret: 2, string: 3),
        Finger(id: 4, fret: 4, string: 4),
      ]);
      expect(chordRepresentation.instrument, isA<CavacoChordRepresentation>());
    });

    test('and chord uses 4 fingers should return correct ChordRepresentation', () async {
      final List<InstrumentChord> chords = [InstrumentChord(name: "", original: "7 6 8 9")];
      final getChordsRepresentation = GetChordsRepresentation();

      final chordRepresentation = getChordsRepresentation(chords: chords, instrument: Instrument.cavaco).first;

      expect(chordRepresentation.bar, null);
      expect(chordRepresentation.neck, const Neck(start: 6));
      expect(chordRepresentation.notes.length, 4);
      expect(chordRepresentation.notes, const [
        Note(NoteState.picked),
        Note(NoteState.picked),
        Note(NoteState.picked),
        Note(NoteState.bassNote),
      ]);
      expect(chordRepresentation.fingers, const [
        Finger(id: 1, fret: 1, string: 3),
        Finger(id: 2, fret: 2, string: 4),
        Finger(id: 3, fret: 3, string: 2),
        Finger(id: 4, fret: 4, string: 1),
      ]);
      expect(chordRepresentation.instrument, isA<CavacoChordRepresentation>());
    });

    group("when instrument is ukulele", () {
      test('should return correct ChordRepresentation', () async {
        final List<InstrumentChord> chords = [InstrumentChord(name: "", original: "3 1 0 1")];
        final getChordsRepresentation = GetChordsRepresentation();

        final chordRepresentation = getChordsRepresentation(chords: chords, instrument: Instrument.ukulele).first;

        expect(chordRepresentation.bar, null);
        expect(chordRepresentation.neck, const Neck(start: 0));
        expect(chordRepresentation.notes.length, 4);
        expect(chordRepresentation.notes, const [
          Note(NoteState.picked),
          Note(NoteState.picked),
          Note(NoteState.picked),
          Note(NoteState.bassNote),
        ]);
        expect(chordRepresentation.fingers, const [
          Finger(id: 1, fret: 1, string: 3),
          Finger(id: 2, fret: 1, string: 1),
          Finger(id: 3, fret: 3, string: 4),
        ]);
        expect(chordRepresentation.instrument, isA<UkuleleChordRepresentation>());
      });
    });

    test('and chord uses 2 fingers should return correct ChordRepresentation', () async {
      final List<InstrumentChord> chords = [InstrumentChord(name: "", original: "2 4 0 0")];
      final getChordsRepresentation = GetChordsRepresentation();

      final chordRepresentation = getChordsRepresentation(chords: chords, instrument: Instrument.ukulele).first;

      expect(chordRepresentation.bar, null);
      expect(chordRepresentation.neck, const Neck(start: 0));
      expect(chordRepresentation.notes.length, 4);
      expect(chordRepresentation.notes, const [
        Note(NoteState.picked),
        Note(NoteState.picked),
        Note(NoteState.picked),
        Note(NoteState.bassNote),
      ]);
      expect(chordRepresentation.fingers, const [
        Finger(id: 1, fret: 2, string: 4),
        Finger(id: 3, fret: 4, string: 3),
      ]);
      expect(chordRepresentation.instrument, isA<UkuleleChordRepresentation>());
    });

    test('and chord uses 4 fingers should return correct ChordRepresentation', () async {
      final List<InstrumentChord> chords = [InstrumentChord(name: "", original: "3 3 2 2")];
      final getChordsRepresentation = GetChordsRepresentation();

      final chordRepresentation = getChordsRepresentation(chords: chords, instrument: Instrument.ukulele).first;

      expect(chordRepresentation.bar, null);
      expect(chordRepresentation.neck, const Neck(start: 0));
      expect(chordRepresentation.notes.length, 4);
      expect(chordRepresentation.notes, const [
        Note(NoteState.picked),
        Note(NoteState.picked),
        Note(NoteState.picked),
        Note(NoteState.bassNote),
      ]);
      expect(chordRepresentation.fingers, const [
        Finger(id: 1, fret: 2, string: 2),
        Finger(id: 2, fret: 2, string: 1),
        Finger(id: 3, fret: 3, string: 4),
        Finger(id: 4, fret: 3, string: 3),
      ]);
      expect(chordRepresentation.instrument, isA<UkuleleChordRepresentation>());
    });

    test('and chord begins at a higher fret should return correct ChordRepresentation', () async {
      final List<InstrumentChord> chords = [InstrumentChord(name: "", original: "6 5 7 5")];
      final getChordsRepresentation = GetChordsRepresentation();

      final chordRepresentation = getChordsRepresentation(chords: chords, instrument: Instrument.ukulele).first;

      expect(chordRepresentation.bar, null);
      expect(chordRepresentation.neck, const Neck(start: 5));
      expect(chordRepresentation.notes.length, 4);
      expect(chordRepresentation.notes, const [
        Note(NoteState.picked),
        Note(NoteState.picked),
        Note(NoteState.picked),
        Note(NoteState.bassNote),
      ]);
      expect(chordRepresentation.fingers, const [
        Finger(id: 1, fret: 1, string: 3),
        Finger(id: 2, fret: 1, string: 1),
        Finger(id: 3, fret: 2, string: 4),
        Finger(id: 4, fret: 3, string: 2),
      ]);
      expect(chordRepresentation.instrument, isA<UkuleleChordRepresentation>());
    });

    test('and chord has no fingers should return correct ChordRepresentation', () async {
      final List<InstrumentChord> chords = [InstrumentChord(name: "", original: "0 0 0 0")];
      final getChordsRepresentation = GetChordsRepresentation();

      final chordRepresentation = getChordsRepresentation(chords: chords, instrument: Instrument.ukulele).first;

      expect(chordRepresentation.bar, null);
      expect(chordRepresentation.neck, const Neck(start: 0));
      expect(chordRepresentation.notes.length, 4);
      expect(chordRepresentation.notes, const [
        Note(NoteState.picked),
        Note(NoteState.picked),
        Note(NoteState.picked),
        Note(NoteState.bassNote),
      ]);
      expect(chordRepresentation.fingers.isEmpty, true);
      expect(chordRepresentation.instrument, isA<UkuleleChordRepresentation>());
    });

    group("when instrument is viola", () {
      test('should return correct ChordRepresentation', () async {
        final List<InstrumentChord> chords = [InstrumentChord(name: "", original: "X 5 4 4 2")];
        final getChordsRepresentation = GetChordsRepresentation();

        final chordRepresentation = getChordsRepresentation(chords: chords, instrument: Instrument.violaCaipira).first;

        expect(chordRepresentation.bar, null);
        expect(chordRepresentation.neck, const Neck(start: 0));
        expect(chordRepresentation.notes.length, 5);
        expect(chordRepresentation.notes, const [
          Note(NoteState.picked),
          Note(NoteState.picked),
          Note(NoteState.picked),
          Note(NoteState.bassNote),
          Note(NoteState.notPicked),
        ]);
        expect(chordRepresentation.fingers.length, 4);
        expect(chordRepresentation.fingers, const [
          Finger(id: 1, fret: 2, string: 1),
          Finger(id: 2, fret: 4, string: 3),
          Finger(id: 3, fret: 4, string: 2),
          Finger(id: 4, fret: 5, string: 4),
        ]);
        expect(chordRepresentation.instrument, isA<ViolaChordRepresentation>());
      });

      test('and chord begins at higher fret should return correct ChordRepresentation', () async {
        final List<InstrumentChord> chords = [InstrumentChord(name: "", original: "X 7 7 7 7")];
        final getChordsRepresentation = GetChordsRepresentation();

        final chordRepresentation = getChordsRepresentation(chords: chords, instrument: Instrument.violaCaipira).first;

        expect(chordRepresentation.bar, null);
        expect(chordRepresentation.neck, const Neck(start: 7));
        expect(chordRepresentation.notes.length, 5);
        expect(chordRepresentation.notes, const [
          Note(NoteState.picked),
          Note(NoteState.picked),
          Note(NoteState.picked),
          Note(NoteState.bassNote),
          Note(NoteState.notPicked),
        ]);
        expect(chordRepresentation.fingers.length, 4);
        expect(chordRepresentation.fingers, const [
          Finger(id: 1, fret: 1, string: 4),
          Finger(id: 2, fret: 1, string: 3),
          Finger(id: 3, fret: 1, string: 2),
          Finger(id: 4, fret: 1, string: 1),
        ]);
        expect(chordRepresentation.instrument, isA<ViolaChordRepresentation>());
      });

      test('and chord has pestana should return correct ChordRepresentation', () async {
        final List<InstrumentChord> chords = [InstrumentChord(name: "", original: "4 2 2 2 2")];
        final getChordsRepresentation = GetChordsRepresentation();

        final chordRepresentation = getChordsRepresentation(chords: chords, instrument: Instrument.violaCaipira).first;

        expect(chordRepresentation.bar, const Bar(string: 4, fret: 2, endString: null));
        expect(chordRepresentation.neck, const Neck(start: 0));
        expect(chordRepresentation.notes.length, 5);
        expect(chordRepresentation.notes, const [
          Note(NoteState.picked),
          Note(NoteState.picked),
          Note(NoteState.picked),
          Note(NoteState.picked),
          Note(NoteState.bassNote),
        ]);
        expect(chordRepresentation.fingers.length, 1);
        expect(chordRepresentation.fingers, const [
          Finger(id: 3, fret: 4, string: 5),
        ]);
        expect(chordRepresentation.instrument, isA<ViolaChordRepresentation>());
      });

      test('and chord has pestana in a higher fret should return correct ChordRepresentation', () async {
        final List<InstrumentChord> chords = [InstrumentChord(name: "", original: "5 5 5 8 5")];
        final getChordsRepresentation = GetChordsRepresentation();

        final chordRepresentation = getChordsRepresentation(chords: chords, instrument: Instrument.violaCaipira).first;

        expect(chordRepresentation.bar, const Bar(string: 5, fret: 1, endString: null));
        expect(chordRepresentation.neck, const Neck(start: 5));
        expect(chordRepresentation.notes.length, 5);
        expect(chordRepresentation.notes, const [
          Note(NoteState.picked),
          Note(NoteState.picked),
          Note(NoteState.picked),
          Note(NoteState.picked),
          Note(NoteState.bassNote),
        ]);
        expect(chordRepresentation.fingers, const [
          Finger(id: 3, fret: 4, string: 2),
        ]);
        expect(chordRepresentation.instrument, isA<ViolaChordRepresentation>());
      });
    });
  });
}
