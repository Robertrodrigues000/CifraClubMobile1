import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/songbook/models/songbook_version_input.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_version_data_to_songbook.dart';
import 'package:cifraclub/domain/version/models/version_data.dart';
import 'package:cifraclub/domain/version/repository/version_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

abstract class InsertUserSongbookParams {
  final String name;
  final bool isPublic;
  final DateTime? createdAt;

  InsertUserSongbookParams({required this.name, this.createdAt, this.isPublic = true});
}

class InsertUserSongbookWithName extends InsertUserSongbookParams {
  InsertUserSongbookWithName({required super.name, super.createdAt, super.isPublic});
}

class InsertUserSongbookWithUrl extends InsertUserSongbookParams {
  final String artistUrl;
  final String songUrl;

  InsertUserSongbookWithUrl({
    required super.name,
    required this.songUrl,
    required this.artistUrl,
    super.createdAt,
    super.isPublic,
  });
}

class InsertUserSongbookWithVersionData extends InsertUserSongbookParams {
  final VersionData versionData;

  InsertUserSongbookWithVersionData({
    required super.name,
    required this.versionData,
    super.createdAt,
    super.isPublic,
  });
}

@injectable
class InsertUserSongbook {
  final SongbookRepository _songbookRepository;
  final UserSongbookRepository _userSongbookRepository;
  final VersionRepository _versionRepository;
  final InsertVersionDataToSongbook _insertVersionDataToSongbook;

  const InsertUserSongbook(
    this._songbookRepository,
    this._userSongbookRepository,
    this._versionRepository,
    this._insertVersionDataToSongbook,
  );

  Future<Result<Songbook, RequestError>> call({
    required InsertUserSongbookParams params,
  }) async {
    VersionData? versionData;
    SongbookVersionInput? versionInput;

    switch (params) {
      case InsertUserSongbookWithUrl():
        {
          final versionDataResult = await _versionRepository.getVersionData(
            artistUrl: params.artistUrl,
            songUrl: params.songUrl,
          );

          if (versionDataResult.isFailure) {
            return Err(versionDataResult.getError()!);
          }

          versionData = versionDataResult.get()!;

          versionInput = SongbookVersionInput(
            versionId: versionData.versionId,
            type: versionData.instrument.apiType,
          );
        }
      case InsertUserSongbookWithVersionData():
        {
          versionData = params.versionData;

          versionInput = SongbookVersionInput(
            versionId: versionData.versionId,
            type: versionData.instrument.apiType,
          );
        }
    }

    final addSongbookResult = await _songbookRepository.addSongbook(
      name: params.name,
      isPublic: params.isPublic,
      createdAt: params.createdAt ?? DateTime.now(),
      versionInput: versionInput,
    );

    if (addSongbookResult.isFailure) {
      return Err(addSongbookResult.getError()!);
    }

    final songbookVersion = addSongbookResult.get()!;

    await Future.wait([
      _userSongbookRepository.putUserSongbook(songbookVersion.songbook),
      if (versionData != null && songbookVersion.version != null)
        _insertVersionDataToSongbook(
          songbookId: songbookVersion.songbook.id!,
          versionData: versionData,
          addedVersion: songbookVersion.version,
        ),
    ]);

    return Ok(songbookVersion.songbook);
  }
}
