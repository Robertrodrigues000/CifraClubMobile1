import 'package:cifraclub/domain/chord/models/note_state.dart';
import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final NoteState noteState;

  const Note(
    this.noteState,
  );

  // coverage:ignore-start
  @override
  String toString() {
    return 'Note(noteState: $noteState)';
  }

  @override
  List<Object?> get props => [noteState.index];
  // coverage:ignore-end
}
