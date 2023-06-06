import 'package:cifraclub/domain/user/models/user.dart';
import 'package:equatable/equatable.dart';

class UserCredential extends Equatable {
  final bool isUserLoggedIn;
  final String? jwt;
  final User? user;

  const UserCredential({
    required this.isUserLoggedIn,
    this.jwt,
    this.user,
  });

  @override
  List<Object?> get props => [isUserLoggedIn, jwt, user];
}
