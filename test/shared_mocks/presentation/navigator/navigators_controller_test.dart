import 'dart:async';

import 'package:cifraclub/presentation/navigator/navigators_controller.dart';
import 'package:cifraclub/presentation/navigator/use_case/set_screen_from_url.dart';
import 'package:cifraclub/presentation/screens/main/bottom_navigation_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nav/nav.dart';

import 'fake_screen_entry.dart';
import 'nav_mock.dart';

class _OnNewScreenSetMock extends Mock implements OnNewScreenSet {}

class _FakeRestorableBottomNavigationItem extends Fake implements RestorableBottomNavigationItem {
  _FakeRestorableBottomNavigationItem({this.value = BottomNavigationItem.home});

  @override
  BottomNavigationItem value;
}

void main() {
  List<Nav> getNavs({required ScreenEntry entry, bool canPop = true, required int index}) {
    return List.generate(5, (i) {
      if (i == index) {
        return NavMock.getDummy(screens: [entry], canPop: canPop);
      }
      return NavMock.getDummy(screens: [FakeScreenEntry(fakeScreenName: '${i + 1}')]);
    });
  }

  NavigatorsController getController({
    OnNewScreenSet? onNewScreenSet,
    List<Nav>? navs,
    RestorableBottomNavigationItem? restorableBottomNavigationItem,
  }) {
    final restorable = restorableBottomNavigationItem ?? _FakeRestorableBottomNavigationItem();

    return NavigatorsController(
      onNewScreenSet: onNewScreenSet ?? _OnNewScreenSetMock(),
      navs: navs ?? [],
      restorableBottomNavigationIndex: restorable,
    );
  }

  test("when setSelectedItem is invoked, expect change BottomNavigationItem", () {
    final songbookEntry = FakeScreenEntry(fakeScreenName: 'songbook');
    final navs = getNavs(entry: songbookEntry, index: 2);
    final restorable = _FakeRestorableBottomNavigationItem();
    final controller = getController(navs: navs, restorableBottomNavigationItem: restorable);

    controller.setSelectedItem(BottomNavigationItem.songbook);

    expect(restorable.value, BottomNavigationItem.songbook);
  });

  test("when onWillPop is invoked with entry canPop=false, expect return true", () async {
    final homeEntry = FakeScreenEntry(
      fakeScreenName: 'songbook',
    );
    final navs = getNavs(entry: homeEntry, canPop: false, index: 1);
    final restorable = _FakeRestorableBottomNavigationItem();
    final controller = getController(navs: navs, restorableBottomNavigationItem: restorable);

    controller.setSelectedItem(BottomNavigationItem.songbook);
    final result = await controller.onWillPop();

    expect(result, isTrue);
  });

  test("when onWillPop is invoked with entry canPop=true, expect return false", () async {
    final homeEntry = FakeScreenEntry(fakeScreenName: 'home');
    final navs = getNavs(entry: homeEntry, index: 3);
    final restorable = _FakeRestorableBottomNavigationItem();
    final controller = getController(navs: navs, restorableBottomNavigationItem: restorable);

    final result = await controller.onWillPop();

    expect(result, isFalse);
  });

  group("When 'home' is selected", () {
    final homeEntry = FakeScreenEntry(fakeScreenName: 'home');
    final navs = getNavs(entry: homeEntry, index: 3);
    final StreamController<String?> deepLinkStream = StreamController.broadcast();

    tearDownAll(deepLinkStream.close);

    test("change 'selectedPage' state to 'Home'", () {
      final homeEntry = FakeScreenEntry(fakeScreenName: 'home');
      final navs = getNavs(entry: homeEntry, index: 3);
      final restorable = _FakeRestorableBottomNavigationItem();
      final controller = getController(navs: navs, restorableBottomNavigationItem: restorable);

      controller.setSelectedItem(BottomNavigationItem.home);

      expect(controller.currentBottomNavigationScreen, BottomNavigationItem.home);
    });

    test("add a `home` to navigatedItems if `isPopping` is false", () {
      final restorable = _FakeRestorableBottomNavigationItem();
      final controller = getController(navs: navs, restorableBottomNavigationItem: restorable);

      controller.setSelectedItem(BottomNavigationItem.home);

      expect(controller.navigatedItems, [BottomNavigationItem.home]);
    });

    test("do not add a `home` to navigatedItems if `isPopping` is true", () {
      final restorable = _FakeRestorableBottomNavigationItem();
      final controller = getController(navs: navs, restorableBottomNavigationItem: restorable);

      controller.setSelectedItem(BottomNavigationItem.home, true);

      expect(controller.navigatedItems, []);
    });

    test("and Home is already selected with navigator stack length = 1, expect handleTap from entry called", () {
      bool hasCalledHandleTap = false;
      final navs = [
        NavMock.getDummy(screens: [
          FakeScreenEntryTapHandler(
            () {
              hasCalledHandleTap = true;
            },
          ),
        ]),
      ];
      final restorable = _FakeRestorableBottomNavigationItem();
      final controller = getController(navs: navs, restorableBottomNavigationItem: restorable);

      controller.setSelectedItem(BottomNavigationItem.home);

      expect(hasCalledHandleTap, isTrue);
    });

    test("and Home is already selected with navigator stack length > 1, expect popUntil called with correct parameter",
        () {
      final navs = [
        NavMock.getDummy(screens: [
          FakeScreenEntry(fakeScreenName: "home"),
          FakeScreenEntry(fakeScreenName: "artist"),
        ]),
      ];
      final restorable = _FakeRestorableBottomNavigationItem(value: BottomNavigationItem.home);
      final controller = getController(navs: navs, restorableBottomNavigationItem: restorable);

      controller.setSelectedItem(BottomNavigationItem.home);

      verify(() => navs.last.popUntil("home")).called(1);
    });
  });

  group("`onWillPop` is called", () {
    final StreamController<String?> deepLinkStream = StreamController.broadcast();
    tearDown(deepLinkStream.close);

    test("pop the current navigator if MainScreenNavigatorController can pop", () async {
      final navs = [NavMock.getDummy(), NavMock.getDummy(canPop: true)];
      final restorable = _FakeRestorableBottomNavigationItem(value: BottomNavigationItem.songbook);
      final controller = getController(navs: navs, restorableBottomNavigationItem: restorable);

      await controller.onWillPop();
      verify(() => navs[1].onBackButtonPressed()).called(1);
    });

    test("return false if MainScreenNavigatorController can pop", () async {
      final navs = [NavMock.getDummy(), NavMock.getDummy(canPop: true)];
      final restorable = _FakeRestorableBottomNavigationItem();
      final controller = getController(navs: navs, restorableBottomNavigationItem: restorable);

      expect(await controller.onWillPop(), false);
    });

    test("navigate to the previous selected page if MainScreenNavigatorController can not pop", () async {
      final navs = [NavMock.getDummy(), NavMock.getDummy(canPop: false)];
      final restorable = _FakeRestorableBottomNavigationItem();
      final controller = getController(navs: navs, restorableBottomNavigationItem: restorable);

      controller.setSelectedItem(BottomNavigationItem.home);
      controller.setSelectedItem(BottomNavigationItem.songbook);

      await controller.onWillPop();
      verifyNever(() => navs[1].onBackButtonPressed());
      expect(controller.currentBottomNavigationScreen, BottomNavigationItem.home);
    });

    test("remove current item from `navigatedItems`  MainScreenNavigatorController can not pop", () async {
      final navs = [NavMock.getDummy(), NavMock.getDummy(canPop: false)];
      final restorable = _FakeRestorableBottomNavigationItem();
      final controller = getController(navs: navs, restorableBottomNavigationItem: restorable);

      controller.setSelectedItem(BottomNavigationItem.songbook);

      await controller.onWillPop();
      verifyNever(() => navs[1].onBackButtonPressed());
      expect(controller.navigatedItems.length, 1);
    });

    test("return true if MainScreenNavigatorController can not pop and there is no previous page to go back", () async {
      final navs = [NavMock.getDummy(canPop: false), NavMock.getDummy()];
      final restorable = _FakeRestorableBottomNavigationItem();
      final controller = getController(navs: navs, restorableBottomNavigationItem: restorable);

      expect(await controller.onWillPop(), true);
    });
  });

  group("on deeplink received ", () {
    final entry = FakeScreenEntry(fakeScreenName: "Home");
    final navs = [NavMock.getDummy(), NavMock.getDummy(), NavMock.getDummy(), NavMock.getDummy(), NavMock.getDummy()];
    test("navigate to home page", () async {
      final newScreenSet = _OnNewScreenSetMock();
      final streamController = StreamController<List<ScreenEntry>>(sync: true);

      when(newScreenSet).thenAnswer((_) => streamController.stream);

      final controller = getController(
        navs: navs,
        onNewScreenSet: newScreenSet,
      );

      controller.init();
      streamController.add([entry]);
      await streamController.close();

      expect(controller.currentBottomNavigationScreen, BottomNavigationItem.home);
      final newEntries = verify(() => navs[0].setNewState(captureAny())).captured.first as List<ScreenEntry>;
      expect(newEntries.last, same(entry));
    });

    test("if first entry is SongbookEntry setSelectedItem based on first screen entry and navigate to the correct page",
        () async {
      final newScreenSet = _OnNewScreenSetMock();
      final streamController = StreamController<List<ScreenEntry>>(sync: true);
      when(newScreenSet).thenAnswer((_) => streamController.stream);

      final controller = getController(
        navs: navs,
        onNewScreenSet: newScreenSet,
      );
      final songbookEntry = FakeScreenEntry(
        fakeScreenName: 'Songbook',
      );
      final versionsSharedEntry = FakeScreenEntry(
        fakeScreenName: 'VersionsShared',
      );

      controller.init();
      streamController.add([songbookEntry, versionsSharedEntry]);
      await streamController.close();

      expect(controller.currentBottomNavigationScreen, BottomNavigationItem.songbook);
      final newEntries = verify(() => navs[1].setNewState(captureAny())).captured.first as List<ScreenEntry>;
      expect(newEntries.last, same(versionsSharedEntry));
    });

    test("if first entry is Search setSelectedItem based on first screen entry and navigate to the correct page",
        () async {
      final newScreenSet = _OnNewScreenSetMock();
      final streamController = StreamController<List<ScreenEntry>>(sync: true);
      when(newScreenSet).thenAnswer((_) => streamController.stream);

      final controller = getController(
        navs: navs,
        onNewScreenSet: newScreenSet,
      );
      final searchEntry = FakeScreenEntry(
        fakeScreenName: 'Search',
      );

      controller.init();
      streamController.add([searchEntry]);
      await streamController.close();

      expect(controller.currentBottomNavigationScreen, BottomNavigationItem.search);
      final newEntries = verify(() => navs[2].setNewState(captureAny())).captured.first as List<ScreenEntry>;
      expect(newEntries.last, same(searchEntry));
    });

    test("if first entry is Academy setSelectedItem based on first screen entry and navigate to the correct page",
        () async {
      final newScreenSet = _OnNewScreenSetMock();
      final streamController = StreamController<List<ScreenEntry>>(sync: true);
      when(newScreenSet).thenAnswer((_) => streamController.stream);

      final controller = getController(
        navs: navs,
        onNewScreenSet: newScreenSet,
      );
      final academyEntry = FakeScreenEntry(
        fakeScreenName: 'Academy',
      );

      controller.init();
      streamController.add([academyEntry]);
      await streamController.close();

      expect(controller.currentBottomNavigationScreen, BottomNavigationItem.academy);
      final newEntries = verify(() => navs[3].setNewState(captureAny())).captured.first as List<ScreenEntry>;
      expect(newEntries.last, same(academyEntry));
    });

    test("if first entry is More setSelectedItem based on first screen entry and navigate to the correct page",
        () async {
      final newScreenSet = _OnNewScreenSetMock();
      final streamController = StreamController<List<ScreenEntry>>(sync: true);
      when(newScreenSet).thenAnswer((_) => streamController.stream);

      final controller = getController(
        navs: navs,
        onNewScreenSet: newScreenSet,
      );
      final moreEntry = FakeScreenEntry(
        fakeScreenName: 'More',
      );

      controller.init();
      streamController.add([moreEntry]);
      await streamController.close();

      expect(controller.currentBottomNavigationScreen, BottomNavigationItem.more);
      final newEntries = verify(() => navs[4].setNewState(captureAny())).captured.first as List<ScreenEntry>;
      expect(newEntries.last, same(moreEntry));
    });
  });

  test("when call addNavListener should add listener to navs", () {
    final navs = [
      NavMock.getDummy(screens: [
        FakeScreenEntry(fakeScreenName: "home"),
        FakeScreenEntry(fakeScreenName: "artist"),
      ]),
      NavMock.getDummy(screens: [
        FakeScreenEntry(fakeScreenName: "more"),
      ]),
    ];

    final controller = getController(navs: navs);

    controller.addNavListener(() {});

    verify(() => navs.last.addListener(any(that: const TypeMatcher<Function>()))).called(1);
    verify(() => navs.first.addListener(any(that: const TypeMatcher<Function>()))).called(1);
  });
}
