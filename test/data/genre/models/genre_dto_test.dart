import 'package:cifraclub/data/genre/models/genre_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("when `toDomain` is called, should correctly convert to Genre", () {
    const genreDto = GenreDto(
      name: "Gospel/Religioso",
      url: "gospelreligioso",
    );
    final genre = genreDto.toDomain();

    expect(genre.name, genreDto.name);
    expect(genre.url, genreDto.url);
  });
}
