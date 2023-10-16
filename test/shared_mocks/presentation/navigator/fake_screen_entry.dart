import 'package:cifraclub/presentation/screens/main/bottom_navigation_tap_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nav/nav.dart';

class FakeScreenEntryTapHandler extends Fake implements ScreenEntry, BottomNavigationTapHandler {
  final VoidCallback onTapBottomNavigationItem;

  FakeScreenEntryTapHandler(this.onTapBottomNavigationItem);

  @override
  void onReselected(bool wasReselected) {
    onTapBottomNavigationItem.call();
  }
}

class FakeScreenEntry extends Fake implements ScreenEntry {
  final String fakeScreenName;

  FakeScreenEntry({required this.fakeScreenName});

  @override
  String get screenName => fakeScreenName;
}

class FakeEntryWithFooterModifier extends Fake implements ScreenEntry {
  final String fakeScreenName;

  FakeEntryWithFooterModifier(this.fakeScreenName);

  @override
  String get screenName => fakeScreenName;
}
