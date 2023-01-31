import 'package:cifraclub/presentation/screens/main/bottom_navigation_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("when 'createDefaultValue' is called, return `home`", () {
    expect(RestorableBottomNavigationItem().createDefaultValue(), BottomNavigationItem.home);
  });

  test("when 'fromPrimitives' is called, parse the object as a int and return BottomNavigationItem indexed item", () {
    int position = 1;
    expect(RestorableBottomNavigationItem().fromPrimitives(position), BottomNavigationItem.values[position]);
  });

  test("When item is updated, notify Listeners", () {
    final item = RestorableBottomNavigationItem();
    var itemUpdated = false;
    item.addListener(() {
      itemUpdated = true;
    });

    item.didUpdateValue(BottomNavigationItem.dev);

    expect(itemUpdated, isTrue);
  });
}
