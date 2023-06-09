import 'package:cifraclub/domain/home/models/images_size.dart';
import 'package:equatable/equatable.dart';

class News extends Equatable {
  final String url;
  final String image;
  final ImagesSize? thumb;
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
