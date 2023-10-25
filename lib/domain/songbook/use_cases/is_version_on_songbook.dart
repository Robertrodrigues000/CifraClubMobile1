import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class IsVersionOnSongbook {
  final UserVersionRepository _userVersionRepository;

  IsVersionOnSongbook(this._userVersionRepository);

  Future<bool> call(int versionId, int songbookId) async {
    return _userVersionRepository.getIsVersionOnSongbook(songbookId, versionId);
  }
}
