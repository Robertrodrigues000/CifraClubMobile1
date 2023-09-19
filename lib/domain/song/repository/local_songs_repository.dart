import 'dart:typed_data';

import 'package:cifraclub/domain/song/models/local_song.dart';
import 'package:typed_result/typed_result.dart';

abstract class LocalSongRepository {
  Future<Result<List<LocalSong>?, String>> getLocalSongs({required String artistName, required String songName});
  Future<Uint8List?> getImage(String uri);
}
