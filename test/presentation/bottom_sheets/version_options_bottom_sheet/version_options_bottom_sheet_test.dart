import 'package:cifraclub/domain/app/use_cases/share_link.dart';
import 'package:cifraclub/domain/songbook/use_cases/delete_version_from_favorites.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_is_favorite_version_by_song_id.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_version_to_songbook.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart';
import 'package:cifraclub/domain/user/use_cases/open_login_page.dart';
import 'package:cifraclub/presentation/bottom_sheets/save_version_to_list_bottom_sheet/save_version_to_list_bottom_sheet.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/version_options_bottom_sheet.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/version_options_bottom_sheet_bloc.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/version_options_bottom_sheet_state.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/version_options_result.dart';
import 'package:cifraclub/presentation/widgets/icon_text_tile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_helpers/app_localizations.dart';
import '../../../test_helpers/bloc_stream.dart';
import '../../../test_helpers/test_wrapper.dart';

class _SaveVersionToListBottomSheetMock extends Mock implements SaveVersionToListBottomSheet {}

class _BuildContextMock extends Mock implements BuildContext {}

class _InsertVersionToSongbookMock extends Mock implements InsertVersionToSongbook {}

class _GetCredentialStreamMock extends Mock implements GetCredentialStream {}

class _GetIsFavoriteVersionBySongIdMock extends Mock implements GetIsFavoriteVersionBySongId {}

class _OpenLoginPageMock extends Mock implements OpenLoginPage {}

class _DeleteVersionFromFavoritesMock extends Mock implements DeleteVersionFromFavorites {}

class _ShareLinkMock extends Mock implements ShareLink {}

class _VersionOptionsBottomSheetBlocMock extends Mock implements VersionOptionsBottomSheetBloc {}

void main() {
  late VersionOptionsBottomSheet versionOptionsBottomSheet;
  late _VersionOptionsBottomSheetBlocMock bloc;

  setUpAll(() {
    registerFallbackValue(_BuildContextMock());

    bloc = _VersionOptionsBottomSheetBlocMock();
    when(bloc.init).thenReturn(null);
    when(() => bloc.shareLink(any(), any())).thenAnswer((_) => SynchronousFuture(null));
    when(() => bloc.onFavorite(any(), any())).thenAnswer((_) => SynchronousFuture(FavoriteVersionSuccess()));
    when(bloc.openLoginPage).thenAnswer((_) => SynchronousFuture(null));
    when(bloc.close).thenAnswer((_) => SynchronousFuture(null));

    versionOptionsBottomSheet = VersionOptionsBottomSheet(
      _SaveVersionToListBottomSheetMock(),
      _InsertVersionToSongbookMock(),
      _GetIsFavoriteVersionBySongIdMock(),
      _DeleteVersionFromFavoritesMock(),
      _GetCredentialStreamMock(),
      _OpenLoginPageMock(),
      _ShareLinkMock(),
    );
  });

  Future<void> setShowVersionOptionsBottomSheet(
    BuildContext context,
    _VersionOptionsBottomSheetBlocMock bloc,
    String artistUrl,
    String songUrl,
    int songId,
  ) =>
      versionOptionsBottomSheet.show(
          context: context, artistUrl: artistUrl, songUrl: songUrl, songId: songId, bloc: bloc..init());

  testWidgets("when bottom sheet is open should show all options", (widgetTester) async {
    bloc.mockStream(const VersionOptionsBottomSheetState());
    await widgetTester.pumpWidgetWithWrapper(
      Builder(
        builder: (context) {
          return Scaffold(
            body: InkWell(
              onTap: () async {
                await setShowVersionOptionsBottomSheet(context, bloc, "", "", 1);
              },
            ),
          );
        },
      ),
    );

    expect(find.byType(InkWell), findsOneWidget);
    await widgetTester.tap(find.byType(InkWell));
    await widgetTester.pumpAndSettle();
    expect(find.byType(IconTextTile), findsNWidgets(4));
  });

  group("when bottom sheet is open and save versions to list is tapped", () {
    testWidgets("if the user is logged in, should show SaveVersionToList Bottom sheet", (widgetTester) async {
      bloc.mockStream(const VersionOptionsBottomSheetState(isLoggedIn: true));

      final saveVersionToListBottomSheet = _SaveVersionToListBottomSheetMock();
      when(() => saveVersionToListBottomSheet.show(
          context: any(named: "context"),
          artistUrl: any(named: "artistUrl"),
          songUrl: any(named: "songUrl"))).thenAnswer((_) => SynchronousFuture(null));

      versionOptionsBottomSheet = VersionOptionsBottomSheet(
        saveVersionToListBottomSheet,
        _InsertVersionToSongbookMock(),
        _GetIsFavoriteVersionBySongIdMock(),
        _DeleteVersionFromFavoritesMock(),
        _GetCredentialStreamMock(),
        _OpenLoginPageMock(),
        _ShareLinkMock(),
      );

      await widgetTester.pumpWidgetWithWrapper(
        Builder(
          builder: (context) {
            return Scaffold(
              body: InkWell(
                onTap: () async {
                  await setShowVersionOptionsBottomSheet(context, bloc, "", "", 1);
                },
              ),
            );
          },
        ),
      );

      expect(find.byType(InkWell), findsOneWidget);
      await widgetTester.tap(find.byType(InkWell));
      await widgetTester.pumpAndSettle();
      expect(find.byType(IconTextTile), findsNWidgets(4));

      await widgetTester.tap(find.text(appTextEn.saveVersionToList));
      await widgetTester.pumpAndSettle();

      verify(() => saveVersionToListBottomSheet.show(
          context: any(named: "context"),
          artistUrl: any(named: "artistUrl"),
          songUrl: any(named: "songUrl"))).called(1);
    });
    testWidgets("if the user is not logged in, should call openLoginPage", (widgetTester) async {
      bloc.mockStream(const VersionOptionsBottomSheetState(isLoggedIn: false));

      final saveVersionToListBottomSheet = _SaveVersionToListBottomSheetMock();
      when(() => saveVersionToListBottomSheet.show(
          context: any(named: "context"),
          artistUrl: any(named: "artistUrl"),
          songUrl: any(named: "songUrl"))).thenAnswer((_) => SynchronousFuture(null));

      await widgetTester.pumpWidgetWithWrapper(
        Builder(
          builder: (context) {
            return Scaffold(
              body: InkWell(
                onTap: () async {
                  await setShowVersionOptionsBottomSheet(context, bloc, "", "", 1);
                },
              ),
            );
          },
        ),
      );

      expect(find.byType(InkWell), findsOneWidget);
      await widgetTester.tap(find.byType(InkWell));
      await widgetTester.pumpAndSettle();
      expect(find.byType(IconTextTile), findsNWidgets(4));

      await widgetTester.tap(find.text(appTextEn.saveVersionToList));
      await widgetTester.pumpAndSettle();

      verifyNever(() => saveVersionToListBottomSheet.show(
          context: any(named: "context"),
          artistUrl: any(named: "artistUrl"),
          songUrl: any(named: "songUrl"))).called(0);
      verify(() => bloc.openLoginPage()).called(1);
    });
  });

  group("when bottom sheet is open and favorite/un favorite is tapped", () {
    testWidgets("should call onFavorite", (widgetTester) async {
      bloc.mockStream(const VersionOptionsBottomSheetState(isFavorite: false, isLoggedIn: true));
      await widgetTester.pumpWidgetWithWrapper(
        Builder(
          builder: (context) {
            return Scaffold(
              body: InkWell(
                onTap: () async {
                  await setShowVersionOptionsBottomSheet(context, bloc, "", "", 1);
                },
              ),
            );
          },
        ),
      );

      expect(find.byType(InkWell), findsOneWidget);
      await widgetTester.tap(find.byType(InkWell));
      await widgetTester.pumpAndSettle();
      expect(find.byType(IconTextTile), findsNWidgets(4));

      await widgetTester.tap(find.text(appTextEn.favoriteVersion));
      await widgetTester.pumpAndSettle();

      verify(() => bloc.onFavorite(any(), any())).called(1);
    });

    testWidgets("but user is not logged, should call openLoginPage", (widgetTester) async {
      bloc.mockStream(const VersionOptionsBottomSheetState(isLoggedIn: false));
      await widgetTester.pumpWidgetWithWrapper(
        Builder(
          builder: (context) {
            return Scaffold(
              body: InkWell(
                onTap: () async {
                  await setShowVersionOptionsBottomSheet(context, bloc, "", "", 1);
                },
              ),
            );
          },
        ),
      );

      expect(find.byType(InkWell), findsOneWidget);
      await widgetTester.tap(find.byType(InkWell));
      await widgetTester.pumpAndSettle();
      expect(find.byType(IconTextTile), findsNWidgets(4));

      await widgetTester.tap(find.text(appTextEn.favoriteVersion));
      await widgetTester.pumpAndSettle();

      verify(() => bloc.openLoginPage()).called(1);
    });
  });
}
