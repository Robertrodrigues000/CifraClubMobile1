import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class InsertUserSongbook {
  final SongbookRepository _songbookRepository;
  final UserSongbookRepository _userSongbookRepository;

  InsertUserSongbook(this._songbookRepository, this._userSongbookRepository);

  Future<Result<Songbook, RequestError>> call({
    required String name,
    bool isPublic = true,
    DateTime? createdAt,
  }) async {
    return _songbookRepository
        .addSongbook(
          name: name,
          isPublic: isPublic,
          createdAt: createdAt ?? DateTime.now(),
        )
        .then((result) => result.onSuccess(_userSongbookRepository.insertUserSongbook));
  }
}
