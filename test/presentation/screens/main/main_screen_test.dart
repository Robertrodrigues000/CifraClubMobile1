import 'dart:async';

import 'package:cifraclub/presentation/screens/main/bottom_navigation_item.dart';
import 'package:cifraclub/presentation/screens/main/main_bloc.dart';
import 'package:cifraclub/presentation/screens/main/main_screen.dart';
import 'package:cifraclub/presentation/screens/main/main_state.dart';
import 'package:cifraclub/presentation/screens/main/widgets/main_bottom_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nav/nav.dart';

import '../../../shared_mocks/presentation/navigator/fake_screen_entry.dart';
import '../../../shared_mocks/presentation/navigator/mock_main_bloc.dart';
import '../../../shared_mocks/presentation/navigator/nav_mock.dart';
import '../../../test_helpers/bloc_stream.dart';
import '../../../test_helpers/test_wrapper.dart';

class _MainBlocMock extends Mock implements MainBloc {}

void main() {
  late MainBloc bloc;
  Widget fakeNavFrameBuilder(Nav nav) => const SizedBox();

  setUpAll(() {
    bloc = _MainBlocMock();
    when(bloc.close).thenAnswer((_) => SynchronousFuture(null));
  });

  group("When state is HomeInitialState", () {
    testWidgets("Show bottom navigation", (widgetTester) async {
      bloc.mockStream(const MainState(bottomNavigationNavs: [], selectedPage: BottomNavigationItem.home));

      await widgetTester.pumpWidget(
        TestWrapper(
          child: BlocProvider<MainBloc>.value(
            value: bloc,
            child: MainScreen(
              pageController: PageController(),
              navFrameBuilder: fakeNavFrameBuilder,
            ),
          ),
        ),
      );

      expect(find.byType(MainBottomNavigation), findsOneWidget);
    });

    testWidgets("Navigate when tapping ", (widgetTester) async {
      final pageController = PageController();

      bloc.mockStream(MainState(bottomNavigationNavs: [
        NavMock.getDummy(screens: [FakeScreenEntry("")]),
        NavMock.getDummy(screens: [FakeScreenEntry("")]),
        NavMock.getDummy(screens: [FakeScreenEntry("")])
      ], selectedPage: BottomNavigationItem.home));

      await widgetTester.pumpWidget(
        TestWrapper(
          child: BlocProvider<MainBloc>.value(
            value: bloc,
            child: MainScreen(
              pageController: pageController,
              navFrameBuilder: fakeNavFrameBuilder,
            ),
          ),
        ),
      );

      await widgetTester.tap(find.text("Search"));
      await widgetTester.pumpAndSettle();

      expect(pageController.page, equals(BottomNavigationItem.search.index));
    });
  });

  testWidgets("when new state is emit, pagecontroller must have the same index as the state", (widgetTester) async {
    final stream = StreamController<MainState>();
    final pageController = PageController();
    var bloc = MockMainBloc.dummy(statesStream: stream.stream);
    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<MainBloc>.value(
          value: bloc,
          child: MainScreen(
            pageController: pageController,
            navFrameBuilder: fakeNavFrameBuilder,
          ),
        ),
      ),
    );

    stream.add(
      MainState(
        bottomNavigationNavs: [
          NavMock.getDummy(),
          NavMock.getDummy(),
        ],
        selectedPage: BottomNavigationItem.songbook,
      ),
    );

    await widgetTester.pumpAndSettle();

    expect(pageController.page, BottomNavigationItem.songbook.index);
    stream.close();
  });
}
