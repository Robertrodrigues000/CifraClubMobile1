import 'package:cifraclub/domain/version/models/contributor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contributor_dto.g.dart';

@JsonSerializable(createToJson: false)
class ContributorDto {
  final String name;
  final int id;
  final int type;
  final String? avatar;
  final String url;

  ContributorDto({
    required this.name,
    required this.id,
    required this.type,
    this.avatar,
    required this.url,
  });

  factory ContributorDto.fromJson(Map<String, dynamic> json) => _$ContributorDtoFromJson(json);

  Contributor toDomain() => Contributor(name: name, id: id, type: type, url: url);
}
