// coverage:ignore-file
abstract class SaveToListResult {}

class VersionListLimitStateReached implements SaveToListResult {
  final int versionsLimit;

  VersionListLimitStateReached({required this.versionsLimit});
}

class SaveVersionToListCompleted implements SaveToListResult {
  final String name;
  final bool isNewList;
  SaveVersionToListCompleted({required this.name, required this.isNewList});
}

class SaveToListError implements SaveToListResult {}
