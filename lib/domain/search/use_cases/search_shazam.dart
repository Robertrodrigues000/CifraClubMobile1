import 'package:cifraclub/data/permission/models/app_permission_status.dart';
import 'package:cifraclub/data/permission/repository/permission_repository_impl.dart';
import 'package:cifraclub/domain/permission/repository/permission_repository.dart';
import 'package:cifraclub/domain/remote_config/repository/remote_config_repository.dart';
import 'package:cifraclub/domain/search/models/shazam_item.dart';
import 'package:cifraclub/domain/search/repository/shazam_repository.dart';
import 'package:cifraclub/domain/song/models/song_search_error.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class SearchShazam {
  final ShazamRepository _shazamRepository;
  final PermissionRepository _permissionRepository;
  final RemoteConfigRepository _remoteConfigRepository;

  const SearchShazam(this._shazamRepository, this._permissionRepository, this._remoteConfigRepository);

  Future<Result<ShazamItem, SongSearchError>> call() async {
    final permission = await _permissionRepository.requestPermission(PermissionType.microphone);

    if (permission == AppPermissionStatus.granted) {
      final token = _remoteConfigRepository.getShazamToken();
      final shazamResult = await _shazamRepository.searchAudio(token);

      if (shazamResult.isFailure || shazamResult.get() == null) {
        return Err(SongFetchError(shazamResult.getError() ?? "Shazam item null"));
      }

      return Ok(shazamResult.get()!);
    } else {
      return Err(SongPermissionError(permission));
    }
  }
}
