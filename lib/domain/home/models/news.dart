import 'package:cifraclub/domain/home/models/home_image.dart';
import 'package:equatable/equatable.dart';

class News extends Equatable {
  final String url;
  final String image;
  final HomeImage? thumb;
  final String headline;
  final String publishDate;

  const News({
    required this.url,
    required this.image,
    required this.thumb,
    required this.headline,
    required this.publishDate,
  });

  // coverage:ignore-start
  @override
  List<Object?> get props => [url, image, headline, publishDate];
  // coverage:ignore-end
}
