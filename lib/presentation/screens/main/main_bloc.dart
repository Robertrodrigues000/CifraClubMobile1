import 'package:cifraclub/presentation/screens/main/bottom_navigation_item.dart';
import 'package:cifraclub/presentation/screens/main/main_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

class MainBloc extends Cubit<MainState> {
  final List<Nav> _navs;
  final RestorableBottomNavigationItem _selectedItem;

  MainBloc(this._navs, this._selectedItem)
      : super(
          MainState(
            selectedPage: _selectedItem.value,
            bottomNavigationNavs: _navs,
          ),
        ) {
    _pushToNavigatedItems(_selectedItem.value);
  }

  final List<BottomNavigationItem> navigatedItems = [];

  void _pushToNavigatedItems(BottomNavigationItem item) {
    navigatedItems.remove(item); // do not add duplicated items
    navigatedItems.add(item);
  }

  Future<bool> onWillPop() {
    var state = this.state;

    if (_navs[state.selectedPage.index].canPop) {
      _navs[state.selectedPage.index].pop();
      return SynchronousFuture(false);
    } else {
      if (navigatedItems.contains(BottomNavigationItem.home) && navigatedItems.length > 1) {
        navigatedItems.removeWhere((item) => item != BottomNavigationItem.home);
        setSelectedItem(navigatedItems.first, true);
        return SynchronousFuture(false);
      } else {
        return SynchronousFuture(true);
      }
    }
  }

  void setSelectedItem(BottomNavigationItem selectedItem, [bool isPopping = false]) {
    if (_selectedItem.value == selectedItem) {
      final navigator = _navs[selectedItem.index];
      navigator.popUntil(navigator.screens.first.screenName);
    }

    _selectedItem.value = selectedItem;
    if (!isPopping) {
      _pushToNavigatedItems(selectedItem);
    }

    emit(
      MainState(
        bottomNavigationNavs: state.bottomNavigationNavs,
        selectedPage: selectedItem,
      ),
    );
  }
}
