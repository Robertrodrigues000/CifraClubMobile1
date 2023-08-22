import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/domain/search/models/search_models/song_search.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'add_versions_to_list_state.g.dart';

@CopyWith()
class AddVersionsToListState {
  final int songbookId;
  final List<SongSearch> songs;
  final bool isPro;
  final int versionsLimit;
  final int songsCount;
  final int savedSongsCount;
  final ListLimitState limitState;
  final List<SongSearch> selectedSongs;
  final bool isLoading;
  final List<int?> songsId;
  final bool isHistory;

  const AddVersionsToListState(
      {required this.songbookId,
      this.songs = const [],
      this.isPro = false,
      this.versionsLimit = 0,
      this.songsCount = 0,
      this.savedSongsCount = 0,
      this.limitState = ListLimitState.withinLimit,
      this.selectedSongs = const [],
      this.isLoading = false,
      this.songsId = const [],
      this.isHistory = true});
}
