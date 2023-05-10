import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ValidateSongbookName {
  final UserSongbookRepository _userSongbookRepository;

  ValidateSongbookName(this._userSongbookRepository);

  Future<SongbookNameValidation> call(String songbookName) async {
    if (songbookName.isEmpty || songbookName.trim().isEmpty) {
      return SongbookNameValidation.invalidInput;
    }

    final songbooks = await _userSongbookRepository.getAllUserSongbooks().first;
    final haveSameName = songbooks.any((element) => element.type == ListType.user && element.name == songbookName);
    if (haveSameName) {
      return SongbookNameValidation.existingName;
    }

    return SongbookNameValidation.validInput;
  }
}

enum SongbookNameValidation {
  invalidInput,
  existingName,
  validInput;
}
