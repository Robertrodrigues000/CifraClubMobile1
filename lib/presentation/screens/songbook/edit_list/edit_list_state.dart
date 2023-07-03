import 'package:cifraclub/domain/version/models/version.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'edit_list_state.g.dart';

@CopyWith()
class EditListState {
  final List<Version> versions;
  final List<Version> deletedVersions;
  final bool hasChanges;
  final int songbookId;

  const EditListState(
      {this.versions = const [], this.deletedVersions = const [], this.hasChanges = false, required this.songbookId});

  factory EditListState.fromSongbook(List<Version> versions, int songbookId) {
    return EditListState(
      versions: versions,
      songbookId: songbookId,
    );
  }
}
