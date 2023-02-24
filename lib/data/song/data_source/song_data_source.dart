import 'package:cifraclub/data/clients/http/network_request.dart';
import 'package:cifraclub/data/clients/http/network_service.dart';
import 'package:cifraclub/data/song/models/top_songs_dto.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:typed_result/typed_result.dart';

class SongDataSource {
  NetworkService networkService;

  SongDataSource({
    required this.networkService,
  });

  Future<Result<TopSongsDto, RequestError>> getTopSongs({
    String? genreUrl,
    required int limit,
    required int offset,
  }) async {
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
    return networkService.execute(request: request);
  }
}
