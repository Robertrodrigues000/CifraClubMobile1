import 'package:cifraclub/domain/chord/models/bar.dart';
import 'package:cifraclub/domain/chord/models/finger.dart';
import 'package:cifraclub/domain/chord/models/instrument_chord_representation.dart';
import 'package:cifraclub/domain/chord/models/neck.dart';
import 'package:cifraclub/domain/chord/models/note.dart';
import 'package:equatable/equatable.dart';

class ChordRepresentation extends Equatable {
  final String name;
  final String original;
  final Neck neck;
  final Bar? bar;
  final List<Note> notes;
  final List<Finger> fingers;

  const ChordRepresentation({
    required this.original,
    required this.neck,
    this.bar,
    required this.fingers,
    required this.notes,
    required this.instrument,
    required this.name,
  });

  ChordRepresentation copyWith({String? original, Neck? neck, Bar? bar, List<Note>? notes, List<Finger>? fingers}) {
    return ChordRepresentation(
      original: original ?? this.original,
      neck: neck ?? this.neck,
      bar: bar ?? this.bar,
      fingers: fingers ?? this.fingers,
      notes: notes ?? this.notes,
      instrument: instrument,
      name: name,
    );
  }

  ChordRepresentation copyRemovingBar() {
    return ChordRepresentation(
      original: original,
      neck: neck,
      fingers: fingers,
      notes: notes,
      instrument: instrument,
      name: name,
    );
  }

  final InstrumentChordRepresentation instrument;

  // coverage:ignore-start
  @override
  String toString() {
    return 'ChordRepresentation('
        'original: $original, '
        'neck: $neck, '
        'bar: $bar, '
        'notes: $notes, '
        'fingers: $fingers, '
        'instrument: $instrument)';
  }

  @override
  List<Object?> get props => [bar, fingers, notes, instrument, neck];
  // coverage:ignore-end
}