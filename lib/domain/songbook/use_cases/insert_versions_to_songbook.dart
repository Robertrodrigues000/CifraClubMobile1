import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/models/songbook_version_input.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class InsertVersionsToSongbook {
  final SongbookRepository _songbookRepository;
  final UserVersionRepository _userVersionRepository;
  final UserSongbookRepository _userSongbookRepository;

  const InsertVersionsToSongbook(this._songbookRepository, this._userVersionRepository, this._userSongbookRepository);

  Future<Result<List<Version>, RequestError>> call({required int songbookId, required List<Version> versions}) async {
    return (await _songbookRepository.addVersionsToSongbook(
      songbookId: songbookId,
      versionsInput: versions.map(SongbookVersionInput.fromVersion).toList(),
    ))
        .onSuccess((value) async {
      await _userVersionRepository.deleteVersionsBySongbookId(songbookId);
      await _userVersionRepository.putVersionsToSongbook(value, songbookId);
      await _userSongbookRepository.updateTotalSongs(songbookId: songbookId);
    });
  }
}
