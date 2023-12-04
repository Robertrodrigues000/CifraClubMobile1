import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/presentation/dialogs/list_limit_dialog.dart';
import 'package:cifraclub/presentation/dialogs/list_limit_pro_dialog.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/add_versions_to_list_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/add_versions_to_list_screen.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/add_versions_to_list_state.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/widgets/add_version_tile/add_version_tile.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/widgets/add_version_tile/song_selection_state.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/widgets/count_selected_versions.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/version_limit_card.dart';
import 'package:cifraclub/presentation/widgets/limit_warning.dart';
import 'package:cifraclub/presentation/widgets/loading_indicator_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../../shared_mocks/domain/search/models/search_mock.dart';
import '../../../../test_helpers/app_localizations.dart';
import '../../../../test_helpers/bloc_stream.dart';
import '../../../../test_helpers/test_wrapper.dart';

class _AddVersionsToListScreenBlocMock extends Mock implements AddVersionsToListBloc {}

void main() {
  late AddVersionsToListBloc bloc;

  setUpAll(() {
    bloc = _AddVersionsToListScreenBlocMock();
    registerFallbackValue(getFakeSongSearch());

    when(() => bloc.init()).thenAnswer((_) => SynchronousFuture(null));
    when(() => bloc.addOrRemoveVersion(any())).thenReturn(null);
    when(bloc.clearCount).thenReturn(null);
    when(() => bloc.getSongState(any())).thenReturn(SongSelectionState.selected);
    when(() => bloc.searchSongs(any())).thenReturn(null);
    when(bloc.close).thenAnswer((_) => SynchronousFuture(null));
  });

  testWidgets("When start screen should show limit card with correctly information", (widgetTester) async {
    bloc.mockStream(const AddVersionsToListState(songsCount: 100, versionsLimit: 1000, songbookId: 1));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<AddVersionsToListBloc>.value(
        value: bloc,
        child: const AddVersionsToListScreen(),
      ),
    );

    expect(find.byType(VersionLimitCard), findsOneWidget);
    expect(find.textContaining("100/1000", findRichText: true), findsOneWidget);
  });

  testWidgets("When search songs should show a list of songs", (widgetTester) async {
    bloc.mockStream(
        AddVersionsToListState(songs: [getFakeSongSearch(), getFakeSongSearch(), getFakeSongSearch()], songbookId: 1));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<AddVersionsToListBloc>.value(
        value: bloc,
        child: const AddVersionsToListScreen(),
      ),
    );

    final songs = find.byType(AddVersionTile, skipOffstage: false);

    expect(songs, findsNWidgets(3));
  });

  testWidgets("When click in a song should change to new status", (widgetTester) async {
    final song = getFakeSongSearch();

    bloc.mockStream(AddVersionsToListState(songs: [song], songbookId: 1));
    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidgetWithWrapper(
        BlocProvider<AddVersionsToListBloc>.value(
          value: bloc,
          child: const AddVersionsToListScreen(),
        ),
      );
    });

    await widgetTester.tap(find.byType(AddVersionTile).first);

    verify(() => bloc.addOrRemoveVersion(song)).called(1);
  });

  testWidgets("When select songs should show bottom count bar", (widgetTester) async {
    final song = getFakeSongSearch();

    bloc.mockStream(AddVersionsToListState(selectedSongs: [song], songbookId: 1));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<AddVersionsToListBloc>.value(
        value: bloc,
        child: const AddVersionsToListScreen(),
      ),
    );

    final songs = find.byType(CountSelectedVersions);

    expect(songs, findsOneWidget);
  });

  testWidgets("When click in clear list button should clear selected songs", (widgetTester) async {
    final song = getFakeSongSearch();

    bloc.mockStream(AddVersionsToListState(selectedSongs: [song], songbookId: 1));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<AddVersionsToListBloc>.value(
        value: bloc,
        child: const AddVersionsToListScreen(),
      ),
    );

    await widgetTester.tap(find.byKey(const Key("onClearTap")));

    verify(bloc.clearCount).called(1);
  });

  testWidgets("When emit loading should show loading", (widgetTester) async {
    bloc.mockStream(const AddVersionsToListState(isLoading: true, songbookId: 1));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<AddVersionsToListBloc>.value(
        value: bloc,
        child: const AddVersionsToListScreen(),
      ),
    );

    final songs = find.byType(LoadingIndicatorContainer);

    expect(songs, findsOneWidget);
  });

  testWidgets("When type on text field should search song of the query", (widgetTester) async {
    bloc.mockStream(const AddVersionsToListState(songbookId: 1));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<AddVersionsToListBloc>.value(
        value: bloc,
        child: const AddVersionsToListScreen(),
      ),
    );

    final textField = find.byType(TextField);
    expect(textField, findsOneWidget);
    await widgetTester.enterText(textField, "adele");

    verify(() => bloc.searchSongs("adele")).called(1);
  });

  group("When click on save button", () {
    testWidgets("and requests is successful should show snackbar with count of songs saved", (widgetTester) async {
      bloc.mockStream(AddVersionsToListState(songbookId: 10, selectedSongs: [getFakeSongSearch()]));
      when(() => bloc.addSongsToSongbook())
          .thenAnswer((_) => SynchronousFuture((songsSaved: 1, errorCount: 0, lastSongError: null)));

      await widgetTester.pumpWidgetWithWrapper(
        BlocProvider<AddVersionsToListBloc>.value(
          value: bloc,
          child: const AddVersionsToListScreen(),
        ),
      );

      await widgetTester.tap(find.byKey(const Key("onSaveTap")));
      await widgetTester.pump();

      expect(find.text(appTextEn.savedListSongs(1)), findsOneWidget);
    });

    testWidgets("and requests fails should show snackbar with count of errors", (widgetTester) async {
      bloc.mockStream(AddVersionsToListState(songbookId: 10, selectedSongs: [getFakeSongSearch()]));
      when(() => bloc.addSongsToSongbook())
          .thenAnswer((_) => SynchronousFuture((songsSaved: 0, errorCount: 5, lastSongError: getFakeSongSearch())));

      await widgetTester.pumpWidgetWithWrapper(
        BlocProvider<AddVersionsToListBloc>.value(
          value: bloc,
          child: const AddVersionsToListScreen(),
        ),
      );

      await widgetTester.tap(find.byKey(const Key("onSaveTap")));
      await widgetTester.pump();

      expect(find.text(appTextEn.errorsListSongs(5, "", "")), findsOneWidget);
    });
  });

  testWidgets("When search don't found result should show not found search message", (widgetTester) async {
    bloc.mockStream(const AddVersionsToListState(isHistory: false, songs: [], songbookId: 10));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<AddVersionsToListBloc>.value(
        value: bloc,
        child: const AddVersionsToListScreen(),
      ),
    );

    expect(find.text(appTextEn.searchNotFound), findsOneWidget);
    expect(find.text(appTextEn.searchNewTerm), findsOneWidget);
  });

  testWidgets("When click to add a song and limit state is reached should show ListLimitDialog", (widgetTester) async {
    final song = getFakeSongSearch();

    bloc.mockStream(AddVersionsToListState(
      songs: [song],
      songbookId: 1,
      limitState: ListLimitState.reached,
      songsCount: 10,
      versionsLimit: 10,
    ));
    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidgetWithWrapper(
        BlocProvider<AddVersionsToListBloc>.value(
          value: bloc,
          child: const AddVersionsToListScreen(),
        ),
      );
    });

    await widgetTester.tap(find.byType(AddVersionTile).first);
    await widgetTester.pump();
    expect(find.byType(ListLimitDialog), findsOneWidget);
    verifyNever(() => bloc.addOrRemoveVersion(song));
  });

  testWidgets("When click to add a song and limit state is reached and user is pro should show ListLimitProDialog",
      (widgetTester) async {
    final song = getFakeSongSearch();

    bloc.mockStream(AddVersionsToListState(
      songs: [song],
      songbookId: 1,
      limitState: ListLimitState.reached,
      songsCount: 10,
      versionsLimit: 10,
      isPro: true,
    ));
    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidgetWithWrapper(
        BlocProvider<AddVersionsToListBloc>.value(
          value: bloc,
          child: const AddVersionsToListScreen(),
        ),
      );
    });

    await widgetTester.tap(find.byType(AddVersionTile).first);
    await widgetTester.pump();
    expect(find.byType(ListLimitProDialog), findsOneWidget);
    verifyNever(() => bloc.addOrRemoveVersion(song));
  });

  testWidgets("When click to add a song and limit state change to reached should show snackbar", (widgetTester) async {
    final song = getFakeSongSearch();

    bloc.mockStream(AddVersionsToListState(
      songs: [song],
      songbookId: 1,
      limitState: ListLimitState.reached,
      songsCount: 9,
      versionsLimit: 10,
      isPro: true,
    ));
    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidgetWithWrapper(
        BlocProvider<AddVersionsToListBloc>.value(
          value: bloc,
          child: const AddVersionsToListScreen(),
        ),
      );
    });

    await widgetTester.tap(find.byType(AddVersionTile).first);
    await widgetTester.pump();
    expect(find.byType(LimitWarning), findsOneWidget);
    verify(() => bloc.addOrRemoveVersion(song)).called(1);
  });
}
