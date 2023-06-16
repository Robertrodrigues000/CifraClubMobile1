import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ValidateSongbookName {
  final UserSongbookRepository _userSongbookRepository;

  ValidateSongbookName(this._userSongbookRepository);

  Future<SongbookNameValidation> call(String songbookName) async {
    final songbooks = await _userSongbookRepository.getAllUserSongbooks().first;
    final treatedName = songbookName.toLowerCase().trim();
    final haveSameName = songbooks.any(
      (element) => element.type == ListType.user && element.name.toLowerCase().trim() == treatedName,
    );

    if (haveSameName) {
      return SongbookNameValidation.existingName;
    }

    return SongbookNameValidation.validInput;
  }
}

enum SongbookNameValidation {
  existingName,
  validInput;
}
