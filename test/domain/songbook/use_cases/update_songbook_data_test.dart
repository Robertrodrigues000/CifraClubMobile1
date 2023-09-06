import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:cifraclub/domain/songbook/use_cases/update_songbook_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/songbook/models/songbook_mock.dart';

class _UserSongbookRepositoryMock extends Mock implements UserSongbookRepository {}

class _SongbookRepositoryMock extends Mock implements SongbookRepository {}

void main() {
  group("When UpdateSongbookData is called", () {
    final userSongbookRepository = _UserSongbookRepositoryMock();
    final songbook = getFakeSongbook();
    registerFallbackValue(songbook);

    when(() => userSongbookRepository.putUserSongbook(captureAny())).thenAnswer((_) => SynchronousFuture(songbook.id!));

    final songbookRepository = _SongbookRepositoryMock();

    when(() => songbookRepository.updateSongbookData(
          songbookId: captureAny(named: "songbookId"),
          lastUpdated: captureAny(named: "lastUpdated"),
          isPublic: captureAny(named: "isPublic"),
          name: captureAny(named: "name"),
        )).thenAnswer((invocation) => SynchronousFuture(const Ok(null)));

    final useCase = UpdateSongbookData(songbookRepository, userSongbookRepository);

    test("and songbook id is null should return a exception", () {
      expect(
        () async {
          await useCase(songbook: songbook.copyWith(id: null));
        },
        throwsA(isException),
      );
    });

    test("and pass all informations correctly should return songbook infos", () async {
      final result = await useCase(songbook: songbook, isPublic: true, name: "Novo songbook");

      expect(result.isSuccess, isTrue);

      final args = verify(() => songbookRepository.updateSongbookData(
            songbookId: captureAny(named: "songbookId"),
            lastUpdated: captureAny(named: "lastUpdated"),
            isPublic: captureAny(named: "isPublic"),
            name: captureAny(named: "name"),
          )).captured;

      expect(args, [songbook.id, true, isA<DateTime>(), "Novo songbook"]);

      final songbookInserted =
          verify(() => userSongbookRepository.putUserSongbook(captureAny())).captured.first as Songbook;

      expect(songbookInserted, songbook.copyWith(name: "Novo songbook", isPublic: true, lastUpdated: args[2]));
    });

    test("and pass songbook and name correctly should return songbook infos", () async {
      final result = await useCase(songbook: songbook, name: "Songbook");

      expect(result.isSuccess, isTrue);

      final args = verify(() => songbookRepository.updateSongbookData(
            songbookId: captureAny(named: "songbookId"),
            lastUpdated: captureAny(named: "lastUpdated"),
            isPublic: captureAny(named: "isPublic"),
            name: captureAny(named: "name"),
          )).captured;

      expect(args, [songbook.id, songbook.isPublic, isA<DateTime>(), "Songbook"]);

      final songbookInserted =
          verify(() => userSongbookRepository.putUserSongbook(captureAny())).captured.first as Songbook;

      expect(songbookInserted, songbook.copyWith(lastUpdated: args[2], name: "Songbook"));
    });

    test("and pass just songbook should return request sucess and not call repository functions", () async {
      final result = await useCase(songbook: songbook);

      expect(result.isSuccess, isTrue);

      verifyNever(() => songbookRepository.updateSongbookData(
            songbookId: captureAny(named: "songbookId"),
            lastUpdated: captureAny(named: "lastUpdated"),
            isPublic: captureAny(named: "isPublic"),
            name: captureAny(named: "name"),
          )).called(0);

      verifyNever(() => userSongbookRepository.putUserSongbook(captureAny())).called(0);
    });

    test("and fails requisition should return a exception", () async {
      when(() => songbookRepository.updateSongbookData(
            songbookId: any(named: "songbookId"),
            lastUpdated: any(named: "lastUpdated"),
            isPublic: any(named: "isPublic"),
            name: any(named: "name"),
          )).thenAnswer((invocation) => SynchronousFuture(Err(ServerError(statusCode: 404))));

      final result = await useCase(songbook: songbook, isPublic: true, name: "Novo songbook");

      expect(result.isFailure, isTrue);
    });
  });
}
