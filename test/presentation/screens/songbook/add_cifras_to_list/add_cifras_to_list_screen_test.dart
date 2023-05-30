import 'package:cifraclub/presentation/screens/songbook/add_cifras_to_list/add_cifras_to_list_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/add_cifras_to_list/add_cifras_to_list_screen.dart';
import 'package:cifraclub/presentation/screens/songbook/add_cifras_to_list/add_cifras_to_list_state.dart';
import 'package:cifraclub/presentation/screens/songbook/add_cifras_to_list/widgets/add_cifra_tile/add_cifra_tile.dart';
import 'package:cifraclub/presentation/screens/songbook/add_cifras_to_list/widgets/add_cifra_tile/song_state.dart';
import 'package:cifraclub/presentation/screens/songbook/add_cifras_to_list/widgets/count_selected_tabs.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/cifra_limit_card.dart';
import 'package:cifraclub/presentation/widgets/loading_indicator_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../shared_mocks/domain/search/models/search_mock.dart';
import '../../../../test_helpers/bloc_stream.dart';
import '../../../../test_helpers/test_wrapper.dart';

class _AddCifrasToListScreenBloc extends Mock implements AddCifrasToListBloc {}

void main() {
  late AddCifrasToListBloc bloc;

  setUpAll(() {
    bloc = _AddCifrasToListScreenBloc();
    registerFallbackValue(getFakeSongSearch());

    when(() => bloc.init(any())).thenReturn(null);
    when(() => bloc.addOrRemoveCifra(any())).thenReturn(null);
    when(bloc.clearCount).thenReturn(null);
    when(() => bloc.getSongState(any())).thenReturn(SongState.selected);
    when(() => bloc.searchSongs(any())).thenReturn(null);
    when(bloc.close).thenAnswer((_) => SynchronousFuture(null));
  });

  testWidgets("When start screen should show limit card with correctly informations", (widgetTester) async {
    bloc.mockStream(const AddCifrasToListState(tabsCount: 100, tabsLimit: 1000));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<AddCifrasToListBloc>.value(
        value: bloc,
        child: const AddCifrasToListScreen(),
      ),
    );

    expect(find.byType(CifraLimitCard), findsOneWidget);
    expect(find.textContaining("100/1000", findRichText: true), findsOneWidget);
  });

  testWidgets("When search songs should show a lista of songs", (widgetTester) async {
    bloc.mockStream(AddCifrasToListState(songs: [getFakeSongSearch(), getFakeSongSearch(), getFakeSongSearch()]));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<AddCifrasToListBloc>.value(
        value: bloc,
        child: const AddCifrasToListScreen(),
      ),
    );

    final songs = find.byType(AddCifraTile, skipOffstage: false);

    expect(songs, findsNWidgets(3));
  });

  testWidgets("When click in a song should change to new status", (widgetTester) async {
    final song = getFakeSongSearch();

    bloc.mockStream(AddCifrasToListState(songs: [song]));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<AddCifrasToListBloc>.value(
        value: bloc,
        child: const AddCifrasToListScreen(),
      ),
    );

    await widgetTester.tap(find.byType(AddCifraTile).first);

    verify(() => bloc.addOrRemoveCifra(song)).called(1);
  });

  testWidgets("When select songs should show bottom count bar", (widgetTester) async {
    final song = getFakeSongSearch();

    bloc.mockStream(AddCifrasToListState(selectedCifras: [song]));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<AddCifrasToListBloc>.value(
        value: bloc,
        child: const AddCifrasToListScreen(),
      ),
    );

    final songs = find.byType(CountSelectedTabs);

    expect(songs, findsOneWidget);
  });

  testWidgets("When click in clear list button should clear selecteds songs", (widgetTester) async {
    final song = getFakeSongSearch();

    bloc.mockStream(AddCifrasToListState(selectedCifras: [song]));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<AddCifrasToListBloc>.value(
        value: bloc,
        child: const AddCifrasToListScreen(),
      ),
    );

    await widgetTester.tap(find.byKey(const Key("onClearTap")));

    verify(bloc.clearCount).called(1);
  });

  testWidgets("When emit loading should show loading", (widgetTester) async {
    bloc.mockStream(const AddCifrasToListState(isLoading: true));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<AddCifrasToListBloc>.value(
        value: bloc,
        child: const AddCifrasToListScreen(),
      ),
    );

    final songs = find.byType(LoadingIndicatorContainer);

    expect(songs, findsOneWidget);
  });

  testWidgets("When type on textfield should search song of the query", (widgetTester) async {
    bloc.mockStream(const AddCifrasToListState());

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<AddCifrasToListBloc>.value(
        value: bloc,
        child: const AddCifrasToListScreen(),
      ),
    );

    final textField = find.byType(TextField);
    expect(textField, findsOneWidget);
    await widgetTester.enterText(textField, "adele");

    verify(() => bloc.searchSongs("adele")).called(1);
  });
}
