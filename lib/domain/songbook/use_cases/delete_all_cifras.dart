import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class DeleteAllCifras {
  final SongbookRepository _songbookRepository;
  final UserSongbookRepository _userSongbookRepository;

  DeleteAllCifras(this._songbookRepository, this._userSongbookRepository);

  Future<Result<void, RequestError>> call(int songbookId) async {
    final cifrasIdList = await _userSongbookRepository.getCifrasIds(songbookId);

    if (cifrasIdList == null) {
      throw Exception("Songbook with null cifras ids");
    }

    final apiResult = await _songbookRepository.deleteCifras(songbookId: songbookId, cifrasIds: cifrasIdList);

    return apiResult.onSuccess((_) {
      _userSongbookRepository.deleteCifras(songbookId);
    });
  }
}
