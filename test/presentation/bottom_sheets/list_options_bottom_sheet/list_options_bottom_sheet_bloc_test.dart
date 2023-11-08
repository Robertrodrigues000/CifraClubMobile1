import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/app/use_cases/share_link.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/use_cases/clear_versions_from_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/delete_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/update_songbook_data.dart';
import 'package:cifraclub/domain/songbook/use_cases/validate_songbook_name.dart';
import 'package:cifraclub/presentation/bottom_sheets/list_options_bottom_sheet/list_options_bottom_sheet_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:share_plus/share_plus.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/songbook/models/songbook_mock.dart';

class _ClearVersionsFromSongbookMock extends Mock implements ClearVersionsFromSongbook {}

class _ShareLinkMock extends Mock implements ShareLink {}

class _DeleteSongbookMock extends Mock implements DeleteSongbook {}

class _UpdateSongbookDataMock extends Mock implements UpdateSongbookData {}

class _ValidateSongbookNameMock extends Mock implements ValidateSongbookName {
  _ValidateSongbookNameMock([SongbookNameValidation songbookNameValidation = SongbookNameValidation.validInput]) {
    when(() => call(any())).thenAnswer((invocation) => SynchronousFuture(songbookNameValidation));
  }
}

void main() {
  ListOptionsBottomSheetBloc getBloc({
    _DeleteSongbookMock? deleteSongbookMock,
    _UpdateSongbookDataMock? updateSongbookDataMock,
    _ValidateSongbookNameMock? validateSongbookNameMock,
    _ClearVersionsFromSongbookMock? clearVersionsFromSongbookMock,
    _ShareLinkMock? shareLinkMock,
  }) =>
      ListOptionsBottomSheetBloc(
        deleteSongbookMock ?? _DeleteSongbookMock(),
        updateSongbookDataMock ?? _UpdateSongbookDataMock(),
        validateSongbookNameMock ?? _ValidateSongbookNameMock(),
        clearVersionsFromSongbookMock ?? _ClearVersionsFromSongbookMock(),
        shareLinkMock ?? _ShareLinkMock(),
      );

  group("When update a songbook and request is successful", () {
    registerFallbackValue(getFakeSongbook());
    final updateSongbookData = _UpdateSongbookDataMock();
    when(
      () => updateSongbookData(
        songbook: any(named: "songbook"),
        isPublic: any(named: "isPublic"),
        name: any(named: "name"),
      ),
    ).thenAnswer((_) => SynchronousFuture(const Ok(null)));
    final songbook = getFakeSongbook();

    blocTest(
      "should call use case",
      build: () => getBloc(updateSongbookDataMock: updateSongbookData),
      act: (bloc) => bloc.updateSongbookData(songbook: songbook),
      verify: (bloc) {
        verify(() => updateSongbookData(songbook: songbook)).called(1);
      },
    );
  });

  group("When update a songbook and request fails", () {
    final updateSongbookData = _UpdateSongbookDataMock();
    when(
      () => updateSongbookData(
        songbook: any(named: "songbook"),
        isPublic: any(named: "isPublic"),
        name: any(named: "name"),
      ),
    ).thenAnswer((_) => SynchronousFuture(Err(ServerError(statusCode: 404))));
    final songbook = getFakeSongbook();

    blocTest(
      "should call use case",
      build: () => getBloc(updateSongbookDataMock: updateSongbookData),
      act: (bloc) => bloc.updateSongbookData(songbook: songbook),
      verify: (bloc) {
        verify(() => updateSongbookData(songbook: songbook)).called(1);
      },
    );
  });

  group("When `clearList` is called", () {
    test("and songbook is not null should call clearVersionsFromSongbook", () async {
      final clearVersionsFromSongbook = _ClearVersionsFromSongbookMock();
      when(() => clearVersionsFromSongbook(any())).thenAnswer((_) => SynchronousFuture(const Ok(null)));

      final bloc = getBloc(clearVersionsFromSongbookMock: clearVersionsFromSongbook);
      await bloc.clearList(10);

      verify(() => clearVersionsFromSongbook(10)).called(1);
    });
    test("and songbook is null should return error", () async {
      final clearVersionsFromSongbook = _ClearVersionsFromSongbookMock();

      final bloc = getBloc(clearVersionsFromSongbookMock: clearVersionsFromSongbook);
      final result = await bloc.clearList(null);

      verifyNever(() => clearVersionsFromSongbook(10)).called(0);
      expect(result.isFailure, isTrue);
    });
  });

  test("When `shareLink` is called should call shareLink lib", () async {
    final shareLink = _ShareLinkMock();
    when(() => shareLink(link: any(named: "link")))
        .thenAnswer((_) => SynchronousFuture(const ShareResult("raw", ShareResultStatus.success)));

    final bloc = getBloc(shareLinkMock: shareLink);
    await bloc.shareLink("https.com", null);

    verify(() => shareLink(link: "https.com")).called(1);
  });

  test("When `deleteSongbook` is called should call delete songbook by id", () async {
    final deleteSongbookMock = _DeleteSongbookMock();
    when(() => deleteSongbookMock(1)).thenAnswer((invocation) => SynchronousFuture(const Ok(null)));

    final bloc = getBloc(deleteSongbookMock: deleteSongbookMock);
    await bloc.deleteSongbook(1);

    verify(() => deleteSongbookMock(1)).called(1);
  });

  test("When `isValidSongbookName` is called and songbook name is valid should return true", () async {
    final validateSongbookNameMock = _ValidateSongbookNameMock(SongbookNameValidation.validInput);

    final bloc = getBloc(validateSongbookNameMock: validateSongbookNameMock);
    final result = await bloc.isValidSongbookName("teste");

    expect(result, true);
  });

  test("When `isValidSongbookName` is called and songbook name is repeated should return false", () async {
    final validateSongbookNameMock = _ValidateSongbookNameMock(SongbookNameValidation.existingName);

    final bloc = getBloc(validateSongbookNameMock: validateSongbookNameMock);
    final result = await bloc.isValidSongbookName("teste");

    expect(result, false);
  });
}
