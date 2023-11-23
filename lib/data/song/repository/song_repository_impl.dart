import 'package:async/async.dart' hide Result;
import 'package:cifraclub/data/song/data_source/song_data_source.dart';
import 'package:cifraclub/data/song/models/send_email_to_blocked_song_dto.dart';
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
  CancelableOperation<Result<PaginatedList<Song>, RequestError>> getTopSongs({
    String? genreUrl,
    required int limit,
    required int offset,
  }) {
    return songDataSource
        .getTopSongs(genreUrl: genreUrl, limit: limit, offset: offset)
        .then((result) => result.map((topSongsDto) => topSongsDto.toDomain()));
  }

  @override
  Future<Result<void, RequestError>> sendEmail(String email, String url) {
    return songDataSource.sendEmail(SendEmailToBlockedSongDto(email: email, url: url));
  }
}
