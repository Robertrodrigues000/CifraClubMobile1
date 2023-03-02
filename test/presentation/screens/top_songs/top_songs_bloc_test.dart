import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/genre/models/all_genres.dart';
import 'package:cifraclub/domain/genre/use_cases/get_genres.dart';
import 'package:cifraclub/domain/shared/paginated_list.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/song/use_cases/get_top_songs.dart';
import 'package:cifraclub/presentation/screens/top_songs/top_songs_bloc.dart';
import 'package:cifraclub/presentation/screens/top_songs/top_songs_state/top_songs_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/genre/models/genre_mock.dart';
import '../../../shared_mocks/domain/song/models/song_mock.dart';

class _MockGetTopSongs extends Mock implements GetTopSongs {}

class _MockGetGenres extends Mock implements GetGenres {}

void main() {
  test("When bloc is created, expect state to be TopSongsState", () {
    final bloc = TopSongsBloc(_MockGetTopSongs(), _MockGetGenres());
    expect(bloc.state, isA<TopSongsState>());
  });

  group("When initGenres is called", () {
    group("when request is successful", () {
      final getGenres = _MockGetGenres();
      final genres = [getFakeGenre(), getFakeGenre(), getFakeGenre(), getFakeGenre()];

      when(getGenres.call).thenAnswer((_) => SynchronousFuture(Ok(AllGenres(
            all: genres,
            top: genres,
          ))));

      blocTest(
        "should update state with genres from use case",
        build: () => TopSongsBloc(_MockGetTopSongs(), getGenres),
        act: (bloc) => bloc.initGenres(),
        expect: () => [
          isA<TopSongsState>().having((state) => state.isLoadingGenres, "is Loading Genres", true),
          isA<TopSongsState>().having((state) => state.genres, "genres", genres),
        ],
      );
    });

    group("when request fails", () {
      final getGenres = _MockGetGenres();

      when(getGenres.call).thenAnswer((_) => SynchronousFuture(Err(ServerError())));

      blocTest(
        "should update the state with error",
        build: () => TopSongsBloc(_MockGetTopSongs(), getGenres),
        act: (bloc) => bloc.initGenres(),
        expect: () => [
          isA<TopSongsState>().having((state) => state.isLoadingGenres, "is Loading Genres", true),
          isA<TopSongsState>().having((state) => state.error, "Error", isNotNull)
        ],
      );
    });
  });
  group("When onGenreSelected is called", () {
    const selectedGenre = "MPB";
    final getTopSongs = _MockGetTopSongs();

    when(() => getTopSongs.call(
          genreUrl: any(named: "genreUrl"),
          limit: any(named: "limit"),
          offset: any(named: "offset"),
        )).thenAnswer((_) => SynchronousFuture(const Ok(PaginatedList(
          items: [],
          hasMoreResults: false,
        ))));

    test("should update de current state with selected genre and trigger requestTopSongs", () {
      final bloc = TopSongsBloc(getTopSongs, _MockGetGenres());
      bloc.onGenreSelected(selectedGenre);

      expect(bloc.state.selectedGenre, selectedGenre);
      verify(() => getTopSongs(genreUrl: selectedGenre)).called(1);
    });
  });

  group("When requestTopSongs is called", () {
    group("when request is successful", () {
      final getTopSongs = _MockGetTopSongs();
      final topSongs = [getFakeSong(), getFakeSong()];

      when(() => getTopSongs.call(
            genreUrl: any(named: "genreUrl"),
            limit: any(named: "limit"),
            offset: any(named: "offset"),
          )).thenAnswer((_) => SynchronousFuture(Ok(PaginatedList(
            items: topSongs,
            hasMoreResults: false,
          ))));

      blocTest(
        "should update the state with songs from use case",
        build: () => TopSongsBloc(getTopSongs, _MockGetGenres()),
        act: (bloc) => bloc.requestTopSongs(),
        expect: () => [
          isA<TopSongsState>().having((state) => state.isLoadingSongs, "is Loading Songs", true),
          isA<TopSongsState>().having((state) => state.topSongs, "Top Songs", topSongs)
        ],
      );
    });

    group("When request fails", () {
      final getTopSongs = _MockGetTopSongs();
      when(() => getTopSongs.call(
          genreUrl: any(named: "genreUrl"),
          limit: any(named: "limit"),
          offset: any(named: "offset"))).thenAnswer((_) => SynchronousFuture(Err(ServerError())));

      blocTest(
        "should update state with error",
        build: () => TopSongsBloc(getTopSongs, _MockGetGenres()),
        act: (bloc) => bloc.requestTopSongs(),
        expect: () => [
          isA<TopSongsState>().having((state) => state.isLoadingSongs, "is Loading Songs", true),
          isA<TopSongsState>().having((state) => state.error, "Error", isNotNull),
        ],
      );
    });
  });
}
