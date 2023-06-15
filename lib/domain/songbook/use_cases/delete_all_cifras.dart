import 'package:cifraclub/domain/cifra/repository/user_cifra_repository.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/use_cases/update_songbook_preview.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class DeleteAllCifras {
  final SongbookRepository _songbookRepository;
  final UserCifraRepository _userCifraRepository;
  final UpdateSongbookPreview _updateSongbookPreview;

  DeleteAllCifras(this._songbookRepository, this._userCifraRepository, this._updateSongbookPreview);

  Future<Result<void, RequestError>> call(int songbookId) async {
    final cifrasIdList = (await _userCifraRepository.getUserCifrasFromSongbook(songbookId))
        .map((e) => e.remoteDatabaseID ?? -1)
        .toList();

    final apiResult = await _songbookRepository.deleteCifras(songbookId: songbookId, cifrasIds: cifrasIdList);

    return apiResult.onSuccess((_) async {
      await _userCifraRepository.deleteCifrasBySongbookId(songbookId);
      await _updateSongbookPreview(songbookId);
    });
  }
}
