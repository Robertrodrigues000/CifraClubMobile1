import 'package:cifraclub/data/version/models/user_version/user_contributor_dto.dart';
import 'package:cifraclub/domain/version/models/contributor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("When call 'fromDomain'", () {
    final contributor = Contributor(
      name: "John Doe",
      id: 1,
      type: 1,
      avatar: "https://avatars.githubusercontent.com/u/12345678?v=4",
      url: "https://github.com/johndoe",
    );

    final userContributorDto = UserContributorDto.fromDomain(contributor);

    expect(userContributorDto.name, "John Doe");
    expect(userContributorDto.id, 1);
    expect(userContributorDto.type, 1);
    expect(userContributorDto.avatar, "https://avatars.githubusercontent.com/u/12345678?v=4");
    expect(userContributorDto.url, "https://github.com/johndoe");
  });
}
