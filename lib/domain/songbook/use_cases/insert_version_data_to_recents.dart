import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_version_data_to_songbook.dart';
import 'package:cifraclub/domain/version/models/version_data.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class InsertVersionDataToRecents {
  final InsertVersionDataToSongbook _insertVersionDataToSongbook;
  final UserVersionRepository _userVersionRepository;

  final _maxVersionsInRecents = 50;

  InsertVersionDataToRecents(this._insertVersionDataToSongbook, this._userVersionRepository);

  Future<Result<int, RequestError>> call({required VersionData versionData}) async {
    var versionLocalDatabaseId =
        await _userVersionRepository.getLocalDatabaseIdFromSongIdInRecentSongbook(versionData.song.songId);

    return _insertVersionDataToSongbook(
            versionData: versionData,
            songbookId: ListType.recents.localId,
            versionLocalDatabaseId: versionLocalDatabaseId)
        .then((songId) async {
      var versionCount = await _userVersionRepository.getTotalRecentVersions();
      if (versionCount > _maxVersionsInRecents) {
        await _userVersionRepository.deleteOldestRecentVersion();
      }
      return songId;
    });
  }
}
