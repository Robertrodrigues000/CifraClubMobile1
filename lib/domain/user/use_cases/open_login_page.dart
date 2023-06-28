// coverage:ignore-file
import 'package:cifraclub/domain/user/repository/authentication_repository.dart';
import 'package:injectable/injectable.dart';

/// Action wil be ignored if user is already logged in.
@injectable
class OpenLoginPage {
  final AuthenticationRepository authenticationRepository;

  const OpenLoginPage(this.authenticationRepository);

  void call() {
    authenticationRepository.openLoginView();
  }
}
