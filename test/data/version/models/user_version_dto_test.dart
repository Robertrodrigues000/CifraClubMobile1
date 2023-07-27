import 'package:cifraclub/data/version/models/user_version_artist_dto.dart';
import 'package:cifraclub/data/version/models/user_version_dto.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../shared_mocks/domain/artist/models/artist_mock.dart';

void main() {
  test("When `toDomain` is called should convert correctly to Version", () {
    final userVersionDto = UserVersionDto(
      id: 12,
      songUrl: "test",
      type: 4,
      name: "name",
      songId: 3,
      capo: 1,
      songbookId: 2,
      stdTone: "t",
      tone: "s",
      tuning: "abc",
      artistImage: "123",
      artist: UserVersionArtistDto(id: 1, name: "telo", color: "#FFFFFF", url: "https"),
      versionId: 10,
      order: 11,
    );
    final version = userVersionDto.toDomain();

    expect(version.remoteDatabaseID, 12);
    expect(version.capo, 1);
    expect(version.name, "name");
    expect(version.songId, 3);
    expect(version.songUrl, "test");
    expect(version.tone, "s");
    expect(version.stdTone, "t");
    expect(version.tuning, "abc");
    expect(version.type, 4);
    expect(version.artist.id, 1);
    expect(version.artist.name, "telo");
    expect(version.artist.url, "https");
    expect(version.artist.image!.color, "#FFFFFF");
    expect(version.artist.image!.size162, "123");
    expect(version.versionId, 10);
    expect(version.order, 11);
  });

  test("When `fromDomain` is called should convert correctly to VersionDto", () {
    final artist = getFakeArtist();
    final version = Version(
        songId: 1,
        type: 2,
        name: "name",
        songUrl: "songUrl",
        capo: 3,
        stdTone: "A",
        tone: "B",
        tuning: "AB",
        artist: artist,
        remoteDatabaseID: 5,
        versionId: 12,
        order: 10);
    final userVersionDto = UserVersionDto.fromDomain(version, 10);

    expect(userVersionDto.id, version.remoteDatabaseID);
    expect(userVersionDto.versionId, 12);
    expect(userVersionDto.name, "name");
    expect(userVersionDto.songUrl, "songUrl");
    expect(userVersionDto.tone, "B");
    expect(userVersionDto.type, 2);
    expect(userVersionDto.songId, 1);
    expect(userVersionDto.stdTone, "A");
    expect(userVersionDto.capo, 3);
    expect(userVersionDto.tuning, "AB");
    expect(userVersionDto.songbookId, 10);
    expect(userVersionDto.artist.id, artist.id);
    expect(userVersionDto.artist.name, artist.name);
    expect(userVersionDto.artist.url, artist.url);
    expect(userVersionDto.artist.color, artist.image?.color);
    expect(userVersionDto.artistImage, artist.image?.size162);
    expect(userVersionDto.order, 10);
  });
}
