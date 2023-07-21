import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:injectable/injectable.dart';

@singleton
@injectable
class ClearUserSongbooksOnLogout {
  final UserSongbookRepository _userSongbookRepository;
  final UserVersionRepository _userVersionRepository;
  final GetCredentialStream _getCredentialStream;
  ClearUserSongbooksOnLogout(
    this._userSongbookRepository,
    this._userVersionRepository,
    this._getCredentialStream,
  );

  Future<void> call() async {
    _getCredentialStream().skip(1).listen((userCredential) async {
      if (!userCredential.isUserLoggedIn) {
        await _userSongbookRepository.deleteAll();
        await _userVersionRepository.clearAllVersions();
      }
    });
  }
}
