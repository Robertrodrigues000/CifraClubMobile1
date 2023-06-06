import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'songbook_state.g.dart';

@CopyWith()
class SongbookState {
  final Songbook? selectedSongbook;
  final bool isUserLoggedIn;

  const SongbookState({this.selectedSongbook, required this.isUserLoggedIn});
}