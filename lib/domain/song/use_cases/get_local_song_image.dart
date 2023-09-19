// coverage:ignore-file
import 'dart:typed_data';

import 'package:cifraclub/domain/song/repository/local_songs_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetLocalSongImage {
  final LocalSongRepository _localSongRepository;

  const GetLocalSongImage(this._localSongRepository);

  Future<Uint8List?> call(String uri) {
    return _localSongRepository.getImage(uri);
  }
}
