import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class DeleteVersionFromFavorites {
  final UserVersionRepository _userVersionRepository;
  final SongbookRepository _songbookRepository;
  final UserSongbookRepository _userSongbookRepository;

  DeleteVersionFromFavorites(this._userVersionRepository, this._songbookRepository, this._userSongbookRepository);

  Future<Result<void, RequestError>> call({required int songId}) async {
    final songbookId = ListType.favorites.localId;
    return _songbookRepository.deleteVersions(songbookId: songbookId, versionsId: [songId]).then((result) async {
      if (result.isSuccess) {
        await _userVersionRepository.deleteVersionBySongId(songId, songbookId);
        await _userSongbookRepository.updateTotalSongs(songbookId: songbookId);
      }
      return result;
    });
  }
}
