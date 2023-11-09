import 'package:cifraclub/domain/user/use_cases/run_if_user_is_logged_in.dart';
import 'package:mocktail/mocktail.dart';

class RunIfUserIsLoggedInMock extends Mock implements RunIfUserIsLoggedIn {
  static RunIfUserIsLoggedInMock getDummy() => _DummyRunIfUserIsLoggedInMock();
}

class _DummyRunIfUserIsLoggedInMock extends Mock implements RunIfUserIsLoggedInMock {
  @override
  T call<T>(T Function() block, {bool openLoginIfUserNotLoggedIn = false, required T onFail}) => block();
}
