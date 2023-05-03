import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/songbook/cifras/cifras_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/cifras/cifras_entry.dart';
import 'package:cifraclub/presentation/screens/songbook/cifras/cifras_screen.dart';
import 'package:cifraclub/presentation/screens/songbook/cifras/cifras_state.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/lists_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/lists_screen.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/lists_state.dart';
import 'package:cifraclub/presentation/screens/songbook/songbook_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/songbook_screen.dart';
import 'package:cifraclub/presentation/screens/songbook/songbook_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/presentation/navigator/nav_mock.dart';
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

    cifrasBloc = _CifrasBlocMock();
    when(() => cifrasBloc.getCifras(any())).thenAnswer((_) => SynchronousFuture(null));
    when(cifrasBloc.close).thenAnswer((_) => SynchronousFuture(null));
  });

  testWidgets("When start songbook screen in a phone should show lists screen", (widgetTester) async {
    binding.window.physicalSizeTestValue = const Size(460, 800);
    binding.window.devicePixelRatioTestValue = 1.0;

    bloc.mockStream(const SongbookState(selectedSongbook: null));
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

    //expect(find.byType(ListsScreen), findsOneWidget);
    expect(find.byType(CifrasScreen), findsNothing);
  });

  testWidgets("When start songbook screen in a phone and click in a songbook should push to a new cifras screen",
      (widgetTester) async {
    binding.window.physicalSizeTestValue = const Size(460, 800);
    binding.window.devicePixelRatioTestValue = 1.0;

    bloc.mockStream(const SongbookState(selectedSongbook: null));
    listsBloc.mockStream(const ListsState());

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

    final finder = find.byWidgetPredicate(
      (Widget widget) =>
          widget is SvgPicture &&
          widget.pictureProvider is ExactAssetPicture &&
          (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.addIcon,
      description: 'widget with add icon',
    ); //TODO: Mudar essa teste quando tiver as listas do usuario

    await widgetTester.tap(finder);
    verify(() => nav.push(screenName: CifrasEntry.name)).called(1);
  });

  testWidgets("When start songbook screen in a tablet should show lists and cifra screen", (widgetTester) async {
    binding.window.physicalSizeTestValue = const Size(850, 1000);
    binding.window.devicePixelRatioTestValue = 1.0;

    bloc.mockStream(const SongbookState(selectedSongbook: null));
    listsBloc.mockStream(const ListsState());
    cifrasBloc.mockStream(const CifrasState());

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

  testWidgets("When start songbook screen in a tablet and click in a songbook should emit new songbook",
      (widgetTester) async {
    binding.window.physicalSizeTestValue = const Size(850, 1000);
    binding.window.devicePixelRatioTestValue = 1.0;

    bloc.mockStream(const SongbookState(selectedSongbook: null));
    listsBloc.mockStream(const ListsState());
    cifrasBloc.mockStream(const CifrasState());

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

    final finder = find
        .byWidgetPredicate(
          (Widget widget) =>
              widget is SvgPicture &&
              widget.pictureProvider is ExactAssetPicture &&
              (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.addIcon,
          description: 'widget with add icon',
        )
        .first; //TODO: Mudar essa teste quando tiver as listas do usuario

    await widgetTester.tap(finder);
    verify(() => bloc.onSelectSongbook(any())).called(1);
  });
}
