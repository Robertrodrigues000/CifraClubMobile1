// coverage:ignore-file
import 'package:cifraclub/data/user/repository/ccid.dart';
import 'package:cifraclub/domain/user/repository/autentication_repository.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AuthenticationModule {
  @singleton
  @preResolve
  Future<AuthenticationRepository> getAuthenticationRepository() async {
    final ccid = Ccid(Ccid.ccidChannel);
    return ccid;
  }
}
