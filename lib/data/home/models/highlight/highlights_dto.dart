import 'package:cifraclub/data/home/models/highlight/highlight_dto.dart';
import 'package:cifraclub/domain/home/models/highlight.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'highlights_dto.g.dart';

@JsonSerializable(createToJson: false)
class HighlightsDto extends Equatable {
  final List<HighlightDto>? highlights;

  const HighlightsDto({required this.highlights});

  List<Highlight>? toDomain() => highlights?.map((e) => e.toDomain()).toList();

  factory HighlightsDto.fromJson(Map<String, dynamic> json) => _$HighlightsDtoFromJson(json);

  @override
  List<Object?> get props => [highlights];
}
