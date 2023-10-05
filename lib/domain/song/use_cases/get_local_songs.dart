import 'package:cifraclub/data/permission/models/app_permission_status.dart';
import 'package:cifraclub/data/permission/repository/permission_repository_impl.dart';
import 'package:cifraclub/domain/permission/repository/permission_repository.dart';
import 'package:cifraclub/domain/song/models/local_song.dart';
import 'package:cifraclub/domain/song/models/song_search_error.dart';
import 'package:cifraclub/domain/song/repository/local_songs_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class GetLocalSongs {
  final LocalSongRepository _localSongRepository;
  final PermissionRepository _permissionRepository;

  const GetLocalSongs(this._localSongRepository, this._permissionRepository);

  Future<Result<List<LocalSong>, SongSearchError>> call({required String artistName, required songName}) async {
    final permission = await _permissionRepository.requestPermission(PermissionType.audio);

    if (permission == AppPermissionStatus.granted) {
      final localSongsResult = await _localSongRepository.getLocalSongs(artistName: artistName, songName: songName);

      if (localSongsResult.isFailure || localSongsResult.get() == null) {
        return Err(SongFetchError(localSongsResult.getError() ?? "Songs list null"));
      }

      return Ok(localSongsResult.get()!);
    } else {
      return Err(SongPermissionError(permission));
    }
  }
}
