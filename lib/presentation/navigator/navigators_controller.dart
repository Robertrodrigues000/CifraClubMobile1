import 'package:cifraclub/presentation/navigator/use_case/set_screen_from_url.dart';
import 'package:cifraclub/presentation/screens/academy/academy_entry.dart';
import 'package:cifraclub/presentation/screens/home/home_entry.dart';
import 'package:cifraclub/presentation/screens/main/bottom_navigation_item.dart';
import 'package:cifraclub/presentation/screens/main/bottom_navigation_tap_handler.dart';
import 'package:cifraclub/presentation/screens/more/more_entry.dart';
import 'package:cifraclub/presentation/screens/search/search_entry.dart';
import 'package:cifraclub/presentation/screens/songbook/songbook_entry.dart';
import 'package:flutter/foundation.dart';
import 'package:nav/nav.dart';

class NavigatorsController {
  // saves witch page is selected in the bottom navigation
  final RestorableBottomNavigationItem restorableBottomNavigationIndex;
  final OnNewScreenSet onNewScreenSet;
  final List<Nav> navs;

  BottomNavigationItem get currentBottomNavigationScreen => restorableBottomNavigationIndex.value;

  @visibleForTesting
  // saves each bottom navigator button that was selected by the user to be properly restored on back press
  final List<BottomNavigationItem> navigatedItems = [];

  NavigatorsController({
    required this.onNewScreenSet,
    required this.navs,
    required this.restorableBottomNavigationIndex,
  });

  // coverage:ignore-start
  ScreenEntry? get currentScreen => navs[restorableBottomNavigationIndex.value.index].screens.lastOrNull;
  // coverage:ignore-end

  void init() {
    _listenToDeepLinks();
  }

  Future<void> _listenToDeepLinks() async {
    onNewScreenSet().listen((screens) {
      switch (screens.first.screenName) {
        case HomeEntry.name:
          setSelectedItem(BottomNavigationItem.home);
          navs[0].setNewState([...navs[0].screens, screens.last]);
          break;
        case SongbookEntry.name:
          setSelectedItem(BottomNavigationItem.songbook);
          navs[1].setNewState([...navs[1].screens, screens.last]);
          break;
        case SearchEntry.name:
          setSelectedItem(BottomNavigationItem.search);
          navs[2].setNewState([...navs[2].screens, screens.last]);
          break;
        case AcademyEntry.name:
          setSelectedItem(BottomNavigationItem.academy);
          navs[3].setNewState([...navs[3].screens, screens.last]);
          break;
        case MoreEntry.name:
          setSelectedItem(BottomNavigationItem.more);
          navs[4].setNewState([...navs[4].screens, screens.last]);
          break;
      }
    });
  }

  void setSelectedItem(BottomNavigationItem selectedItem, [bool isPopping = false]) {
    final navigator = navs[selectedItem.index];

    // If user is already at the first page of the selected item
    // We call handleTap from BottomNavigationTapHandler so it can do the necessary stuff
    // (It mainly resets the scrollController to the top)
    if (navigator.screens.length == 1) {
      final tapHandler = navigator.screens.first;
      if (tapHandler is BottomNavigationTapHandler) {
        (tapHandler as BottomNavigationTapHandler).onReselected(currentBottomNavigationScreen == selectedItem);
      }
    } else if (navigator.screens.length > 1 && currentBottomNavigationScreen == selectedItem) {
      navigator.popUntil(navigator.screens.first.screenName);
    }
    restorableBottomNavigationIndex.value = selectedItem;

    if (!isPopping) {
      _pushToNavigatedItems(selectedItem);
    }
  }

  void _pushToNavigatedItems(BottomNavigationItem item) {
    navigatedItems.remove(item); // do not add duplicated items
    navigatedItems.add(item);
  }

  Future<bool> onWillPop() async {
    final index = currentBottomNavigationScreen.index;
    final currentNav = navs[index]; // current navigator on screen
    if (currentNav.canPop) {
      navs[index].onBackButtonPressed();
      return SynchronousFuture(false);
    } else {
      if (navigatedItems.length > 1) {
        navigatedItems.removeLast(); // remove the current page
        setSelectedItem(navigatedItems.last, true); // set the previous page
        return SynchronousFuture(false);
      } else {
        return SynchronousFuture(true); // nowhere to go. App will close
      }
    }
  }

  void addNavListener(VoidCallback listener) {
    for (var nav in navs) {
      nav.addListener(listener);
    }
  }
}
