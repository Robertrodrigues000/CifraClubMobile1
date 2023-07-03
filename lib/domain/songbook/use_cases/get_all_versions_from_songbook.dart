import 'package:cifraclub/domain/version/models/version.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllVersionsFromSongbook {
  final UserVersionRepository _userVersionRepository;

  GetAllVersionsFromSongbook(this._userVersionRepository);

  Future<List<Version>> call(int songbookId) {
    return _userVersionRepository.getUserVersionsFromSongbook(songbookId);
  }
}
