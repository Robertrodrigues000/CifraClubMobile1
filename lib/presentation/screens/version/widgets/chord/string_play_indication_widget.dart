import 'package:cifraclub/domain/chord/models/chord_representation.dart';
import 'package:cifraclub/presentation/screens/version/widgets/chord/chord_ui_settings.dart';
import 'package:cifraclub/presentation/screens/version/widgets/chord/note_box.dart';
import 'package:flutter/material.dart';

class StringPlayIndicationWidget extends StatelessWidget {
  final ChordRepresentation chordRepresentation;
  final ChordUISettings chordUiSettings;
  final bool isLeftHanded;

  const StringPlayIndicationWidget({
    super.key,
    required this.chordRepresentation,
    required this.chordUiSettings,
    required this.isLeftHanded,
  });

  @override
  Widget build(BuildContext context) {
    final notes = isLeftHanded ? chordRepresentation.notes : chordRepresentation.notes.reversed.toList();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: chordUiSettings.startX - chordUiSettings.noteSize / 2),
      child: Stack(alignment: Alignment.centerLeft, children: [
        ...List.generate(chordRepresentation.notes.length, (index) {
          final note = notes[index];

          return Padding(
            padding: EdgeInsets.only(left: index * chordUiSettings.spaceBetweenStrings),
            child: NoteBox(
              note: note,
              noteSize: chordUiSettings.noteSize,
            ),
          );
        })
      ]),
    );
  }
}
