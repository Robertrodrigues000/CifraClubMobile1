// coverage:ignore-file
import 'package:cifraclub/domain/user/models/user_credential.dart';
import 'package:cifraclub/domain/user/repository/autentication_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class GetCredentialStream {
  final AuthenticationRepository authenticationRepository;

  const GetCredentialStream(this.authenticationRepository);

  BehaviorSubject<UserCredential> call() => authenticationRepository.credential;
}
