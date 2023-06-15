import 'package:cifraclub/domain/cifra/repository/user_cifra_repository.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateSongbookPreview {
  final UserCifraRepository _userCifraRepository;
  final UserSongbookRepository _userSongbookRepository;

  UpdateSongbookPreview(this._userCifraRepository, this._userSongbookRepository);

  Future<int?> call(int songbookId) async {
    final images = await _userCifraRepository.getImagesPreview(songbookId);
    return _userSongbookRepository.updateSongbookPreview(songbookId, images);
  }
}
