import 'dart:typed_data';

import 'package:cifraclub/domain/song/models/local_song.dart';
import 'package:cifraclub/domain/song/repository/local_songs_repository.dart';
import 'package:local_songs/pigeon.g.dart';
import 'package:typed_result/typed_result.dart';

class LocalSongRepositoryImpl extends LocalSongRepository {
  final LocalSongsHostApi localSongsHostApi;

  LocalSongRepositoryImpl(this.localSongsHostApi);

  @override
  Future<Result<List<LocalSong>?, String>> getLocalSongs({required String artistName, required String songName}) async {
    return localSongsHostApi.fetchLocalSongs(artistName, songName).then((value) {
      if (value.error != null) {
        return Err(value.error!);
      }

      return Ok(value.songs
          ?.whereType<LocalSongDto>()
          .map((e) => LocalSong(
                songName: e.songName,
                artistName: e.artistName,
                path: e.path,
                completePath: e.completePath,
                duration: e.duration,
                albumId: e.albumId,
              ))
          .toList());
    });
  }

  @override
  Future<Uint8List?> getImage(String uri) {
    return localSongsHostApi.getImage(uri);
  }
}
