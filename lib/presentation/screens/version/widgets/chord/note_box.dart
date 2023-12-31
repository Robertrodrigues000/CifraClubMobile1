import 'package:cifraclub/domain/chord/models/note.dart';
import 'package:cifraclub/domain/chord/models/note_state.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class NoteBox extends StatelessWidget {
  final Note note;
  final double noteSize;

  const NoteBox({
    super.key,
    required this.note,
    required this.noteSize,
  });

  @override
  Widget build(BuildContext context) {
    final drawable = _getDrawableFromNoteType(note);

    return SvgImage(
      assetPath: drawable,
      width: noteSize,
      height: noteSize,
      color: context.colors.textPrimary,
    );
  }

  String _getDrawableFromNoteType(Note note) {
    switch (note.noteState) {
      case NoteState.picked:
        return AppSvgs.pickedStringIcon;
      case NoteState.notPicked:
        return AppSvgs.unpickedStringIcon;
      case NoteState.bassNote:
        return AppSvgs.bassStringIcon;
    }
  }
}
