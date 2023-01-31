import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nav/nav.dart';

class FakeScreenEntryTapHandler extends Fake implements ScreenEntry {
  final VoidCallback onTapBottomNavigationItem;

  FakeScreenEntryTapHandler(this.onTapBottomNavigationItem);
}

class FakeScreenEntry extends Fake implements ScreenEntry {
  final String fakeScreenName;

  FakeScreenEntry(this.fakeScreenName);

  @override
  String get screenName => fakeScreenName;
}

class FakeEntryWithFooterModifier extends Fake implements ScreenEntry {
  final String fakeScreenName;

  FakeEntryWithFooterModifier(this.fakeScreenName);

  @override
  String get screenName => fakeScreenName;
}
