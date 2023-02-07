// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cifraclub/data/song/data_source/song_data_source.dart';
import 'package:cifraclub/domain/song/models/song.dart';
import 'package:cifraclub/domain/song/repository/song_repository.dart';
import 'package:typed_result/typed_result.dart';
import 'package:cifraclub/domain/shared/paginated_list.dart';
import 'package:cifraclub/domain/shared/request_error.dart';

class SongRepositoryImpl extends SongRepository {
  SongDataSource songDataSource;

  SongRepositoryImpl({
    required this.songDataSource,
  });

  @override
  Future<Result<PaginatedList<Song>, RequestError>> getTopSongs({
    String? genreUrl,
    required int limit,
    required int offset,
  }) async {
    return (await songDataSource.getTopSongs(
      genreUrl: genreUrl,
      limit: limit,
      offset: offset,
    ))
        .map(
      (value) => value.toDomain(),
    );
  }
}
