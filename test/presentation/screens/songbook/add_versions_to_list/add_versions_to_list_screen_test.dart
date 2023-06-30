import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/add_versions_to_list_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/add_versions_to_list_screen.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/add_versions_to_list_state.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/widgets/add_version_tile/add_version_tile.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/widgets/add_version_tile/song_state.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/widgets/count_selected_versions.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/version_limit_card.dart';
import 'package:cifraclub/presentation/widgets/loading_indicator_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../shared_mocks/domain/search/models/search_mock.dart';
import '../../../../test_helpers/bloc_stream.dart';
import '../../../../test_helpers/test_wrapper.dart';

class _AddVersionsToListScreenBlocMock extends Mock implements AddVersionsToListBloc {}

void main() {
  late AddVersionsToListBloc bloc;

  setUpAll(() {
    bloc = _AddVersionsToListScreenBlocMock();
    registerFallbackValue(getFakeSongSearch());

    when(() => bloc.init(any())).thenReturn(null);
    when(() => bloc.addOrRemoveVersion(any())).thenReturn(null);
    when(bloc.clearCount).thenReturn(null);
    when(() => bloc.getSongState(any())).thenReturn(SongState.selected);
    when(() => bloc.searchSongs(any())).thenReturn(null);
    when(bloc.close).thenAnswer((_) => SynchronousFuture(null));
  });

  testWidgets("When start screen should show limit card with correctly information", (widgetTester) async {
    bloc.mockStream(const AddVersionsToListState(versionsCount: 100, versionsLimit: 1000));

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
    bloc.mockStream(AddVersionsToListState(songs: [getFakeSongSearch(), getFakeSongSearch(), getFakeSongSearch()]));

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

    bloc.mockStream(AddVersionsToListState(songs: [song]));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<AddVersionsToListBloc>.value(
        value: bloc,
        child: const AddVersionsToListScreen(),
      ),
    );

    await widgetTester.tap(find.byType(AddVersionTile).first);

    verify(() => bloc.addOrRemoveVersion(song)).called(1);
  });

  testWidgets("When select songs should show bottom count bar", (widgetTester) async {
    final song = getFakeSongSearch();

    bloc.mockStream(AddVersionsToListState(selectedVersions: [song]));

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

    bloc.mockStream(AddVersionsToListState(selectedVersions: [song]));

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
    bloc.mockStream(const AddVersionsToListState(isLoading: true));

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
    bloc.mockStream(const AddVersionsToListState());

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
}