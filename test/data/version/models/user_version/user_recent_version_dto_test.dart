import 'package:cifraclub/data/version/models/user_version/user_recent_version_dto.dart';
import 'package:cifraclub/data/version/models/user_version/user_version_artist_dto.dart';
import 'package:cifraclub/domain/version/models/capo.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/domain/version/models/tuning.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../shared_mocks/domain/artist/models/artist_mock.dart';

void main() {
  test("When `toDomain` is called should convert correctly to Version", () {
    final userVersionDto = UserRecentVersionDto(
        localDatabaseId: 10,
        songUrl: "test",
        instrument: Instrument.bass,
        name: "name",
        songId: 3,
        capo: 1,
        stdKey: "t",
        key: "s",
        tuning: Tuning.defaultTuning.value,
        artistImage: "123",
        artist: UserVersionArtistDto(id: 1, name: "telo", color: "#FFFFFF", url: "https"),
        versionId: 10,
        lastUpdate: DateTime.now());
    final version = userVersionDto.toDomain();

    expect(version.remoteDatabaseId, null);
    expect(version.localDatabaseId, 10);
    expect(version.capo, Capo.capo1);
    expect(version.name, "name");
    expect(version.songId, 3);
    expect(version.songUrl, "test");
    expect(version.key, "s");
    expect(version.stdKey, "t");
    expect(version.tuning, Tuning.defaultTuning);
    expect(version.instrument, Instrument.bass);
    expect(version.artist.id, 1);
    expect(version.artist.name, "telo");
    expect(version.artist.url, "https");
    expect(version.artist.image!.color, "#FFFFFF");
    expect(version.artist.image!.size162, "123");
    expect(version.versionId, 10);
  });

  test("When `fromDomain` is called should convert correctly to VersionDto", () {
    final artist = getFakeArtist();
    final version = Version(
      remoteDatabaseId: 5,
      localDatabaseId: 10,
      songId: 1,
      instrument: Instrument.bass,
      name: "name",
      songUrl: "songUrl",
      capo: Capo.capo1,
      stdKey: "A",
      key: "B",
      tuning: Tuning.c,
      artist: artist,
      versionId: 12,
      order: 0,
    );
    final userVersionDto = UserRecentVersionDto.fromDomain(version);

    expect(userVersionDto.localDatabaseId, version.localDatabaseId);
    expect(userVersionDto.versionId, 12);
    expect(userVersionDto.name, "name");
    expect(userVersionDto.songUrl, "songUrl");
    expect(userVersionDto.key, "B");
    expect(userVersionDto.instrument, Instrument.bass);
    expect(userVersionDto.songId, 1);
    expect(userVersionDto.stdKey, "A");
    expect(userVersionDto.tuning, Tuning.c.value);
    expect(userVersionDto.capo, Capo.capo1.capoId);
    expect(userVersionDto.artist.id, artist.id);
    expect(userVersionDto.artist.name, artist.name);
    expect(userVersionDto.artist.url, artist.url);
    expect(userVersionDto.artist.color, artist.image?.color);
    expect(userVersionDto.artistImage, artist.image?.size162);
  });
}
