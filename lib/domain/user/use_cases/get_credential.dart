// coverage:ignore-file
import 'package:cifraclub/domain/user/models/user_credential.dart';
import 'package:cifraclub/domain/user/repository/autentication_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCredential {
  final AuthenticationRepository authenticationRepository;

  const GetCredential(this.authenticationRepository);

  UserCredential? call() => authenticationRepository.credential.valueOrNull;
}
