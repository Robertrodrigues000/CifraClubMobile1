import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/songbook_version_input.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class DeleteVersionFromFavoritesOrCanPlay {
  final UserVersionRepository _userVersionRepository;
  final SongbookRepository _songbookRepository;
  final UserSongbookRepository _userSongbookRepository;

  const DeleteVersionFromFavoritesOrCanPlay(
    this._userVersionRepository,
    this._songbookRepository,
    this._userSongbookRepository,
  );

  Future<Result<void, RequestError>> call({required Version version, required int songbookId}) async {
    final versionInput = SongbookVersionInput.fromVersion(version);

    return _songbookRepository
        .deleteVersionsFromFavoriteAndCanPlay(songbookId: songbookId, versionInput: versionInput)
        .then((result) async {
      if (result.isSuccess) {
        final localDatabaseIds = version.localDatabaseId ?? -1;
        await Future.wait([
          _userVersionRepository.deleteVersionsById([localDatabaseIds], songbookId),
          _userSongbookRepository.updateTotalSongs(songbookId: songbookId),
        ]);
      }
      return result;
    });
  }
}
