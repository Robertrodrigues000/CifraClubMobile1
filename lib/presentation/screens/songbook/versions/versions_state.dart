import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'versions_state.g.dart';

@CopyWith()
class VersionsState {
  final List<Version> versions;
  final Songbook? songbook;
  final ListLimitState versionLimitState;
  final bool isPro;
  final int versionsLimit;
  final int versionsCount;

  const VersionsState({
    this.versions = const [],
    this.songbook,
    this.versionLimitState = ListLimitState.withinLimit,
    this.isPro = false,
    this.versionsLimit = 0,
    this.versionsCount = 0,
  });
}
