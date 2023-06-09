import 'package:async/async.dart' hide Result;
import 'package:cifraclub/data/artist/data_source/artist_data_source.dart';
import 'package:cifraclub/data/artist/models/artist_dto.dart';
import 'package:cifraclub/data/artist/models/artist_image_dto.dart';
import 'package:cifraclub/data/artist/models/artist_info_dto.dart';
import 'package:cifraclub/data/artist/models/artist_song_dto.dart';
import 'package:cifraclub/data/artist/models/artist_songs_dto.dart';
import 'package:cifraclub/data/artist/models/top_artists_dto.dart';
import 'package:cifraclub/data/artist/repository/artist_repository_impl.dart';
import 'package:cifraclub/data/genre/models/genre_dto.dart';
import 'package:cifraclub/data/home/models/video_lessons/video_lessons_dto.dart';
import 'package:cifraclub/domain/artist/models/artist.dart';
import 'package:cifraclub/domain/artist/models/artist_image.dart';
import 'package:cifraclub/domain/artist/models/artist_info.dart';
import 'package:cifraclub/domain/artist/models/artist_song.dart';
import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/home/models/video_lessons_mock.dart';

class _ArtistDataSourceMock extends Mock implements ArtistDataSource {}

class _VideoLessonsDtoMock extends Mock implements VideoLessonsDto {}

void main() {
  group("When getTopArtists() is Called", () {
    test("Request successful", () async {
      var artistDataSource = _ArtistDataSourceMock();

      var topArtistsDto = const TopArtistsDto(moreResults: true, artists: [
        ArtistDto(
          url: "ze-ramalho",
          genre: GenreDto(
            name: "Rock",
            url: "rock",
          ),
          image: ArtistImageDto(
            color: "blue",
            size162: "size162",
            size250: "size250",
            size50: "size50",
          ),
          name: "Zé Ramalho",
          id: 7507,
        ),
      ]);

      when(() => artistDataSource.getTopArtists(limit: any(named: "limit"), offset: any(named: "offset"))).thenAnswer(
        (_) => CancelableOperation.fromFuture(
          SynchronousFuture(
            Ok(topArtistsDto),
          ),
        ),
      );

      final repository = ArtistRepositoryImpl(artistDataSource: artistDataSource);
      final topArtists = await repository.getTopArtists(limit: 3, offset: 0).value;

      expect(topArtists.isSuccess, true);
      expect(topArtists.get()!.items.length, 1);
      expect(topArtists.get()!.hasMoreResults, true);
      expect(
        topArtists.get()!.items.first,
        const Artist(
          url: "ze-ramalho",
          genre: Genre(
            name: "Rock",
            url: "rock",
          ),
          image: ArtistImage(
            color: "blue",
            size162: "size162",
            size250: "size250",
            size50: "size50",
          ),
          name: "Zé Ramalho",
          id: 7507,
        ),
      );
    });

    test("Request failed", () async {
      final artistDataSource = _ArtistDataSourceMock();

      when(() => artistDataSource.getTopArtists(limit: 3, offset: 0)).thenAnswer(
        (_) => CancelableOperation.fromFuture(
          SynchronousFuture(
            Err(ServerError()),
          ),
        ),
      );

      final repository = ArtistRepositoryImpl(artistDataSource: artistDataSource);
      final topArtists = await repository.getTopArtists(limit: 3, offset: 0).value;

      expect(topArtists.isFailure, true);
      expect(topArtists.getError().runtimeType, ServerError);
      expect((topArtists.getError() as ServerError).statusCode, null);
    });
  });

  group("When getArtistInfo() is Called", () {
    test("Request successful", () async {
      var artistDataSource = _ArtistDataSourceMock();

      var artistInfoDto = const ArtistInfoDto(
        id: 1,
        name: "Legiao Urbana",
        url: "legiao-urbana",
        hitsCount: 123,
        genre: GenreDto(
          name: "Rock",
          url: "rock",
        ),
      );

      when(() => artistDataSource.getArtistInfo(any())).thenAnswer((_) => SynchronousFuture(
            Ok(artistInfoDto),
          ));
      final repository = ArtistRepositoryImpl(artistDataSource: artistDataSource);
      final artistInfo = await repository.getArtistInfo(artistUrl: "legiao-urbana");

      expect(artistInfo.isSuccess, true);
      expect(
        artistInfo.get(),
        const ArtistInfo(
          id: 1,
          name: "Legiao Urbana",
          url: "legiao-urbana",
          hitsCount: 123,
          genre: Genre(
            name: "Rock",
            url: "rock",
          ),
        ),
      );
    });
    test("Request failed", () async {
      final artistDataSource = _ArtistDataSourceMock();

      when(() => artistDataSource.getArtistInfo(any())).thenAnswer(
        (_) => SynchronousFuture(Err(ServerError())),
      );

      final repository = ArtistRepositoryImpl(artistDataSource: artistDataSource);
      final artistInfo = await repository.getArtistInfo(artistUrl: "legiao-urbana");

      expect(artistInfo.isFailure, true);
      expect(artistInfo.getError().runtimeType, ServerError);
      expect((artistInfo.getError() as ServerError).statusCode, null);
    });
  });
  group("When getArtistSongs() is Called", () {
    const artistUrl = "legiao-urbana";
    test("Request successful", () async {
      var artistDataSource = _ArtistDataSourceMock();

      var artistsSongsDto = const ArtistSongsDto(songs: [
        ArtistSongDto(
          bass: 0,
          drums: 1,
          guitar: 4,
          guitarpro: 0,
          harmonica: 0,
          hits: 40,
          id: 2142,
          lyrics: 0,
          lyricsId: 454,
          name: "Me Atraiu",
          sheet: 1,
          url: "me-atraiu",
          verified: true,
          videoLessons: 1,
          videoLessonsInstruments: [1, 2, 3],
        ),
      ]);

      when(() => artistDataSource.getArtistSongs(
          limit: any(named: "limit"), artistUrl: any(named: "artistUrl"), filter: any(named: "filter"))).thenAnswer(
        (_) => CancelableOperation.fromFuture(
          SynchronousFuture(
            Ok(artistsSongsDto),
          ),
        ),
      );

      final repository = ArtistRepositoryImpl(artistDataSource: artistDataSource);
      final artistSongs = await repository.getArtistSongs(limit: 3, artistUrl: artistUrl).value;

      expect(artistSongs.isSuccess, true);
      expect(artistSongs.get()!.length, 1);
      expect(
        artistSongs.get()!.first,
        const ArtistSong(
          id: 2142,
          lyrics: 0,
          lyricsId: 454,
          name: "Me Atraiu",
          sheet: 1,
          url: "me-atraiu",
          verified: true,
          videoLessons: 1,
          videoLessonsInstruments: [1, 2, 3],
        ),
      );
    });

    test("Request failed", () async {
      final artistDataSource = _ArtistDataSourceMock();

      when(() => artistDataSource.getArtistSongs(limit: 3, artistUrl: artistUrl)).thenAnswer(
        (_) => CancelableOperation.fromFuture(
          SynchronousFuture(
            Err(ServerError()),
          ),
        ),
      );

      final repository = ArtistRepositoryImpl(artistDataSource: artistDataSource);
      final artistSongs = await repository.getArtistSongs(limit: 3, artistUrl: artistUrl).value;

      expect(artistSongs.isFailure, true);
      expect(artistSongs.getError().runtimeType, ServerError);
      expect((artistSongs.getError() as ServerError).statusCode, null);
    });
  });

  group("When `getArtistVideoLessons` is called", () {
    const artistDns = "the-beatles";
    test("and request is sucessful", () async {
      var artistDataSource = _ArtistDataSourceMock();
      final videoLessonsDto = _VideoLessonsDtoMock();
      final videoLesson = getFakeVideoLessons();
      when(videoLessonsDto.toDomain).thenReturn(videoLesson);

      when(() => artistDataSource.getVideoLessons(dns: artistDns)).thenAnswer(
        (_) => SynchronousFuture(
          Ok([videoLessonsDto]),
        ),
      );

      final repository = ArtistRepositoryImpl(artistDataSource: artistDataSource);
      final result = await repository.getArtistVideoLessons(artistDns);

      verify(videoLessonsDto.toDomain).called(1);
      expect(result.isSuccess, isTrue);
      expect(result.get()?.length, 1);
      expect(result.get()?.first, videoLesson);
    });

    test("and request fail", () async {
      var artistDataSource = _ArtistDataSourceMock();

      when(() => artistDataSource.getVideoLessons(dns: artistDns)).thenAnswer(
        (_) => SynchronousFuture(
          Err(ServerError(statusCode: 404)),
        ),
      );

      final repository = ArtistRepositoryImpl(artistDataSource: artistDataSource);
      final result = await repository.getArtistVideoLessons(artistDns);

      expect(result.isFailure, isTrue);
      expect(result.getError().runtimeType, ServerError);
      expect((result.getError() as ServerError).statusCode, 404);
    });
  });
}
