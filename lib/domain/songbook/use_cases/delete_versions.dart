import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class DeleteVersions {
  final SongbookRepository _songbookRepository;
  final UserVersionRepository _userVersionRepository;

  DeleteVersions(this._songbookRepository, this._userVersionRepository);

  Future<Result<void, RequestError>> call({required int songbookId, required List<Version> versions}) async {
    final songsRemoteIds = versions.map((e) => e.remoteDatabaseID ?? -1).toList();

    return (await _songbookRepository.deleteVersions(songbookId: songbookId, versionsId: songsRemoteIds)).onSuccess(
      (value) async {
        final songsLocalId = versions.map((e) => e.localDatabaseID ?? -1).toList();
        await _userVersionRepository.deleteVersionsById(songsLocalId);
      },
    );
  }
}
