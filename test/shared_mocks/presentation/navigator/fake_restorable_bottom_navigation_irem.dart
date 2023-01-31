import 'package:cifraclub/presentation/screens/main/bottom_navigation_item.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeRestorableBottomNavigationItem extends Fake implements RestorableBottomNavigationItem {
  FakeRestorableBottomNavigationItem({this.value = BottomNavigationItem.home});

  @override
  BottomNavigationItem value;
}
