import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/use_cases/update_songbook_preview.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class ClearSongsFromSongbook {
  final SongbookRepository _songbookRepository;
  final UserVersionRepository _userVersionRepository;
  final UpdateSongbookPreview _updateSongbookPreview;

  ClearSongsFromSongbook(this._songbookRepository, this._userVersionRepository, this._updateSongbookPreview);

  Future<Result<void, RequestError>> call(int songbookId) async {
    final cifrasIdList = (await _userVersionRepository.getUserVersionsFromSongbook(songbookId))
        .map((e) => e.remoteDatabaseID ?? -1)
        .toList();
    final apiResult = await _songbookRepository.deleteVersions(songbookId: songbookId, versionsId: cifrasIdList);
    return apiResult.onSuccess((_) async {
      await _userVersionRepository.deleteVersionsBySongbookId(songbookId);
      await _updateSongbookPreview(songbookId);
    });
  }
}
