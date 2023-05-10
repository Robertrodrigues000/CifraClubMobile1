import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/user/models/user.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'lists_state.g.dart';

// coverage:ignore-file
@CopyWith()
class ListsState {
  final List<Songbook> userLists;
  final List<Songbook> specialLists;
  final bool isSyncing;
  final User? user;
  final bool? isError;
  final bool isPro;
  final int listCount;
  final int listLimit;
  final ListLimitState listState;

  const ListsState({
    this.userLists = const [],
    this.specialLists = const [],
    this.isSyncing = false,
    this.user,
    this.isError,
    this.isPro = false,
    this.listCount = 0,
    this.listLimit = 10,
    this.listState = ListLimitState.withinLimit,
  });
}
