import 'package:cifraclub/data/search/models/search_result_dto.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_response_dto.g.dart';

@JsonSerializable(createToJson: false)
class SearchResponseDto extends Equatable {
  final SearchResultDto response;

  const SearchResponseDto({required this.response});

  factory SearchResponseDto.fromJson(Map<String, dynamic> json) => _$SearchResponseDtoFromJson(json);

  @override
  List<Object?> get props => [response];
}
