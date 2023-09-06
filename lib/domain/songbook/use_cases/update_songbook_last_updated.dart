// coverage:ignore-file
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateSongbookLastUpdated {
  final UserSongbookRepository _userSongbookRepository;

  UpdateSongbookLastUpdated(this._userSongbookRepository);

  Future<int?> call(int songbookId) async {
    final songbook = await _userSongbookRepository.getSongbookById(songbookId);
    if (songbook == null) {
      return null;
    }
    return _userSongbookRepository.putUserSongbook(songbook.copyWith(lastUpdated: DateTime.now()));
  }
}
