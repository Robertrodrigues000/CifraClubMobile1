import 'package:flutter/material.dart';

enum BottomNavigationItem { home, songbook, search, academy, more }

class RestorableBottomNavigationItem extends RestorableValue<BottomNavigationItem> {
  @override
  BottomNavigationItem createDefaultValue() {
    return BottomNavigationItem.home;
  }

  @override
  BottomNavigationItem fromPrimitives(Object? data) {
    return BottomNavigationItem.values[data as int];
  }

  @override
  Object? toPrimitives() {
    // no way to test this one =(. Value can only be accessed when
    // this RestorableValue is registered in a scope.
    return value.index;
  }

  @override
  void didUpdateValue(BottomNavigationItem? oldValue) {
    notifyListeners();
  }
}
