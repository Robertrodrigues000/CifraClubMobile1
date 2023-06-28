import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:cifraclub/domain/songbook/use_cases/validate_songbook_name.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/subjects.dart';

import '../../../shared_mocks/domain/songbook/models/songbook_mock.dart';

class _UserSongbookRepositoryMock extends Mock implements UserSongbookRepository {}

void main() {
  group("When ValidateSongbookName is called", () {
    final userSongbookRepository = _UserSongbookRepositoryMock();
    final songbook = getFakeSongbook();

    when(userSongbookRepository.getAllUserSongbooks)
        .thenAnswer((invocation) => BehaviorSubject.seeded([getFakeSongbook(name: "New Songbook"), songbook]));

    final validateSongbookNameUseCase = ValidateSongbookName(userSongbookRepository);

    test("and input have on songbook list should return existingName", () async {
      final result = await validateSongbookNameUseCase(songbook.name);

      expect(result, SongbookNameValidation.existingName);
    });

    test("and the name passed exists and have blank spaces", () async {
      final result = await validateSongbookNameUseCase("  New Songbook  ");

      expect(result, SongbookNameValidation.existingName);
    });

    test("and the name passed exists and have blank space in final of string", () async {
      final result = await validateSongbookNameUseCase("New Songbook  ");

      expect(result, SongbookNameValidation.existingName);
    });

    test("and the name passed exists and have blank spaces in start of string", () async {
      final result = await validateSongbookNameUseCase("  New Songbook");

      expect(result, SongbookNameValidation.existingName);
    });

    test("and the name passed exists and have different cases", () async {
      final result = await validateSongbookNameUseCase("NEW SONGBOOK");

      expect(result, SongbookNameValidation.existingName);
    });

    test("and input is valid input should return validInput", () async {
      final result = await validateSongbookNameUseCase("Novo songbook");

      expect(result, SongbookNameValidation.validInput);
    });
  });
}
