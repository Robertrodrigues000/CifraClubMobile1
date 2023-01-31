import 'package:flutter/foundation.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nav/nav.dart';

class NavMock extends Mock implements Nav {
  static NavMock get newInstance => NavMock();

  static NavMock getDummy({bool canPop = true, List<ScreenEntry> screens = const []}) {
    final mock = newInstance;
    when(() => mock.canPop).thenReturn(canPop);
    when(() => mock.screens).thenReturn(screens);
    when(
      () => mock.push(
        screenName: any(named: "screenName"),
        params: any(named: "params"),
        volatileParam: any(named: "volatileParam"),
      ),
    ).thenAnswer((invocation) => SynchronousFuture(null));
    return mock;
  }
}
