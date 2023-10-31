// coverage:ignore-file
import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/lists_state.dart';

abstract class SaveToListResult {}

class VersionListLimitStateReached implements SaveToListResult {
  final int versionsLimit;

  const VersionListLimitStateReached({required this.versionsLimit});
}

class ListLimitStateReached implements SaveToListResult {
  final int listLimit;

  const ListLimitStateReached({required this.listLimit});
}

class SaveVersionToListCompleted implements SaveToListResult {
  final String name;
  final bool showListsLimitWarning;
  final ListLimitWarning? limitWarning;
  final bool isNewList;
  const SaveVersionToListCompleted({
    required this.name,
    required this.isNewList,
    required this.showListsLimitWarning,
    this.limitWarning,
  });
}

class SaveToListError implements SaveToListResult {
  final ListLimitState? listLimitState;

  SaveToListError({this.listLimitState});
}

class VersionIsAlreadyOnListError implements SaveToListResult {}
