import 'package:cifraclub/domain/user/models/user_credential.dart';
import 'package:rxdart/rxdart.dart';

abstract class AuthenticationRepository {
  Future<bool> init();

  Future<void> openLoginView();

  Future<void> openUserProfilePage();

  BehaviorSubject<UserCredential> get credential;

  Future<void> addRegId(String token);

  Future<void> logout();
}
