import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? name;
  final String? email;
  final String? avatarUrl;
  final String? city;
  final String? stateInitials;
  final String? state;
  final String? country;
  final int? id;

  const User({
    this.name,
    this.email,
    this.avatarUrl,
    this.city,
    this.state,
    this.stateInitials,
    this.country,
    this.id,
  });

  // coverage:ignore-start
  @override
  List<Object?> get props => [name, email, avatarUrl, city, stateInitials, state, country, id];
  // coverage:ignore-end
}
