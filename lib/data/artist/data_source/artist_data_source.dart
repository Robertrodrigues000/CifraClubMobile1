import 'package:async/async.dart' hide Result;
import 'package:cifraclub/data/artist/models/top_artists_dto.dart';
import 'package:cifraclub/data/clients/http/network_request.dart';
import 'package:cifraclub/data/clients/http/network_service.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:typed_result/typed_result.dart';

class ArtistDataSource {
  NetworkService networkService;

  ArtistDataSource({
    required this.networkService,
  });

  CancelableOperation<Result<TopArtistsDto, RequestError>> getTopArtists({
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
      path: "/v3/top/artists",
      queryParams: queryParams,
      parser: (data) => TopArtistsDto.fromJson(data as Map<String, dynamic>),
    );
    return networkService.cancelableExecute(request: request);
  }
}
