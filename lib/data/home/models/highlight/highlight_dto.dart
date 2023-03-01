import 'package:cifraclub/data/home/models/highlight/photos_dto.dart';
import 'package:cifraclub/domain/home/models/highlight.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'highlight_dto.g.dart';

@JsonSerializable(createToJson: false)
class HighlightDto extends Equatable {
  final String url;
  final String title;
  final String subtitle;
  final String? icon;
  final String description;
  @JsonKey(name: "alt")
  final String imageDescription;
  final PhotosDto photos;

  Highlight toDomain() => Highlight(
        url: url,
        title: title,
        subtitle: subtitle,
        icon: icon ?? "",
        description: description,
        contentDescription: imageDescription,
        images: photos.toDomain(),
      );

  factory HighlightDto.fromJson(Map<String, dynamic> json) => _$HighlightDtoFromJson(json);

  const HighlightDto({
    required this.url,
    required this.title,
    required this.subtitle,
    this.icon,
    required this.description,
    required this.imageDescription,
    required this.photos,
  });

  @override
  List<Object?> get props => [url, title, description];
}
