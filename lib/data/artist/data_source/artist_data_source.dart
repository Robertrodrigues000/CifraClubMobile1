import 'package:async/async.dart' hide Result;
import 'package:cifraclub/data/artist/models/album_detail_dto.dart';
import 'package:cifraclub/data/artist/models/albums_dto.dart';
import 'package:cifraclub/data/artist/models/artist_info_dto.dart';
import 'package:cifraclub/data/artist/models/artist_songs_dto.dart';
import 'package:cifraclub/data/artist/models/top_artists_dto.dart';
import 'package:cifraclub/data/clients/http/network_request.dart';
import 'package:cifraclub/data/clients/http/network_service.dart';
import 'package:cifraclub/data/home/models/video_lessons/video_lessons_dto.dart';
import 'package:cifraclub/domain/artist/models/artist_song_filter.dart';
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

  Future<Result<ArtistInfoDto, RequestError>> getArtistInfo(String artistUrl) async {
    var request = NetworkRequest(
        type: NetworkRequestType.get,
        path: "/v3/artist/$artistUrl/info",
        parser: (data) => ArtistInfoDto.fromJson(data as Map<String, dynamic>));
    var artistInfo = await networkService.execute(request: request);
    return artistInfo;
  }

  Future<Result<ArtistSongsDto, RequestError>> getArtistSongs({
    required String artistUrl,
    required int limit,
    ArtistSongFilter? filter,
  }) {
    final Map<String, dynamic> queryParams = {'limit': limit};

    if (filter != null) {
      queryParams['filter'] = filter.name;
    }
    var request = NetworkRequest(
      type: NetworkRequestType.get,
      path: "/v3/artist/$artistUrl/songs?exclude=lyrics+files",
      queryParams: queryParams,
      parser: (data) => ArtistSongsDto.fromJson(data as Map<String, dynamic>),
    );
    return networkService.execute(request: request);
  }

  Future<Result<List<VideoLessonsDto>, RequestError>> getVideoLessons({required String artistUrl}) {
    var request = NetworkRequest(
      type: NetworkRequestType.get,
      path: "/v3/artist/$artistUrl/video-lessons",
      parser: (data) =>
          (data as List<dynamic>).map((e) => VideoLessonsDto.fromJson(e as Map<String, dynamic>)).toList(),
    );
    return networkService.execute(request: request);
  }

  Future<Result<AlbumsDto, RequestError>> getAlbums({required String artistUrl}) {
    var request = NetworkRequest(
      type: NetworkRequestType.get,
      path: "/v3/artist/$artistUrl/albums",
      parser: (data) => AlbumsDto.fromJson(data as Map<String, dynamic>),
    );
    return networkService.execute(request: request);
  }

  Future<Result<AlbumDetailDto, RequestError>> getAlbumDetail({required String artistUrl, required albumUrl}) {
    var request = NetworkRequest(
      type: NetworkRequestType.get,
      path: "/v3/album/$artistUrl/$albumUrl",
      parser: (data) => AlbumDetailDto.fromJson(data as Map<String, dynamic>),
    );
    return networkService.execute(request: request);
  }
}
