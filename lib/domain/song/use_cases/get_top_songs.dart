// coverage:ignore-file
import 'package:cifraclub/domain/shared/paginated_list.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/song/models/song.dart';
import 'package:cifraclub/domain/song/repository/song_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class GetTopSongs {
  final SongRepository songRepository;

  GetTopSongs({required this.songRepository});

  Future<Result<PaginatedList<Song>, RequestError>> call({String? genreUrl, int limit = 100, int offset = 0}) {
    return songRepository.getTopSongs(genreUrl: genreUrl, limit: limit, offset: offset);
  }
}
