import 'package:equatable/equatable.dart';

class HomeImage extends Equatable {
  final String small;
  final String medium;
  final String? large;

  const HomeImage({
    required this.small,
    required this.medium,
    this.large,
  });

  // coverage:ignore-start
  @override
  List<Object?> get props => [small, medium, large];
  // coverage:ignore-end
}
