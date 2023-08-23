import 'package:cifraclub/domain/shared/request_error.dart';
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
          final localDatabaseIds = versions.map((e) => e.localDatabaseId!).toList();
          final deletedSongCount = await _userVersionRepository.deleteVersionsById(localDatabaseIds, songbookId) ?? 0;
          await _userSongbookRepository.decrementTotalSongs(songbookId: songbookId, quantity: deletedSongCount);
        }
        return result;
      },
    );
  }
}
