import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/presentation/screens/main/bottom_navigation_item.dart';
import 'package:cifraclub/presentation/screens/main/main_bloc.dart';
import 'package:cifraclub/presentation/screens/main/main_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nav/nav.dart';

import '../../../shared_mocks/presentation/navigator/fake_restorable_bottom_navigation_irem.dart';
import '../../../shared_mocks/presentation/navigator/fake_screen_entry.dart';
import '../../../shared_mocks/presentation/navigator/nav_mock.dart';

void main() {
  MainBloc getBloc({
    List<Nav>? navs,
    RestorableBottomNavigationItem? selectedScreen,
  }) =>
      MainBloc(
          navs ??
              [
                NavMock.getDummy(screens: [FakeScreenEntry("")]),
                NavMock.getDummy(screens: [FakeScreenEntry("")]),
                NavMock.getDummy(screens: [FakeScreenEntry("")]),
              ],
          selectedScreen ?? FakeRestorableBottomNavigationItem());

  test("When bloc is created, expect state to be at initial state", () {
    final bloc = MainBloc([], FakeRestorableBottomNavigationItem());
    expect(bloc.state, isA<MainInitialState>());
  });

  group("When verify can pop", () {
    test(
      "return true if MainScreenNavigatorController can not pop and there is no previous page to go back",
      () async {
        final controllers = [NavMock.getDummy(canPop: false), NavMock.getDummy(), NavMock.getDummy()];
        final bloc = getBloc(navs: controllers);

        expect(await bloc.onWillPop(), true);
      },
    );

    test(
      "return false if MainScreenNavigatorController can pop",
      () async {
        final bloc = getBloc();

        expect(await bloc.onWillPop(), false);
      },
    );

    test(
      "return false and pop to home if BottomNavigationItem.home exists in navigatedItems",
      () async {
        final bloc =
            getBloc(navs: [NavMock.getDummy(), NavMock.getDummy(canPop: false), NavMock.getDummy(canPop: false)]);

        bloc.setSelectedItem(BottomNavigationItem.songbook);
        bloc.setSelectedItem(BottomNavigationItem.search);
        var result = await bloc.onWillPop();

        expect(result, false);
        expect(bloc.state, isA<MainInitialState>());
        expect((bloc.state as MainInitialState).selectedPage, BottomNavigationItem.home);
      },
    );
  });

  group("When setSelectedState", () {
    blocTest<MainBloc, MainState>(
      "change selected state",
      build: getBloc,
      act: (bloc) => bloc.setSelectedItem(BottomNavigationItem.songbook),
      expect: () => [
        predicate(
          (state) => state is MainInitialState && state.selectedPage == BottomNavigationItem.songbook,
        ),
      ],
    );

    test("expect popUntil called with correct parameter", () async {
      final List<Nav> controllers = [
        NavMock.getDummy(screens: [FakeScreenEntry("Screen1"), FakeScreenEntry("Screen2")]),
        NavMock.getDummy(screens: [FakeScreenEntry("")]),
      ];
      var bloc = getBloc(navs: controllers);

      bloc.setSelectedItem(BottomNavigationItem.home);
      verify(() => controllers[BottomNavigationItem.home.index].popUntil("Screen1")).called(1);
    });
  });
}
