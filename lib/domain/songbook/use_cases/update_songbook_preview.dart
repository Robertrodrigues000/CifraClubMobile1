import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateSongbookPreview {
  final UserVersionRepository _userVersionRepository;
  final UserSongbookRepository _userSongbookRepository;

  UpdateSongbookPreview(this._userVersionRepository, this._userSongbookRepository);

  Future<int?> call(int songbookId) async {
    final images = await _userVersionRepository.getImagesPreview(songbookId);
    return _userSongbookRepository.updateSongbookPreview(songbookId, images);
  }
}
