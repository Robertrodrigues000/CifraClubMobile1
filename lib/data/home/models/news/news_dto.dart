import 'package:cifraclub/data/home/models/highlight/photo_dto.dart';
import 'package:cifraclub/domain/home/models/news.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news_dto.g.dart';

@JsonSerializable(createToJson: false)
class NewsDto extends Equatable {
  final String url;
  final String image;
  final PhotoDto? thumb;
  final String headline;
  final String publishDate;

  News toDomain() => News(
        url: url,
        image: image,
        thumb: thumb?.toDomain(),
        headline: headline,
        publishDate: publishDate,
      );

  factory NewsDto.fromJson(Map<String, dynamic> json) => _$NewsDtoFromJson(json);

  const NewsDto({
    required this.url,
    required this.image,
    required this.thumb,
    required this.headline,
    required this.publishDate,
  });

  @override
  List<Object?> get props => [url, image, headline, publishDate];
}
