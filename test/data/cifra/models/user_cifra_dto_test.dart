import 'package:cifraclub/data/cifra/models/user_cifra_artist_dto.dart';
import 'package:cifraclub/data/cifra/models/user_cifra_dto.dart';
import 'package:cifraclub/domain/cifra/models/cifra.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';

import '../../../shared_mocks/domain/artist/models/artist_mock.dart';

void main() {
  test("When `toDomain` is called should convert correctly to cifra", () {
    final userCifraDto = UserCifraDto(
      remoteDatabaseID: 0,
      songUrl: "test",
      type: 4,
      name: "name",
      localDatabaseID: 12,
      songId: 3,
      capo: 1,
      songbookId: 2,
      stdTone: "t",
      tone: "s",
      tuning: "abc",
      artistImage: "123",
      artist: UserCifraArtistDto(id: 1, name: "telo", color: "#FFFFFF", url: "https"),
      versionId: 10,
    );
    final cifra = userCifraDto.toDomain();

    expect(cifra.localDatabaseID, 12);
    expect(cifra.capo, 1);
    expect(cifra.name, "name");
    expect(cifra.songId, 3);
    expect(cifra.songUrl, "test");
    expect(cifra.tone, "s");
    expect(cifra.stdTone, "t");
    expect(cifra.tuning, "abc");
    expect(cifra.type, 4);
    expect(cifra.artist.id, 1);
    expect(cifra.artist.name, "telo");
    expect(cifra.artist.url, "https");
    expect(cifra.artist.image!.color, "#FFFFFF");
    expect(cifra.artist.image!.size162, "123");
    expect(cifra.versionId, 10);
  });

  test("When `fromDomain` is called should convert correctly to cifraDto", () {
    final artist = getFakeArtist();
    final cifra = Cifra(
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
    );
    final userCifraDto = UserCifraDto.fromDomain(cifra, 10);

    expect(userCifraDto.localDatabaseID, Isar.autoIncrement);
    expect(userCifraDto.versionId, 12);
    expect(userCifraDto.name, "name");
    expect(userCifraDto.remoteDatabaseID, 5);
    expect(userCifraDto.songUrl, "songUrl");
    expect(userCifraDto.tone, "B");
    expect(userCifraDto.type, 2);
    expect(userCifraDto.songId, 1);
    expect(userCifraDto.stdTone, "A");
    expect(userCifraDto.capo, 3);
    expect(userCifraDto.tuning, "AB");
    expect(userCifraDto.songbookId, 10);
    expect(userCifraDto.artist.id, artist.id);
    expect(userCifraDto.artist.name, artist.name);
    expect(userCifraDto.artist.url, artist.url);
    expect(userCifraDto.artist.color, artist.image?.color);
    expect(userCifraDto.artistImage, artist.image?.size162);
  });
}
