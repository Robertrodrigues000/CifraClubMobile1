import 'package:cifraclub/data/permission/repository/permission_repository_impl.dart';
import 'package:cifraclub/domain/permission/repository/permission_repository.dart';
import 'package:cifraclub/domain/song/models/local_song.dart';
import 'package:cifraclub/domain/song/repository/local_songs_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class GetLocalSongs {
  final LocalSongRepository _localSongRepository;
  final PermissionRepository _permissionRepository;

  const GetLocalSongs(this._localSongRepository, this._permissionRepository);

  Future<Result<List<LocalSong>, LocalSongError>> call({required String artistName, required songName}) async {
    final permission = await _permissionRepository.requestPermission(PermissionType.audio);

    if (permission.isGranted) {
      final localSongsResult = await _localSongRepository.getLocalSongs(artistName: artistName, songName: songName);

      if (localSongsResult.isFailure || localSongsResult.get() == null) {
        return Err(LocalSongFetchError(localSongsResult.getError() ?? "Songs list null"));
      }

      return Ok(localSongsResult.get()!);
    } else {
      return Err(LocalSongPermissionError(permission));
    }
  }
}

sealed class LocalSongError {}

class LocalSongPermissionError implements LocalSongError {
  final PermissionStatus permissionStatus;

  LocalSongPermissionError(this.permissionStatus);
}

class LocalSongFetchError implements LocalSongError {
  final String error;

  LocalSongFetchError(this.error);
}
