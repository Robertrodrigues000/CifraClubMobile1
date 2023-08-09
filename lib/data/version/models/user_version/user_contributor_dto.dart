import 'package:cifraclub/domain/version/models/contributor.dart';
import 'package:isar/isar.dart';

part 'user_contributor_dto.g.dart';

@embedded
class UserContributorDto {
  late final String name;
  late final int id;
  late final int type;
  late final String? avatar;
  late final String url;

  UserContributorDto();

  UserContributorDto.fromDomain(Contributor contributor) {
    avatar = contributor.avatar;
    name = contributor.name;
    id = contributor.id;
    type = contributor.type;
    url = contributor.url;
  }
}
