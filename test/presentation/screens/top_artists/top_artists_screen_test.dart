import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/presentation/bottom_sheets/genres_bottom_sheet/genre_bottom_sheet.dart';
import 'package:cifraclub/presentation/screens/top_artists/top_artists_bloc.dart';
import 'package:cifraclub/presentation/screens/top_artists/top_artists_screen.dart';
import 'package:cifraclub/presentation/screens/top_artists/top_artists_state.dart';
import 'package:cifraclub/presentation/widgets/filter_capsule/filter_capsule.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/domain/artist/models/artist_mock.dart';
import '../../../shared_mocks/domain/genre/models/genre_mock.dart';
import '../../../test_helpers/bloc_stream.dart';
import '../../../test_helpers/test_wrapper.dart';

class _TopArtistsBlocMock extends Mock implements TopArtistsBloc {}

class _GenreBottomSheetMock extends Mock implements GenreBottomSheet {}

class _BuildContextMock extends Mock implements BuildContext {}

void main() {
  late TopArtistsBloc bloc;
  _GenreBottomSheetMock genreBottomSheetMock = _GenreBottomSheetMock();

  setUpAll(() {
    registerFallbackValue(_BuildContextMock());
    registerFallbackValue(getFakeGenre());
    bloc = _TopArtistsBlocMock();
    when(bloc.initGenres).thenAnswer((_) => SynchronousFuture(null));
    when(bloc.requestTopArtists).thenAnswer((_) => SynchronousFuture(null));
    when(() => bloc.insertGenre(any())).thenAnswer((_) => SynchronousFuture(null));
    when(bloc.close).thenAnswer((_) => SynchronousFuture(null));
  });

  testWidgets("when state isLoadingArtists is true then loading and filter list should be displayed",
      (widgetTester) async {
    final genres = [getFakeGenre(), getFakeGenre()];
    final selectedGenre = genres.first.url;
    bloc.mockStream(TopArtistsState(selectedGenre: selectedGenre, genres: genres, isLoadingArtists: true));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<TopArtistsBloc>.value(
          value: bloc,
          child: TopArtistsScreen(_GenreBottomSheetMock()),
        ),
      ),
    );

    expect(find.text(genres.first.name), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets("When state isLoadingArtists is false then TopArtists and filter list should be displayed",
      (widgetTester) async {
    final topArtists = [getFakeArtist(), getFakeArtist()];
    final genres = [getFakeGenre()];
    bloc.mockStream(
      TopArtistsState(topArtists: topArtists, genres: genres, selectedGenre: "", isLoadingArtists: false),
    );

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<TopArtistsBloc>.value(
          value: bloc,
          child: TopArtistsScreen(_GenreBottomSheetMock()),
        ),
      ),
    );

    expect(find.text(genres.first.name), findsOneWidget);
    expect(find.text(topArtists.first.name), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(SliverList), findsAtLeastNWidgets(1));
  });

  group("When TopArtistsState has error", () {
    testWidgets("then if genres is not empty error and filter list should be displayed", (widgetTester) async {
      final genres = [getFakeGenre(), getFakeGenre()];
      bloc.mockStream(
        TopArtistsState(
          genres: genres,
          selectedGenre: "",
          error: ServerError(),
        ),
      );

      await widgetTester.pumpWidget(
        TestWrapper(
          child: BlocProvider<TopArtistsBloc>.value(
            value: bloc,
            child: TopArtistsScreen(_GenreBottomSheetMock()),
          ),
        ),
      );

      expect(find.text(genres.first.name), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.text("Erro"), findsOneWidget);
    });
  });

  testWidgets("when genre is selected should call onGenreSelected from bloc with the genreUrl", (widgetTester) async {
    final genres = [getFakeGenre(), getFakeGenre()];
    bloc.mockStream(
      TopArtistsState(genres: genres, selectedGenre: "", topArtists: []),
    );

    when(() => bloc.onGenreSelected(genres.first.url)).thenAnswer((_) => SynchronousFuture(null));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<TopArtistsBloc>.value(
          value: bloc,
          child: TopArtistsScreen(_GenreBottomSheetMock()),
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
    bloc.mockStream(TopArtistsState());
    when(() => genreBottomSheetMock.open(any())).thenAnswer((_) => SynchronousFuture(getFakeGenre()));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<TopArtistsBloc>.value(
          value: bloc,
          child: TopArtistsScreen(genreBottomSheetMock),
        ),
      ),
    );

    await widgetTester.tap(find.byType(FilterCapsule).last);
    await widgetTester.pumpAndSettle();

    verify(() => bloc.insertGenre(any())).called(1);
  });
}
