// coverage:ignore-file
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTotalSongbookCifras {
  final UserSongbookRepository _userSongbookRepository;

  GetTotalSongbookCifras(this._userSongbookRepository);

  Stream<int?> call(int songbookId) {
    return _userSongbookRepository.getTotalSongbookCifras(songbookId);
  }
}
