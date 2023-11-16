import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/presentation/navigator/navigators_controller.dart';
import 'package:cifraclub/presentation/screens/main/bottom_navigation_item.dart';
import 'package:cifraclub/presentation/screens/main/main_bloc.dart';
import 'package:cifraclub/presentation/screens/main/main_screen.dart';
import 'package:cifraclub/presentation/screens/main/main_state.dart';
import 'package:cifraclub/presentation/screens/main/widgets/main_bottom_navigation.dart';
import 'package:cifraclub/presentation/screens/version/version_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nav/nav.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/presentation/navigator/fake_screen_entry.dart';
import '../../../shared_mocks/presentation/navigator/nav_mock.dart';
import '../../../test_helpers/app_localizations.dart';
import '../../../test_helpers/test_wrapper.dart';

class MockMainBloc extends MockCubit<MainState> implements MainBloc {
  MockMainBloc();

  MockMainBloc.dummy({Stream<MainState>? statesStream}) {
    whenListen<MainState>(
      this,
      statesStream ?? Stream.fromIterable([]),
      initialState: const MainState(),
    );
  }
}

class FakeRestorableBottomNavigationItem extends Fake implements RestorableBottomNavigationItem {
  FakeRestorableBottomNavigationItem({this.value = BottomNavigationItem.home});

  @override
  void addListener(VoidCallback listener) {}

  @override
  void removeListener(VoidCallback listener) {}

  @override
  BottomNavigationItem value;
}

class _MockNavigatorsController extends Mock implements NavigatorsController {
  _MockNavigatorsController();

  @override
  final navs = [
    NavMock.getDummy(screens: [FakeScreenEntry(fakeScreenName: 'home')]),
    NavMock.getDummy(screens: [
      FakeScreenEntry(
        fakeScreenName: 'songbook',
      )
    ]),
    NavMock.getDummy(screens: [
      FakeScreenEntry(
        fakeScreenName: 'search',
      )
    ]),
    NavMock.getDummy(screens: [
      FakeScreenEntry(
        fakeScreenName: 'academy',
      )
    ]),
    NavMock.getDummy(screens: [
      FakeScreenEntry(
        fakeScreenName: 'more',
      )
    ]),
  ];

  factory _MockNavigatorsController.dummy() {
    final restorable = FakeRestorableBottomNavigationItem();
    final mock = _MockNavigatorsController();
    when(() => mock.restorableBottomNavigationIndex).thenReturn(restorable);
    when(() => mock.currentBottomNavigationScreen).thenReturn(restorable.value);
    return mock;
  }
}

void main() {
  const navFrameKey = Key("testando");

  setUpAll(() {
    registerFallbackValue(BottomNavigationItem.home);
  });

  Widget getMainScreen({
    PageController? pageController,
    Widget Function(Nav)? navFrameBuilder,
    NavigatorsController? navigatorsController,
  }) {
    return MainScreen(
      pageController: pageController ?? PageController(),
      navFrameBuilder: navFrameBuilder ??
          (nav) => Container(
                key: navFrameKey,
              ),
      navigatorsController: navigatorsController ?? _MockNavigatorsController.dummy(),
    );
  }

  group("When screen is built", () {
    testWidgets('show the bottom navigation', (WidgetTester tester) async {
      final nav = NavMock.getDummy();

      await tester.pumpWidgetWithWrapper(
        nav: nav,
        BlocProvider<MainBloc>(
          create: (BuildContext context) => MockMainBloc.dummy(),
          child: getMainScreen(),
        ),
      );
      expect(find.byType(MainBottomNavigation), findsOneWidget);
    });

    testWidgets('show the NavFrame', (WidgetTester tester) async {
      await tester.pumpWidgetWithWrapper(
        BlocProvider<MainBloc>(
          create: (BuildContext context) => MockMainBloc.dummy(),
          child: getMainScreen(),
        ),
      );
      expect(find.byKey(navFrameKey), findsOneWidget);
    });
  });

  testWidgets("when tap on bottom navigation item, should call set selected item", (tester) async {
    final stream = StreamController<MainState>();
    final pageController = PageController();
    final navigatorController = _MockNavigatorsController.dummy();

    when(() => navigatorController.setSelectedItem(any())).thenAnswer((_) {});
    await tester.pumpWidget(
      TestWrapper(
        child: BlocProvider<MainBloc>(
          create: (BuildContext context) => MockMainBloc.dummy(
            statesStream: stream.stream,
          ),
          child: getMainScreen(
            navigatorsController: navigatorController,
            pageController: pageController,
          ),
        ),
      ),
    );

    await tester.tap(find.text(appTextEn.home));
    await tester.pumpAndSettle();

    verify(() => navigatorController.setSelectedItem(any())).called(1);
    stream.close();
  });

  testWidgets("when navigated to Version screen should hide bottom navigation", (tester) async {
    final stream = StreamController<MainState>();
    final pageController = PageController();
    final navigatorController = _MockNavigatorsController.dummy();

    when(() => navigatorController.currentScreen).thenReturn(FakeScreenEntry(fakeScreenName: VersionEntry.name));

    await tester.pumpWidget(
      TestWrapper(
        child: BlocProvider<MainBloc>(
          create: (BuildContext context) => MockMainBloc.dummy(
            statesStream: stream.stream,
          ),
          child: getMainScreen(
            navigatorsController: navigatorController,
            pageController: pageController,
          ),
        ),
      ),
    );

    expect(find.byType(MainBottomNavigation), findsNothing);

    stream.close();
  });
}
