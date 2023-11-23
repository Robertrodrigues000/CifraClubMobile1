import 'package:async/async.dart' hide Result;
import 'package:cifraclub/data/clients/http/network_request.dart';
import 'package:cifraclub/data/clients/http/network_service.dart';
import 'package:cifraclub/data/song/models/send_email_to_blocked_song_dto.dart';
import 'package:cifraclub/data/song/models/top_songs_dto.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:typed_result/typed_result.dart';

class SongDataSource {
  final NetworkService _networkService;

  SongDataSource(this._networkService);

  CancelableOperation<Result<TopSongsDto, RequestError>> getTopSongs({
    String? genreUrl,
    required int limit,
    required int offset,
  }) {
    final Map<String, dynamic> queryParams = {'limit': limit};
    if (genreUrl != null) {
      queryParams['genre'] = genreUrl;
    }
    if (offset > 0) {
      queryParams['offset'] = offset;
    }

    var request = NetworkRequest(
      type: NetworkRequestType.get,
      path: "/v3/top/songs",
      queryParams: queryParams,
      parser: (data) => TopSongsDto.fromJson(data as Map<String, dynamic>),
    );
    return _networkService.cancelableExecute(request: request);
  }

  Future<Result<void, RequestError>> sendEmail(SendEmailToBlockedSongDto sendEmailToBlockedSongDto) {
    var request = NetworkRequest(
      type: NetworkRequestType.post,
      path: "/v3/song/blocked/signup",
      data: sendEmailToBlockedSongDto.toJson(),
      parser: (_) => null, // coverage:ignore-line
    );
    return _networkService.execute(request: request);
  }
}
