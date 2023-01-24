import 'package:cifraclub/data/genre/models/genre_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("when `toDomain` is called, should correctly convert to Genre", () async {
    const genreDto = GenreDto(
      id: 30,
      name: "Gospel/Religioso",
      url: "gospelreligioso",
    );
    final genre = genreDto.toDomain();

    expect(genre.id, genreDto.id);
    expect(genre.name, genreDto.name);
    expect(genre.url, genreDto.url);
  });
}
