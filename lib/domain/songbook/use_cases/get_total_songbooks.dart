// coverage:ignore-file
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTotalSongbooks {
  final UserSongbookRepository _userSongbookRepository;

  GetTotalSongbooks(this._userSongbookRepository);

  Stream<int> call() {
    return _userSongbookRepository.getTotalSongbooks();
  }
}
