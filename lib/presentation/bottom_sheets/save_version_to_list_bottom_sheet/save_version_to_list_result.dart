// coverage:ignore-file
import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';

sealed class SaveToListResult {}

class VersionListLimitStateReached implements SaveToListResult {
  final int versionsLimit;

  const VersionListLimitStateReached({required this.versionsLimit});
}

class SaveVersionToListCompleted implements SaveToListResult {
  final String name;
  final ListLimitState versionLimitState;
  final ListLimitState listLimitState;

  const SaveVersionToListCompleted({required this.name, required this.versionLimitState, required this.listLimitState});
}

class SaveToListError implements SaveToListResult {
  final ListLimitState? listLimitState;

  SaveToListError({this.listLimitState});
}
