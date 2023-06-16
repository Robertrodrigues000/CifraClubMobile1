import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:cifraclub/domain/songbook/use_cases/validate_songbook_name.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/subjects.dart';

import '../../../shared_mocks/domain/songbook/models/songbook_mock.dart';

class _UserSongbookRepository extends Mock implements UserSongbookRepository {}

void main() {
  group("When validateSongbookName is called", () {
    final userSongbookRepository = _UserSongbookRepository();
    final songbook = getFakeSongbook();

    when(userSongbookRepository.getAllUserSongbooks)
        .thenAnswer((invocation) => BehaviorSubject.seeded([getFakeSongbook(name: "New Songbook"), songbook]));

    final valiteSongbookNameUseCase = ValidateSongbookName(userSongbookRepository);

    test("and input have on songbook list should return existingName", () async {
      final result = await valiteSongbookNameUseCase(songbook.name);

      expect(result, SongbookNameValidation.existingName);
    });

    test("and the name passed exists and have blank spaces", () async {
      final result = await valiteSongbookNameUseCase("  New Songbook  ");

      expect(result, SongbookNameValidation.existingName);
    });

    test("and the name passed exists and have blank sapce in final of string", () async {
      final result = await valiteSongbookNameUseCase("New Songbook  ");

      expect(result, SongbookNameValidation.existingName);
    });

    test("and the name passed exists and have blank spaces in start of string", () async {
      final result = await valiteSongbookNameUseCase("  New Songbook");

      expect(result, SongbookNameValidation.existingName);
    });

    test("and the name passed exists and have different cases", () async {
      final result = await valiteSongbookNameUseCase("NEW SONGBOOK");

      expect(result, SongbookNameValidation.existingName);
    });

    test("and input is valid input should return validInput", () async {
      final result = await valiteSongbookNameUseCase("Novo songbook");

      expect(result, SongbookNameValidation.validInput);
    });
  });
}
