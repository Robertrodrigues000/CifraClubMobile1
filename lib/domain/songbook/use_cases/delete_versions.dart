import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class DeleteVersions {
  final SongbookRepository _songbookRepository;
  final UserVersionRepository _userVersionRepository;
  final UserSongbookRepository _userSongbookRepository;

  DeleteVersions(this._songbookRepository, this._userVersionRepository, this._userSongbookRepository);

  Future<Result<void, RequestError>> call({required int songbookId, required List<Version> versions}) async {
    final songsRemoteIds = versions.map((e) => e.remoteDatabaseId ?? -1).toList();

    return _songbookRepository.deleteVersions(songbookId: songbookId, versionsId: songsRemoteIds).then(
      (result) async {
        if (result.isSuccess) {
          final songsId = ListType.recents.localId != songbookId
              ? songsRemoteIds
              : versions.map((e) => e.localDatabaseId ?? -1).toList();
          final songsAdded = await _userVersionRepository.deleteVersionsById(songsId) ?? 0;
          await _userSongbookRepository.decrementTotalSongs(songbookId: songbookId, quantity: songsAdded);
        }
        return result;
      },
    );
  }
}
