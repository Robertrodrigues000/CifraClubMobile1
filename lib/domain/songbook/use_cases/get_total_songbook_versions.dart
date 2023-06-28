// coverage:ignore-file
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTotalSongbookVersions {
  final UserVersionRepository _userVersionRepository;

  GetTotalSongbookVersions(this._userVersionRepository);

  Stream<int?> call(int songbookId) {
    return _userVersionRepository.getTotalSongbookVersions(songbookId);
  }
}
