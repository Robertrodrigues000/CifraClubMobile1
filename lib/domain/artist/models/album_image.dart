import 'package:equatable/equatable.dart';

class AlbumImage extends Equatable {
  final String? color;
  final int height;
  final int width;
  final String image;
  final String? imageHq;
  final String thumb;

  const AlbumImage(
      {this.color, required this.height, required this.width, required this.image, this.imageHq, required this.thumb});

  // coverage:ignore-start
  @override
  List<Object?> get props => [color, height, width, image, thumb, imageHq];
  // coverage:ignore-end
}
