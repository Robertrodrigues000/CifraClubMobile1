// coverage:ignore-file
import 'package:cifraclub/domain/user/repository/autentication_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class Logout {
  final AuthenticationRepository authenticationRepository;

  const Logout(this.authenticationRepository);

  Future<void> call() => authenticationRepository.logout();
}
