import 'package:async/async.dart' hide Result;
import 'package:cifraclub/domain/artist/models/album.dart';
import 'package:cifraclub/domain/artist/models/album_detail.dart';
import 'package:cifraclub/domain/artist/models/artist_info.dart';
import 'package:cifraclub/domain/artist/models/artist_song.dart';
import 'package:cifraclub/domain/artist/models/artist_song_filter.dart';
import 'package:cifraclub/domain/home/models/video_lesson.dart';
import 'package:typed_result/typed_result.dart';

import 'package:cifraclub/data/artist/data_source/artist_data_source.dart';
import 'package:cifraclub/domain/artist/models/artist.dart';
import 'package:cifraclub/domain/artist/repository/artist_repository.dart';
import 'package:cifraclub/domain/shared/paginated_list.dart';
import 'package:cifraclub/domain/shared/request_error.dart';

class ArtistRepositoryImpl extends ArtistRepository {
  ArtistDataSource artistDataSource;

  ArtistRepositoryImpl({
    required this.artistDataSource,
  });

  @override
  CancelableOperation<Result<PaginatedList<Artist>, RequestError>> getTopArtists(
      {String? genreUrl, required int limit, required int offset}) {
    return artistDataSource
        .getTopArtists(genreUrl: genreUrl, limit: limit, offset: offset)
        .then((result) => result.map((topArtistsDto) => topArtistsDto.toDomain()));
  }

  @override
  Future<Result<ArtistInfo, RequestError>> getArtistInfo({required String artistUrl}) async =>
      (await artistDataSource.getArtistInfo(artistUrl)).map(
        (artistInfoDto) => artistInfoDto.toDomain(),
      );

  @override
  Future<Result<List<ArtistSong>, RequestError>> getArtistSongs(
      {required String artistUrl, required int limit, ArtistSongFilter? filter}) async {
    return (await artistDataSource.getArtistSongs(artistUrl: artistUrl, limit: limit, filter: filter))
        .map((artistSongDto) => artistSongDto.toDomain().toList());
  }

  @override
  Future<Result<List<VideoLesson>, RequestError>> getArtistVideoLessons(String artistUrl) async {
    return (await artistDataSource.getVideoLessons(artistUrl: artistUrl))
        .map((value) => value.map((e) => e.toDomain()).toList());
  }

  @override
  Future<Result<List<Album>, RequestError>> getAlbums({required String artistUrl}) async =>
      (await artistDataSource.getAlbums(artistUrl: artistUrl)).map((value) => value.toDomain());

  @override
  Future<Result<AlbumDetail, RequestError>> getAlbumDetail(
          {required String artistUrl, required String albumUrl}) async =>
      (await artistDataSource.getAlbumDetail(
        artistUrl: artistUrl,
        albumUrl: albumUrl,
      ))
          .map((value) => value.toDomain());
}
