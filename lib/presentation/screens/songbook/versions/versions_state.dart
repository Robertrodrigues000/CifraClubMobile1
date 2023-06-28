import 'package:cifraclub/domain/version/models/version.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'versions_state.g.dart';

@CopyWith()
class VersionsState {
  final List<Version> versions;
  final bool isPublic;

  const VersionsState({
    this.versions = const [],
    required this.isPublic,
  });
}
