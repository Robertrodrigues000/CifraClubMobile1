import 'package:cifraclub/domain/user/models/user_credential.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential.dart';
import 'package:cifraclub/domain/user/use_cases/open_login_page.dart';
import 'package:cifraclub/domain/user/use_cases/run_if_user_is_logged_in.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGetCredential extends Mock implements GetCredential {}

class _MockOpenLoginPage extends Mock implements OpenLoginPage {}

void main() {
  test("run bloc if user is logged in", () {
    final getCredential = _MockGetCredential();
    final openLoginPage = _MockOpenLoginPage();
    final useCase = RunIfUserIsLoggedIn(getCredential, openLoginPage);
    when(getCredential.call).thenReturn(const UserCredential(isUserLoggedIn: true));

    bool didRun = false;
    useCase(() => didRun = true, onFail: null);
    expect(didRun, isTrue);
  });
  group("When user is not logged in", () {
    test("do not run bloc", () {
      final getCredential = _MockGetCredential();
      final openLoginPage = _MockOpenLoginPage();
      final useCase = RunIfUserIsLoggedIn(getCredential, openLoginPage);
      when(getCredential.call).thenReturn(const UserCredential(isUserLoggedIn: false));

      bool didRun = false;
      useCase(() => didRun = true, onFail: null);
      expect(didRun, isFalse);
    });
    test("do not open login activity if not requested", () {
      final getCredential = _MockGetCredential();
      final openLoginPage = _MockOpenLoginPage();
      final useCase = RunIfUserIsLoggedIn(getCredential, openLoginPage);
      when(getCredential.call).thenReturn(const UserCredential(isUserLoggedIn: false));

      useCase(() {}, onFail: null);
      verifyNever(openLoginPage.call);
    });
    test("open login activity if requested", () {
      final getCredential = _MockGetCredential();
      final openLoginPage = _MockOpenLoginPage();
      final useCase = RunIfUserIsLoggedIn(getCredential, openLoginPage);
      when(getCredential.call).thenReturn(const UserCredential(isUserLoggedIn: false));

      useCase(() {}, onFail: null, openLoginIfUserNotLoggedIn: true);
      verify(openLoginPage.call).called(1);
    });
  });
}
