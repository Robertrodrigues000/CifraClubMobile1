// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  Future<Result<TopArtistsDto, RequestError>> getTopArtists({
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
      path: "/v3/top/artists",
      queryParams: queryParams,
      parser: (data) => TopArtistsDto.fromJson(data as Map<String, dynamic>),
    );
    return networkService.execute(request: request);
  }
}
