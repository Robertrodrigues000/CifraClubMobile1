import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/songbook_version_input.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:cifraclub/domain/songbook/use_cases/update_songbook_preview.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:cifraclub/domain/version/models/version_data.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class InsertVersionDataToSongbook {
  final SongbookRepository _songbookRepository;
  final UserSongbookRepository _userSongbookRepository;
  final UserVersionRepository _userVersionRepository;
  final UpdateSongbookPreview _updateSongbookPreview;

  const InsertVersionDataToSongbook(
    this._songbookRepository,
    this._userSongbookRepository,
    this._userVersionRepository,
    this._updateSongbookPreview,
  );

  Future<Result<int, RequestError>> call({
    required VersionData versionData,
    required int songbookId,
    int? versionLocalDatabaseId,
    Version? addedVersion,
  }) async {
    Result<Version?, RequestError>? addResult;

    if (addedVersion == null) {
      final versionInput = SongbookVersionInput(
        versionId: versionData.versionId,
        type: versionData.instrument.apiType,
      );

      addResult = await _songbookRepository.addVersionToSongbook(songbookId: songbookId, versionInput: versionInput);

      if (addResult.isFailure) {
        return Err(addResult.getError()!);
      }
    }

    Version version =
        addedVersion ?? addResult?.get() ?? Version.fromVersionData(versionData, lastUpdate: DateTime.now());

    if (versionLocalDatabaseId != null) {
      version = version.copyWith(localDatabaseId: versionLocalDatabaseId);
    }

    await _userVersionRepository.putVersionsToSongbook([version], songbookId).then((value) {
      _userVersionRepository.addVersionData(
        versionData: versionData,
        versionLocalDatabaseId: value.first,
        songbookId: songbookId,
      );
    });

    await Future.wait([
      _userSongbookRepository.updateTotalSongs(songbookId: songbookId),
      _updateSongbookPreview(songbookId),
    ]);

    return Ok(version.songId);
  }
}
