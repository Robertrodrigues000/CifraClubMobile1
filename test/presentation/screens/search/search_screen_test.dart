import 'package:cifraclub/domain/search/models/search_filter.dart';
import 'package:cifraclub/domain/search/models/search_models/album_search.dart';
import 'package:cifraclub/domain/search/models/search_models/song_search.dart';
import 'package:cifraclub/domain/search/models/search_models/songbook_search.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/albums.dart';
import 'package:cifraclub/presentation/screens/search/search_bloc.dart';
import 'package:cifraclub/presentation/screens/search/search_screen.dart';
import 'package:cifraclub/presentation/screens/search/search_state.dart';
import 'package:cifraclub/presentation/screens/search/widgets/search_tile.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/domain/search/models/search_mock.dart';
import '../../../shared_mocks/domain/version/models/version_mock.dart';
import '../../../test_helpers/app_localizations.dart';
import '../../../test_helpers/bloc_stream.dart';
import '../../../test_helpers/test_wrapper.dart';

class _SearchBlocMock extends Mock implements SearchBloc {}

void main() {
  late SearchBloc bloc;

  setUpAll(() {
    bloc = _SearchBlocMock();
    when(bloc.init).thenAnswer((_) => SynchronousFuture(null));
  });

  testWidgets("When state error is not null then error description widget should be displayed", (widgetTester) async {
    bloc.mockStream(SearchState(error: ServerError(), shouldShowRecent: false));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<SearchBloc>.value(
          value: bloc,
          child: const SearchScreen(),
        ),
      ),
    );

    expect(find.byType(ErrorDescriptionWidget), findsOneWidget);
    expect(find.text(appTextEn.serverErrorTitle), findsOneWidget);
  });

  testWidgets("When result is empty then search not found error description widget should be displayed",
      (widgetTester) async {
    bloc.mockStream(const SearchState(result: [], shouldShowRecent: false));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<SearchBloc>.value(
          value: bloc,
          child: const SearchScreen(),
        ),
      ),
    );
    final textField = find.byType(TextField);
    expect(textField, findsOneWidget);
    await widgetTester.enterText(textField, "query");

    when(() => bloc.search("query")).thenReturn(null);
    await widgetTester.pumpAndSettle();

    expect(find.byType(ErrorDescriptionWidget), findsOneWidget);
    expect(find.text(appTextEn.searchResultNotFoundDescription), findsOneWidget);
  });

  testWidgets("When recent is not empty then show list of recent versions", (widgetTester) async {
    bloc.mockStream(SearchState(recent: [getFakeVersion(), getFakeVersion(), getFakeVersion()]));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<SearchBloc>.value(
          value: bloc,
          child: const SearchScreen(),
        ),
      ),
    );

    expect(find.byType(SearchTile), findsNWidgets(3));
  });

  testWidgets("When searching with album filter should show grid list of albums", (widgetTester) async {
    bloc.mockStream(SearchState(
        result: [getFakeAlbumSearch(), getFakeAlbumSearch()],
        selectedFilter: SearchFilter.albums,
        shouldShowRecent: false));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<SearchBloc>.value(
        value: bloc,
        child: const SearchScreen(),
      ),
    );

    expect(find.byType(Albums), findsOneWidget);
  });

  group("When result is not empty", () {
    testWidgets("and search item is a SongSearch should show correct info in SearchTile", (widgetTester) async {
      final results = [getFakeSongSearch(), getFakeArtistSearch(), getFakeAlbumSearch(), getFakeSongbookSearch()];
      bloc.mockStream(SearchState(result: results, shouldShowRecent: false));

      await widgetTester.pumpWidget(
        TestWrapper(
          child: BlocProvider<SearchBloc>.value(
            value: bloc,
            child: const SearchScreen(),
          ),
        ),
      );

      final finder = find.byWidgetPredicate(
          (Widget widget) => widget is SearchTile && widget.title == (results[0] as SongSearch).songName,
          description: "search item for song");
      expect(finder, findsOneWidget);
    });

    testWidgets("and a search item is an ArtistSearch should show correct info in SearchTile", (widgetTester) async {
      final results = [getFakeSongSearch(), getFakeArtistSearch(), getFakeAlbumSearch(), getFakeSongbookSearch()];
      bloc.mockStream(SearchState(result: results, shouldShowRecent: false));
      await widgetTester.pumpWidget(
        TestWrapper(
          child: BlocProvider<SearchBloc>.value(
            value: bloc,
            child: const SearchScreen(),
          ),
        ),
      );

      final finder = find.byWidgetPredicate((Widget widget) => widget is SearchTile && widget.subtitle == null,
          description: "search item for artist");
      expect(finder, findsOneWidget);
    });

    testWidgets("and a search item is an AlbumSearch should show correct info in SearchTile", (widgetTester) async {
      final results = [getFakeSongSearch(), getFakeArtistSearch(), getFakeAlbumSearch(), getFakeSongbookSearch()];
      bloc.mockStream(SearchState(result: results, shouldShowRecent: false));
      await widgetTester.pumpWidget(
        TestWrapper(
          child: BlocProvider<SearchBloc>.value(
            value: bloc,
            child: const SearchScreen(),
          ),
        ),
      );
      final finder = find.byWidgetPredicate(
          (Widget widget) =>
              widget is SearchTile &&
              widget.title == (results[2] as AlbumSearch).albumName &&
              widget.subtitle!.contains((results[2] as AlbumSearch).releaseYear),
          description: "search item for album");
      expect(finder, findsOneWidget);
    });

    testWidgets("and a search item is a SongbookSearch should show correct info in SearchTile", (widgetTester) async {
      final results = [getFakeSongSearch(), getFakeArtistSearch(), getFakeAlbumSearch(), getFakeSongbookSearch()];
      bloc.mockStream(SearchState(result: results, shouldShowRecent: false));
      await widgetTester.pumpWidget(
        TestWrapper(
          child: BlocProvider<SearchBloc>.value(
            value: bloc,
            child: const SearchScreen(),
          ),
        ),
      );
      final finder = find.byWidgetPredicate(
          (Widget widget) =>
              widget is SearchTile &&
              widget.title == (results[3] as SongbookSearch).songbookName &&
              widget.subtitle!.contains((results[3] as SongbookSearch).userName),
          description: "search item for songbook");
      expect(finder, findsOneWidget);
    });
  });
}
