import 'package:cifraclub/domain/user/models/user.dart';

class UserCredential {
  final bool isUserLoggedIn;
  final String? jwt;
  final User? user;

  const UserCredential({
    required this.isUserLoggedIn,
    this.jwt,
    this.user,
  });
}
