import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class RefreshAllSongbooks {
  final SongbookRepository _songbookRepository;
  final UserSongbookRepository _userSongbookRepository;

  RefreshAllSongbooks(this._songbookRepository, this._userSongbookRepository);

  Future<Result<List<Songbook>, RequestError>> call() {
    return _songbookRepository
        .getAllSongbooks()
        .then((result) => result.onSuccess(_userSongbookRepository.setUserSongbooks));
  }
}
