// coverage:ignore-file
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetVersionsStreamBySongbookId {
  final UserVersionRepository _userVersionRepository;

  GetVersionsStreamBySongbookId(this._userVersionRepository);

  Stream<List<Version>> call(int songbookId) {
    return _userVersionRepository.getVersionsStreamFromSongbook(songbookId);
  }
}
