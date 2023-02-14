import 'package:cifraclub/data/search/models/search_dto.dart';
import 'package:cifraclub/domain/search/models/all_search.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_list_dto.g.dart';

@JsonSerializable(createToJson: false)
class SearchListDto extends Equatable {
  final List<SearchDto>? docs;

  const SearchListDto({required this.docs});

  factory SearchListDto.fromJson(Map<String, dynamic> json) => _$SearchListDtoFromJson(json);

  AllSearch toDomain() {
    return AllSearch(search: docs?.map((search) => search.toDomain()).toList() ?? []);
  }

  @override
  List<Object?> get props => [docs];
}
