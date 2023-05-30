import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/domain/search/models/song_search.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'add_cifras_to_list_state.g.dart';

@CopyWith()
class AddCifrasToListState {
  final List<SongSearch> songs;
  final bool isPro;
  final int tabsLimit;
  final int tabsCount;
  final ListLimitState limitState;
  final List<SongSearch> selectedCifras;
  final bool isLoading;

  const AddCifrasToListState({
    this.songs = const [],
    this.isPro = false,
    this.tabsLimit = 0,
    this.tabsCount = 0,
    this.limitState = ListLimitState.withinLimit,
    this.selectedCifras = const [],
    this.isLoading = false,
  });
}
