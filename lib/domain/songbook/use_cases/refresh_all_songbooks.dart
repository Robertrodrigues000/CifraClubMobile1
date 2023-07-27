import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:cifraclub/domain/log/repository/log_repository.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:cifraclub/domain/songbook/use_cases/update_songbook_preview.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class RefreshAllSongbooks {
  final SongbookRepository _songbookRepository;
  final UserSongbookRepository _userSongbookRepository;
  final UserVersionRepository _userVersionRepository;
  final UpdateSongbookPreview _updateSongbookPreview;

  const RefreshAllSongbooks(
    this._songbookRepository,
    this._userSongbookRepository,
    this._userVersionRepository,
    this._updateSongbookPreview,
  );

  Future<Result<List<Songbook>, RequestError>> call() {
    return _songbookRepository.getAllSongbooks().then(
          (result) => result.onSuccess((response) async {
            await _userVersionRepository.clearAllVersions();
            final songbooks = response.map((e) => e.songbook).toList();

            await _userSongbookRepository.setUserSongbooks(songbooks);

            for (var element in response) {
              final id = element.songbook.type == ListType.user ? element.songbook.id : element.songbook.type.localId;

              if (id != null) {
                switch (element.songbook.type) {
                  case ListType.user:
                    await _userVersionRepository.addVersionsToSongbook(element.versions, id);
                    await _updateSongbookPreview(id);
                    break;
                  case ListType.recents:
                    await _userVersionRepository.addVersionsToRecentSongbook(element.versions);
                    break;
                  default:
                    await _userVersionRepository.addVersionsToSongbook(element.versions, id);
                    break;
                }
              } else {
                // coverage:ignore-start
                logger?.sendNonFatalCrash(exception: Exception("User list with id null ${element.songbook.name}"));
                // coverage:ignore-end
              }
            }
          }).map((value) => value.map((e) => e.songbook).toList()),
        );
  }
}
