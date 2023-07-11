// coverage:ignore-file
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSongbookStreamById {
  final UserSongbookRepository _userSongbookRepository;

  GetSongbookStreamById(this._userSongbookRepository);

  Stream<Songbook?> call(int? songbookId) {
    return _userSongbookRepository.getSongbookStreamById(songbookId);
  }
}
