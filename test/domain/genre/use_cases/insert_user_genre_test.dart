import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:cifraclub/domain/genre/use_cases/get_user_genres_as_stream.dart';
import 'package:cifraclub/domain/genre/use_cases/insert_user_genre.dart';
import 'package:cifraclub/domain/genre/use_cases/set_user_genre.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/domain/genre/models/genre_mock.dart';

class _GetUserGenreAsStreamMock extends Mock implements GetUserGenresAsStream {}

class _SetUserGenresMock extends Mock implements SetUserGenres {}

void main() {
  group("When use case is called", () {
    test("when genre do not exists should insert in the user list", () async {
      final getUserGenresAsStream = _GetUserGenreAsStreamMock();
      final setUserGenres = _SetUserGenresMock();

      final genres = [getFakeGenre(), getFakeGenre()];
      final genre = getFakeGenre();
      when(getUserGenresAsStream).thenAnswer((_) => Stream.value(genres));
      when(() => setUserGenres(captureAny())).thenAnswer((_) => SynchronousFuture(null));

      final insertUserGenreUseCase =
          InsertUserGenre(getUserGenresAsStream: getUserGenresAsStream, setUserGenres: setUserGenres);

      await insertUserGenreUseCase(genre);

      final insertedGenres = verify(() => setUserGenres(captureAny())).captured.first as List<Genre>;
      expect(insertedGenres, [genre, ...genres]);
    });

    test("when genre already exists should move to first position", () async {
      final getUserGenresAsStream = _GetUserGenreAsStreamMock();
      final setUserGenres = _SetUserGenresMock();
      final genre = getFakeGenre();
      final genres = [getFakeGenre(), genre];
      when(getUserGenresAsStream).thenAnswer((_) => Stream.value(genres));
      when(() => setUserGenres(captureAny())).thenAnswer((_) => SynchronousFuture(null));

      final insertUserGenreUseCase =
          InsertUserGenre(getUserGenresAsStream: getUserGenresAsStream, setUserGenres: setUserGenres);

      await insertUserGenreUseCase(genre);

      final insertedGenres = verify(() => setUserGenres(captureAny())).captured.first as List<Genre>;
      expect(insertedGenres.first, genre);
      expect(insertedGenres.last, genres.first);
    });

    test("when user already has 5 genres, the last should be dropped", () async {
      final getUserGenresAsStream = _GetUserGenreAsStreamMock();
      final setUserGenres = _SetUserGenresMock();
      final genre = getFakeGenre();
      final genres = [getFakeGenre(), getFakeGenre(), getFakeGenre(), getFakeGenre(), getFakeGenre()];
      when(getUserGenresAsStream).thenAnswer((_) => Stream.value(genres));
      when(() => setUserGenres(captureAny())).thenAnswer((_) => SynchronousFuture(null));

      final insertUserGenreUseCase =
          InsertUserGenre(getUserGenresAsStream: getUserGenresAsStream, setUserGenres: setUserGenres);

      await insertUserGenreUseCase(genre);

      final insertedGenres = verify(() => setUserGenres(captureAny())).captured.first as List<Genre>;
      expect(insertedGenres, [genre, ...genres.getRange(0, 4)]);
    });
  });
}
