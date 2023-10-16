import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/app/use_cases/share_link.dart';
import 'package:cifraclub/domain/preferences/use_cases/get_list_order_type_preference.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_songbook_by_id.dart';
import 'package:cifraclub/domain/songbook/use_cases/validate_artist_image_preview.dart';
import 'package:cifraclub/domain/version/use_cases/get_ordered_versions.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/widgets/list_order_type.dart';
import 'package:cifraclub/presentation/screens/songbook/versions_shared/versions_shared_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/versions_shared/versions_shared_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:share_plus/share_plus.dart';
import 'package:typed_result/typed_result.dart';

import '../../../../shared_mocks/domain/songbook/models/songbook_mock.dart';
import '../../../../shared_mocks/domain/version/models/version_mock.dart';

class _ShareLinkMock extends Mock implements ShareLink {}

class _GetOrderFilterPreferencesMock extends Mock implements GetListOrderTypePreferences {}

class _GetOrderedVersionsMock extends Mock implements GetOrderedVersions {}

class _GetSongbookByIdMock extends Mock implements GetSongbookById {}

class _ValidateArtistImagePreviewMock extends Mock implements ValidateArtistImagePreview {
  _ValidateArtistImagePreviewMock() {
    when(() => call(any())).thenReturn([]);
  }
}

void main() {
  VersionsSharedBloc getBloc({
    _GetSongbookByIdMock? getSongbookById,
    _ShareLinkMock? shareLinkMock,
    _GetOrderedVersionsMock? getOrderedVersions,
    _ValidateArtistImagePreviewMock? validateArtistImagePreview,
  }) =>
      VersionsSharedBloc(
        shareLinkMock ?? _ShareLinkMock(),
        getOrderedVersions ?? _GetOrderedVersionsMock(),
        validateArtistImagePreview ?? _ValidateArtistImagePreviewMock(),
        getSongbookById ?? _GetSongbookByIdMock(),
      );

  setUpAll(() {
    registerFallbackValue(ListOrderType.alphabeticOrder);
    registerFallbackValue(ListType.user);
  });

  group("When call 'init'", () {
    final songbook = getFakeSongbook();
    final versions = [getFakeVersion(), getFakeVersion()];
    final getSongbookById = _GetSongbookByIdMock();
    final getOrderFilterPreferences = _GetOrderFilterPreferencesMock();
    when(getOrderFilterPreferences).thenReturn(ListOrderType.custom.key);

    registerFallbackValue(ListOrderType.alphabeticOrder);
    registerFallbackValue(ListType.user);
    final getOrderedVersions = _GetOrderedVersionsMock();
    when(() => getOrderedVersions(any(), any(), any())).thenReturn(versions);
    when(() => getSongbookById(any())).thenAnswer((_) {
      return SynchronousFuture(Ok((
        songbook: songbook,
        versions: versions,
      )));
    });
    group("and songbook id is not null", () {
      blocTest(
        "should emit correctly states",
        build: () => getBloc(
          getSongbookById: getSongbookById,
          getOrderedVersions: getOrderedVersions,
        ),
        act: (bloc) => bloc.init(songbook.id),
        expect: () => [
          isA<VersionsSharedState>()
              .having((state) => state.songbook, "songbook", songbook)
              .having((state) => state.versions, "versions", versions)
              .having((state) => state.selectedListOrderType, "ordered capsule", ListOrderType.recent)
              .having((state) => state.versions.length, "ordered version list", versions.length),
        ],
      );
    });
  });

  test("When call 'shareLink' should call sharelink lib", () async {
    final shareLink = _ShareLinkMock();
    when(() => shareLink(link: "https://www.test.com", sharePositionOrigin: null))
        .thenAnswer((_) => SynchronousFuture(const ShareResult("raw", ShareResultStatus.success)));

    final bloc = getBloc(shareLinkMock: shareLink);
    await bloc.shareLink("https://www.test.com", null);

    verify(() => shareLink(link: "https://www.test.com")).called(1);
  });

  test("When call 'getPreview' should return preview image url list", () async {
    final validateImagePreview = _ValidateArtistImagePreviewMock();
    final fakeImageList = ["test1", "test2"];
    when(() => validateImagePreview(any())).thenReturn(fakeImageList);

    final bloc = getBloc(validateArtistImagePreview: validateImagePreview);
    bloc.emit(VersionsSharedState(songbook: getFakeSongbook(preview: fakeImageList)));
    final result = bloc.getPreview();

    verify(() => validateImagePreview(any())).called(1);
    expect(result, fakeImageList);
  });

  test("When call 'getPreview' and preview is empty return should empty list", () async {
    final validateImagePreview = _ValidateArtistImagePreviewMock();

    final bloc = getBloc(validateArtistImagePreview: validateImagePreview);
    bloc.emit(VersionsSharedState(songbook: getFakeSongbook(preview: List.empty())));
    final result = bloc.getPreview();

    verifyNever(() => validateImagePreview(any()));
    expect(result, []);
  });

  group("When 'onSelectedOrderType' is called", () {
    final versions = [getFakeVersion(), getFakeVersion()];

    final getOrderedVersions = _GetOrderedVersionsMock();
    when(() => getOrderedVersions(any(), any(), any())).thenReturn(versions);

    blocTest(
      "should emit correctly states",
      build: () => getBloc(
        getOrderedVersions: getOrderedVersions,
      )..emit(VersionsSharedState(versions: versions, songbook: getFakeSongbook())),
      act: (bloc) => bloc.onSelectedOrderType(ListOrderType.recent),
      expect: () => [
        isA<VersionsSharedState>()
            .having((state) => state.selectedListOrderType, "list order type", ListOrderType.recent)
            .having((state) => state.versions, "versions", versions),
      ],
      verify: (bloc) {
        verify(() => getOrderedVersions(ListOrderType.recent, versions, ListType.user)).called(1);
      },
    );
  });

  group("When getSongbook fails", () {
    final getSongbookById = _GetSongbookByIdMock();
    when(() => getSongbookById(any())).thenAnswer((_) => SynchronousFuture(Err(ServerError())));

    blocTest(
      "should emit error",
      build: () => getBloc(
        getSongbookById: getSongbookById,
      ),
      act: (bloc) => bloc.init(1),
      expect: () => [isA<VersionsSharedState>().having((state) => state.error, "error", isA<ServerError>())],
      verify: (bloc) {
        verify(() => getSongbookById(any())).called(1);
      },
    );
  });
}
