import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/domain/search/models/song_search.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'add_versions_to_list_state.g.dart';

@CopyWith()
class AddVersionsToListState {
  final List<SongSearch> songs;
  final bool isPro;
  final int versionsLimit;
  final int versionsCount;
  final ListLimitState limitState;
  final List<SongSearch> selectedVersions;
  final bool isLoading;

  const AddVersionsToListState({
    this.songs = const [],
    this.isPro = false,
    this.versionsLimit = 0,
    this.versionsCount = 0,
    this.limitState = ListLimitState.withinLimit,
    this.selectedVersions = const [],
    this.isLoading = false,
  });
}
