import 'package:cifraclub/data/genre/models/user_genre/user_genre_dto.dart';
import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("when `toDomain` is called, should correctly convert to Genre", () {
    final userGenreDto = UserGenreDto(name: "Rock", url: "rock");
    final genre = userGenreDto.toDomain();

    expect(genre.name, "Rock");
    expect(genre.url, "rock");
  });

  test("when `fromDomain` is called, should correctly convert to UserGenreDto", () {
    const genre = Genre(name: "Rock", url: "rock");
    final userGenreDto = UserGenreDto.fromDomain(genre);

    expect(userGenreDto.name, "Rock");
    expect(userGenreDto.url, "rock");
  });
}
