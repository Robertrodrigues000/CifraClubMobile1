import 'package:cifraclub/presentation/navigator/app_navigator.dart';
import 'package:mocktail/mocktail.dart';

class AppNavigatorMock extends Mock implements AppNavigator {
  static AppNavigatorMock getDummy() {
    final mock = AppNavigatorMock();
    when(mock.canPop).thenReturn(true);
    return mock;
  }
}
