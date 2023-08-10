// coverage:ignore-file
import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'save_version_to_list_state.g.dart';

@CopyWith()
class SaveVersionToListState {
  final bool isLoading;
  final RequestError? error;
  final List<Songbook> specialLists;
  final List<Songbook> userLists;
  final bool isPro;
  final ListLimitState listState;
  const SaveVersionToListState({
    this.isLoading = false,
    this.isPro = false,
    this.error,
    this.listState = ListLimitState.withinLimit,
    this.specialLists = const [],
    this.userLists = const [],
  });
}
