import 'package:cifraclub/data/songbook/models/songbook_cifra_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("When toDomain is called, should return correct domain entity", () {
    final songbookCifraDto = SongbookCifraDto(
      id: 42,
      name: "cifra name",
      type: 1,
      songUrl: "cifra-name",
      tone: "F",
    );

    final cifra = songbookCifraDto.toDomain();

    expect(songbookCifraDto.id, cifra.id);
    expect(songbookCifraDto.name, cifra.name);
    expect(songbookCifraDto.type, cifra.type);
    expect(songbookCifraDto.tone, cifra.tone);
  });
}
