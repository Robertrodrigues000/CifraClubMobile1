import 'package:cifraclub/domain/user/models/user_credential.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';

part 'songbook_state.g.dart';

@immutable
@CopyWith()
class SongbookState {
  final int? selectedSongbookId;
  final UserCredential? userCredential;

  const SongbookState({
    this.selectedSongbookId,
    this.userCredential,
  });
}
