import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class DeleteSongbook {
  final SongbookRepository _songbookRepository;
  final UserSongbookRepository _userSongbookRepository;
  final UserVersionRepository _userVersionRepository;

  DeleteSongbook(this._songbookRepository, this._userSongbookRepository, this._userVersionRepository);

  Future<Result<void, RequestError>> call(int songbookId) async {
    return _songbookRepository.deleteSongbook(songbookId).then(
          (value) => value.onSuccess(
            (_) async {
              await _userVersionRepository.deleteVersionsBySongbookId(songbookId);
              await _userSongbookRepository.deleteUserSongbook(songbookId);
            },
          ),
        );
  }
}
