import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateSongbookPreview {
  final UserVersionRepository _userVersionRepository;
  final UserSongbookRepository _userSongbookRepository;

  UpdateSongbookPreview(this._userVersionRepository, this._userSongbookRepository);

  Future<void> call(int songbookId) async {
    if (ListType.getListTypeById(songbookId) != ListType.user) {
      return;
    }
    final images = await _userVersionRepository.getImagesPreview(songbookId);
    await _userSongbookRepository.updateSongbookPreview(songbookId, images);
  }
}
