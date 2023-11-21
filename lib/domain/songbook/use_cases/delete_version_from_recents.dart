import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class DeleteVersionFromRecents {
  final UserVersionRepository _userVersionRepository;
  final SongbookRepository _songbookRepository;
  final UserSongbookRepository _userSongbookRepository;

  DeleteVersionFromRecents(
    this._userVersionRepository,
    this._songbookRepository,
    this._userSongbookRepository,
  );

  Future<Result<void, RequestError>> call({required int songId, required Instrument instrument}) async {
    return _songbookRepository.deleteVersionFromRecents(songId: songId, instrument: instrument).then((result) async {
      if (result.isSuccess) {
        await Future.wait([
          _userVersionRepository.deleteVersionFromRecent(songId, instrument),
          _userSongbookRepository.updateTotalSongs(songbookId: ListType.recents.localId),
        ]);
      }
      return result;
    });
  }
}
