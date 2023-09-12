import 'package:cifraclub/domain/search/models/search_models/search_item.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:cifraclub/domain/search/models/search_filter.dart';

part 'search_state.g.dart';

@CopyWith()
class SearchState {
  final List<Version> recent;
  final List<SearchItem> result;
  final RequestError? error;
  final bool isLoading;
  final bool shouldShowRecent;
  final SearchFilter? selectedFilter;

  const SearchState(
      {this.recent = const [],
      this.result = const [],
      this.error,
      this.isLoading = false,
      this.shouldShowRecent = true,
      this.selectedFilter});
}
