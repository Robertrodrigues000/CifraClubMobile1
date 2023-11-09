import 'package:cifraclub/domain/user/use_cases/get_credential.dart';
import 'package:cifraclub/domain/user/use_cases/open_login_page.dart';
import 'package:injectable/injectable.dart';

@injectable
class RunIfUserIsLoggedIn {
  final GetCredential getCredential;
  final OpenLoginPage openLoginPage;

  const RunIfUserIsLoggedIn(this.getCredential, this.openLoginPage);

  // TODO: option to run `bloc` after the login result. This is not possible now since CCID doesn't a callback
  // Waiting for CCID 2
  T call<T>(T Function() block, {bool openLoginIfUserNotLoggedIn = false, required T onFail}) {
    final credential = getCredential();

    if (credential?.isUserLoggedIn == true) {
      return block();
    } else if (openLoginIfUserNotLoggedIn) {
      openLoginPage();
    }
    return onFail;
  }
}
