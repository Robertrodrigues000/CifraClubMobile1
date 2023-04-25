// coverage:ignore-file
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllUserSongbooks {
  final UserSongbookRepository _userSongbookRepository;

  GetAllUserSongbooks(this._userSongbookRepository);

  Stream<List<Songbook>> call() {
    return _userSongbookRepository.getAllUserSongbooks();
  }
}
