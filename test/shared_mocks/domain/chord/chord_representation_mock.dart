import 'package:cifraclub/domain/chord/models/bar.dart';
import 'package:cifraclub/domain/chord/models/chord_representation.dart';
import 'package:cifraclub/domain/chord/models/finger.dart';
import 'package:cifraclub/domain/chord/models/instrument_chord_representation.dart';
import 'package:cifraclub/domain/chord/models/neck.dart';
import 'package:cifraclub/domain/chord/models/note.dart';
import 'package:cifraclub/domain/chord/models/note_state.dart';
import 'package:cifraclub/domain/version/models/capo.dart';
import 'package:faker/faker.dart';

ChordRepresentation getFakeChordRepresentation(
        {String? name, String? original, Capo? capo, Neck? neck, InstrumentChordRepresentation? instrument}) =>
    ChordRepresentation(
        name: name ?? faker.animal.name(),
        original: original ?? faker.address.city(),
        neck: neck ?? Neck(start: faker.randomGenerator.integer(12, min: 1)),
        bar: Bar(string: faker.randomGenerator.integer(6, min: 1), fret: faker.randomGenerator.integer(12, min: 1)),
        fingers: List.generate(
            faker.randomGenerator.integer(5, min: 1),
            (index) => Finger(
                id: index,
                fret: faker.randomGenerator.integer(12, min: 1),
                string: faker.randomGenerator.integer(5, min: 1))),
        notes: const [
          Note(NoteState.notPicked),
          Note(NoteState.bassNote),
          Note(NoteState.picked),
          Note(NoteState.picked),
          Note(NoteState.picked),
          Note(NoteState.picked)
        ],
        instrument: instrument ?? GuitarChordRepresentation(),
        capo: capo);
