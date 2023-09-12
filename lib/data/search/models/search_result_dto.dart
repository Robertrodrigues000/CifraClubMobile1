import 'package:cifraclub/data/search/models/search_dto.dart';
import 'package:cifraclub/domain/search/models/search_models/search_item.dart';
import 'package:cifraclub/domain/search/models/search_result.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_result_dto.g.dart';

@JsonSerializable(createToJson: false)
class SearchResultDto extends Equatable {
  final List<SearchDto>? docs;

  const SearchResultDto({required this.docs});

  factory SearchResultDto.fromJson(Map<String, dynamic> json) => _$SearchResultDtoFromJson(json);

  SearchResult toDomain() {
    final results = docs?.map((search) => search.toDomain()).toList(growable: false) ?? [];
    return SearchResult(search: results.whereType<SearchItem>().toList(growable: false));
  }

  @override
  List<Object?> get props => [docs];
}
