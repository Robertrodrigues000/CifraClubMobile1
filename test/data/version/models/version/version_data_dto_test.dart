import 'package:cifraclub/data/artist/models/artist_dto.dart';
import 'package:cifraclub/data/version/models/version/chord_dto.dart';
import 'package:cifraclub/data/version/models/version/contributor_dto.dart';
import 'package:cifraclub/data/version/models/version/version_data_dto.dart';
import 'package:cifraclub/data/version/models/version/version_data_song_dto.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("When `toDomain` is called should convert correctly", () {
    final versionDataDto = VersionDataDto(
      versionId: 1,
      type: 1,
      content: "content",
      label: "label",
      versionUrl: "versionUrl",
      completePath: "url",
      siteUrl: "siteUrl",
      key: "key",
      shapeKey: "shapeKey",
      stdKey: "stdKey",
      stdShapeKey: "stdShapeKey",
      tuning: "tuning",
      capo: 1,
      composers: "composers",
      isVerified: true,
      blocked: false,
      reason: "reason",
      chords: [ChordDto(name: "chord", shapeName: "alt")],
      song: VersionDataSongDto(songId: 1, lyricsId: 1, name: "name", url: "url", description: "description"),
      artist: const ArtistDto(url: "url", image: null, name: "name", id: 2),
      videoLesson: null,
      contributors: [ContributorDto(name: "name", id: 2, type: 3, url: "url")],
      instrumentVersions: [],
    );

    final version = versionDataDto.toDomain();

    expect(version.versionId, 1);
    expect(version.instrument, Instrument.guitar);
    expect(version.content, "content");
    expect(version.versionName, "label");
    expect(version.versionUrl, "versionUrl");
    expect(version.completePath, "url");
    expect(version.siteUrl, "siteUrl");
    expect(version.key, "key");
    expect(version.shapeKey, "shapeKey");
    expect(version.stdKey, "stdKey");
    expect(version.stdShapeKey, "stdShapeKey");
    expect(version.tuning, "tuning");
    expect(version.capo, 1);
    expect(version.composers, "composers");
    expect(version.isVerified, true);
    expect(version.blocked, false);
    expect(version.reason, "reason");
    expect(version.chords?.first.shapeName, "alt");
    expect(version.chords?.first.name, "chord");
    expect(version.song.songId, 1);
    expect(version.song.lyricsId, 1);
    expect(version.song.name, "name");
    expect(version.song.url, "url");
    expect(version.song.description, "description");
    expect(version.artist?.url, "url");
    expect(version.artist?.name, "name");
    expect(version.artist?.id, 2);
    expect(version.videoLesson, null);
    expect(version.contributors?.first.name, "name");
    expect(version.contributors?.first.id, 2);
    expect(version.contributors?.first.type, 3);
    expect(version.contributors?.first.url, "url");
    expect(version.instrumentVersions, []);
  });
}
