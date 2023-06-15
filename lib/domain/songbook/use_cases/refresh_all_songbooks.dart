import 'package:cifraclub/domain/cifra/repository/user_cifra_repository.dart';
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
  final UserCifraRepository _userCifraRepository;
  final UpdateSongbookPreview _updateSongbookPreview;

  RefreshAllSongbooks(
    this._songbookRepository,
    this._userSongbookRepository,
    this._userCifraRepository,
    this._updateSongbookPreview,
  );

  Future<Result<List<Songbook>, RequestError>> call() {
    return _songbookRepository.getAllSongbooks().then(
          (result) => result.onSuccess((response) async {
            await _userCifraRepository.clearAllCifras();
            final songbooks = response.map((e) => e.songbook).toList();

            await _userSongbookRepository.setUserSongbooks(songbooks);

            for (var element in response) {
              final id = element.songbook.type == ListType.user ? element.songbook.id : element.songbook.type.localId;
              if (id != null) {
                await _userCifraRepository.addCifrasToSongbook(element.cifras, id);
                if (element.songbook.type == ListType.user) {
                  await _updateSongbookPreview(id);
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
