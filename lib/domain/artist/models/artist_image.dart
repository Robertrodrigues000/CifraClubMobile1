import 'package:equatable/equatable.dart';

class ArtistImage extends Equatable {
  final String? size50;
  final String? size162;
  final String? size250;
  final String? color;

  const ArtistImage({
    required this.size50,
    required this.size162,
    required this.size250,
    required this.color,
  });

  @override
  List<Object?> get props => [size162, size250, size50, color];
}
