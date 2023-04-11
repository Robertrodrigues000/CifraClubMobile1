import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/presentation/screens/top_songs/top_songs_bloc.dart';
import 'package:cifraclub/presentation/screens/top_songs/top_songs_screen.dart';
import 'package:cifraclub/presentation/screens/top_songs/top_songs_state/top_songs_state.dart';
import 'package:cifraclub/presentation/widgets/filter_capsule/filter_capsule.dart';
import 'package:cifraclub/presentation/widgets/genres_bottom_sheet/genre_bottom_sheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/domain/genre/models/genre_mock.dart';
import '../../../shared_mocks/domain/song/models/song_mock.dart';
import '../../../test_helpers/bloc_stream.dart';
import '../../../test_helpers/test_wrapper.dart';

class _TopSongsBlocMock extends Mock implements TopSongsBloc {}

class _GenreBottomSheetMock extends Mock implements GenreBottomSheet {}

class _BuildContextMock extends Mock implements BuildContext {}

void main() {
  late TopSongsBloc bloc;
  _GenreBottomSheetMock genreBottomSheetMock = _GenreBottomSheetMock();

  setUpAll(() {
    registerFallbackValue(_BuildContextMock());
    registerFallbackValue(getFakeGenre());
    bloc = _TopSongsBlocMock();
    when(bloc.initGenres).thenAnswer((_) => SynchronousFuture(null));
    when(bloc.requestTopSongs).thenAnswer((_) => SynchronousFuture(null));
    when(() => bloc.insertGenre(any())).thenAnswer((_) => SynchronousFuture(null));
    when(bloc.close).thenAnswer((_) => SynchronousFuture(null));
  });

  testWidgets("when state isLoadingSongs is true then loading and filter list should be displayed",
      (widgetTester) async {
    final genres = [getFakeGenre(), getFakeGenre()];
    final selectedGenre = genres.first.url;
    bloc.mockStream(TopSongsState(selectedGenre: selectedGenre, genres: genres, isLoadingSongs: true));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<TopSongsBloc>.value(
          value: bloc,
          child: TopSongsScreen(_GenreBottomSheetMock()),
        ),
      ),
    );

    expect(find.text(genres.first.name), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets("When state isLoadingSongs is false then TopSongs and filter list should be displayed",
      (widgetTester) async {
    final topSongs = [getFakeSong(), getFakeSong()];
    final genres = [getFakeGenre()];
    bloc.mockStream(
      TopSongsState(topSongs: topSongs, genres: genres, selectedGenre: "", isLoadingSongs: false),
    );

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<TopSongsBloc>.value(
          value: bloc,
          child: TopSongsScreen(_GenreBottomSheetMock()),
        ),
      ),
    );

    expect(find.text(genres.first.name), findsOneWidget);
    expect(find.text(topSongs.first.name), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(SliverList), findsAtLeastNWidgets(1));
  });

  group("When TopSongsState has error", () {
    testWidgets("then if genres is not empty error and filter list should be displayed", (widgetTester) async {
      final genres = [getFakeGenre(), getFakeGenre()];
      bloc.mockStream(
        TopSongsState(
          genres: genres,
          selectedGenre: "",
          error: ServerError(),
        ),
      );

      await widgetTester.pumpWidget(
        TestWrapper(
          child: BlocProvider<TopSongsBloc>.value(
            value: bloc,
            child: TopSongsScreen(_GenreBottomSheetMock()),
          ),
        ),
      );

      expect(find.text(genres.first.name), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.text("Erro"), findsOneWidget);
    });
  });

  testWidgets("When genre is selected should call onGenreSelected from bloc with the genreUrl", (widgetTester) async {
    final genres = [getFakeGenre(), getFakeGenre()];
    bloc.mockStream(
      TopSongsState(genres: genres, selectedGenre: "", topSongs: []),
    );

    when(() => bloc.onGenreSelected(genres.first.url)).thenAnswer((_) => SynchronousFuture(null));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<TopSongsBloc>.value(
          value: bloc,
          child: TopSongsScreen(_GenreBottomSheetMock()),
        ),
      ),
    );

    await widgetTester.tap(
      find.byKey(
        Key(
          genres.first.name,
        ),
      ),
    );

    verify(() => bloc.onGenreSelected(genres.first.url)).called(1);

    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets("When more capsule is tapped and return a genre should insert genre", (widgetTester) async {
    bloc.mockStream(TopSongsState());
    when(() => genreBottomSheetMock.open(any())).thenAnswer((_) => SynchronousFuture(getFakeGenre()));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<TopSongsBloc>.value(
          value: bloc,
          child: TopSongsScreen(genreBottomSheetMock),
        ),
      ),
    );

    await widgetTester.tap(find.byType(FilterCapsule).last);
    await widgetTester.pumpAndSettle();

    verify(() => bloc.insertGenre(any())).called(1);
  });
}
