import 'package:flutter_test/flutter_test.dart';

// ignore: camel_case_types
typedef areListsEqual<T> = AreListsEqual<T>;

class AreListsEqual<T> extends Matcher {
  final List<T> list;
  final bool Function(T, T) isElementEqual;
  final dynamic Function(T)? describeElement;

  AreListsEqual({
    required this.list,
    required this.isElementEqual,
    this.describeElement,
  });

  @override
  Description describe(Description description) {
    return description.add("ListA and ListB must have the same elements");
  }

  @override
  bool matches(listA, Map matchState) {
    if (listA is! List<T> || listA.length != list.length) {
      return false;
    }

    for (int i = 0; i < listA.length; i++) {
      bool isEqual = isElementEqual(listA[i], list[i]);
      if (!isEqual) {
        return false;
      }
    }
    return true;
  }

  @override
  Description describeMismatch(
    dynamic listA,
    Description mismatchDescription,
    Map matchState,
    bool verbose,
  ) {
    final describeElement = this.describeElement ?? (T element) => element;

    if (listA is! List<T>) {
      return mismatchDescription.add("item is not List<$T>");
    }

    if (listA.length != list.length) {
      return mismatchDescription.add("lists have a different length");
    }

    mismatchDescription.add("Lists do not have the same elements \n");

    for (int i = 0; i < listA.length; i++) {
      mismatchDescription.add("$i:\t${describeElement(listA[i])} - ${describeElement(list[i])} \n");
    }

    return mismatchDescription;
  }
}
