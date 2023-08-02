// coverage:ignore-file
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetIsFavoriteVersionBySongId {
  final UserVersionRepository _userVersionRepository;

  GetIsFavoriteVersionBySongId(this._userVersionRepository);

  Stream<bool> call(int songId) {
    return _userVersionRepository.getIsFavoriteVersionBySongIdStream(songId);
  }
}
