// coverage:ignore-file
import 'package:cifraclub/domain/user/repository/authentication_repository.dart';
import 'package:injectable/injectable.dart';

/// Action wil be ignored if user is not logged in.
@injectable
class OpenUserProfilePage {
  final AuthenticationRepository authenticationRepository;

  const OpenUserProfilePage(this.authenticationRepository);

  void call() => authenticationRepository.openUserProfilePage();
}
