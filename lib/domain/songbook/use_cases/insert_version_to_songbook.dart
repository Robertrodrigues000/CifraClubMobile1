import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/models/songbook_version_input.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:cifraclub/domain/version/use_cases/get_version_data.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class InsertVersionToSongbook {
  final SongbookRepository _songbookRepository;
  final UserSongbookRepository _userSongbookRepository;
  final UserVersionRepository _userVersionRepository;
  final GetVersionData _getVersionData;

  InsertVersionToSongbook(
      this._songbookRepository, this._userVersionRepository, this._getVersionData, this._userSongbookRepository);

  Future<Result<int, RequestError>> call({
    required int songbookId,
    required String artistUrl,
    required String songUrl,
  }) async {
    if (songbookId == ListType.recents.localId) {
      throw Exception("Songbook cannot be recent songbook, songbookId: $songbookId");
    }

    final versionData = await _getVersionData(
      artistDns: artistUrl,
      songDns: songUrl,
    );

    if (versionData.isFailure) {
      return Err(versionData.getError()!);
    }

    final versionInput = SongbookVersionInput(
      versionId: versionData.get()!.versionId,
      type: versionData.get()!.instrument.apiType,
    );

    final addResult = await _songbookRepository.addVersionToSongbook(
      songbookId: songbookId,
      versionInput: versionInput,
    );

    if (addResult.isSuccess) {
      final version = addResult.get()!;

      await Future.wait([
        _userVersionRepository.addVersionsToSongbook([version], songbookId),
        _userSongbookRepository.incrementTotalSongs(songbookId: songbookId),
        _userVersionRepository.addVersionData(versionData.get()!, version.remoteDatabaseId!),
      ]);

      return Ok(version.songId);
    } else {
      return Err(addResult.getError()!);
    }
  }
}
