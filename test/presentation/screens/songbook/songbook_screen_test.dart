// ignore_for_file: deprecated_member_use

import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/presentation/screens/songbook/cifras/cifras_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/cifras/cifras_entry.dart';
import 'package:cifraclub/presentation/screens/songbook/cifras/cifras_screen.dart';
import 'package:cifraclub/presentation/screens/songbook/cifras/cifras_state.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/lists_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/lists_screen.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/lists_state.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/user_list_item.dart';
import 'package:cifraclub/presentation/screens/songbook/songbook_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/songbook_screen.dart';
import 'package:cifraclub/presentation/screens/songbook/songbook_state.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/domain/songbook/models/songbook_mock.dart';
import '../../../shared_mocks/presentation/navigator/nav_mock.dart';
import '../../../test_helpers/app_localizations.dart';
import '../../../test_helpers/bloc_stream.dart';
import '../../../test_helpers/test_wrapper.dart';

class _SongbookBlocMock extends Mock implements SongbookBloc {}

class _ListsBlocMock extends Mock implements ListsBloc {}

class _CifrasBlocMock extends Mock implements CifrasBloc {}

class _SongbookFake extends Fake implements Songbook {}

void main() {
  final TestWidgetsFlutterBinding binding = TestWidgetsFlutterBinding.ensureInitialized();
  late SongbookBloc bloc;
  late ListsBloc listsBloc;
  late CifrasBloc cifrasBloc;

  setUpAll(() {
    registerFallbackValue(_SongbookFake());

    bloc = _SongbookBlocMock();
    when(() => bloc.onSelectSongbook(any())).thenReturn(null);
    when(bloc.close).thenAnswer((_) => SynchronousFuture(null));

    listsBloc = _ListsBlocMock();
    when(listsBloc.init).thenReturn(null);
    when(listsBloc.openLoginPage).thenReturn(null);
    when(listsBloc.openUserProfilePage).thenReturn(null);
    when(listsBloc.logout).thenAnswer((_) => SynchronousFuture(null));
    when(listsBloc.close).thenAnswer((_) => SynchronousFuture(null));
    when(listsBloc.initListLimitStreams).thenAnswer((_) => SynchronousFuture(null));
    when(() => listsBloc.isValidSongbookName(any())).thenAnswer((_) => SynchronousFuture(true));

    cifrasBloc = _CifrasBlocMock();
    when(() => cifrasBloc.getSongbook(any())).thenAnswer((_) => SynchronousFuture(null));
    when(cifrasBloc.close).thenAnswer((_) => SynchronousFuture(null));
  });

  group("When start songbook screen", () {
    testWidgets("and user is not logged, should show error description", (widgetTester) async {
      bloc.mockStream(const SongbookState(isUserLoggedIn: false));

      await widgetTester.pumpWidget(
        TestWrapper(
          child: BlocProvider<SongbookBloc>.value(
            value: bloc,
            child: const SongbookScreen(),
          ),
        ),
      );

      expect(find.byType(ErrorDescriptionWidget), findsOneWidget);
      expect(find.text(appTextEn.loggedOutListErrorDescription), findsOneWidget);
    });

    group("in a phone", () {
      testWidgets("should show lists screen", (widgetTester) async {
        binding.window.physicalSizeTestValue = const Size(460, 800);
        binding.window.devicePixelRatioTestValue = 1.0;

        bloc.mockStream(const SongbookState(selectedSongbook: null, isUserLoggedIn: true));
        listsBloc.mockStream(const ListsState());

        await widgetTester.pumpWidgetWithWrapper(
          MultiBlocProvider(
            providers: [
              BlocProvider<SongbookBloc>.value(value: bloc),
              BlocProvider<ListsBloc>.value(value: listsBloc),
            ],
            child: const SongbookScreen(),
          ),
        );

        expect(find.byType(CifrasScreen), findsNothing);
      });

      testWidgets("and click in a songbook should push to a new cifras screen", (widgetTester) async {
        binding.window.physicalSizeTestValue = const Size(460, 800);
        binding.window.devicePixelRatioTestValue = 1.0;

        bloc.mockStream(const SongbookState(selectedSongbook: null, isUserLoggedIn: true));
        listsBloc.mockStream(ListsState(userLists: [getFakeSongbook()]));

        final nav = NavMock.getDummy();

        await widgetTester.pumpWidgetWithWrapper(
          MultiBlocProvider(
            providers: [
              BlocProvider<SongbookBloc>.value(value: bloc),
              BlocProvider<ListsBloc>.value(value: listsBloc),
            ],
            child: const SongbookScreen(),
          ),
          nav: nav,
        );

        final finder = find.byType(UserListItem).first;

        await widgetTester.tap(finder);
        verify(() => nav.push(screenName: CifrasEntry.name)).called(1);
      });
    });

    group("in a tablet", () {
      testWidgets("should show lists and cifra screen", (widgetTester) async {
        binding.window.physicalSizeTestValue = const Size(850, 1000);
        binding.window.devicePixelRatioTestValue = 1.0;

        bloc.mockStream(const SongbookState(selectedSongbook: null, isUserLoggedIn: true));
        listsBloc.mockStream(const ListsState());
        cifrasBloc.mockStream(const CifrasState(isPublic: true));

        await widgetTester.pumpWidgetWithWrapper(
          MultiBlocProvider(
            providers: [
              BlocProvider<SongbookBloc>.value(value: bloc),
              BlocProvider<ListsBloc>.value(value: listsBloc),
              BlocProvider<CifrasBloc>.value(value: cifrasBloc),
            ],
            child: const SongbookScreen(),
          ),
        );

        expect(find.byType(ListsScreen), findsOneWidget);
        expect(find.byType(CifrasScreen), findsOneWidget);
      });

      testWidgets("and click in a songbook should emit new songbook", (widgetTester) async {
        binding.window.physicalSizeTestValue = const Size(850, 1000);
        binding.window.devicePixelRatioTestValue = 1.0;

        bloc.mockStream(const SongbookState(selectedSongbook: null, isUserLoggedIn: true));
        listsBloc.mockStream(ListsState(userLists: [getFakeSongbook()]));
        cifrasBloc.mockStream(const CifrasState(isPublic: true));

        await widgetTester.pumpWidgetWithWrapper(
          MultiBlocProvider(
            providers: [
              BlocProvider<SongbookBloc>.value(value: bloc),
              BlocProvider<ListsBloc>.value(value: listsBloc),
              BlocProvider<CifrasBloc>.value(value: cifrasBloc),
            ],
            child: const SongbookScreen(),
          ),
        );

        final finder = find.byType(UserListItem).first;

        await widgetTester.tap(finder);
        verify(() => bloc.onSelectSongbook(any())).called(1);
      });
    });
  });
}
