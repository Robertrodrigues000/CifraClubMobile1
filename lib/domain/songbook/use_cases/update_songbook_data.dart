import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class UpdateSongbookData {
  final SongbookRepository _songbookRepository;
  final UserSongbookRepository _userSongbookRepository;

  const UpdateSongbookData(this._songbookRepository, this._userSongbookRepository);

  Future<Result<void, RequestError>> call({
    required Songbook songbook,
    String? name,
    bool? isPublic,
  }) async {
    if (songbook.id == null) {
      throw Exception("Songbook should have an id set");
    }

    if (name == null && isPublic == null) {
      return const Ok(null);
    }

    final dateTime = DateTime.now();

    final updateSongbookData = _songbookRepository.updateSongbookData(
      songbookId: songbook.id!,
      name: name,
      isPublic: isPublic ?? songbook.isPublic,
      lastUpdated: dateTime,
    );

    return updateSongbookData.then((result) {
      if (result.isSuccess) {
        _userSongbookRepository.putUserSongbook(
          songbook.copyWith(
            name: name ?? songbook.name,
            isPublic: isPublic ?? songbook.isPublic,
            lastUpdated: dateTime,
          ),
        );
      }

      return result;
    });
  }
}
