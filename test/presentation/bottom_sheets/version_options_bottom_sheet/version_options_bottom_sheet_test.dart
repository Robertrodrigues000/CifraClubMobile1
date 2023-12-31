import 'package:cifraclub/domain/app/use_cases/is_app_installed.dart';
import 'package:cifraclub/domain/app/use_cases/open_app_or_store.dart';
import 'package:cifraclub/domain/app/use_cases/share_link.dart';
import 'package:cifraclub/domain/songbook/use_cases/favorite_unfavorite_version.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_is_favorite_version_by_song_id.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart';
import 'package:cifraclub/domain/user/use_cases/open_login_page.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/domain/version/models/musical_scale.dart';
import 'package:cifraclub/domain/version/models/version_data.dart';
import 'package:cifraclub/presentation/bottom_sheets/save_version_to_list_bottom_sheet/save_version_to_list_bottom_sheet.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/version_options_bottom_sheet.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/version_options_bottom_sheet_action.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/version_options_bottom_sheet_bloc.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/version_options_bottom_sheet_state.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/widgets/key_section.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/widgets/version_configuration_tile.dart';
import 'package:cifraclub/presentation/constants/app_urls.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/cifraclub_button.dart';
import 'package:cifraclub/domain/songbook/models/version_options_result.dart';
import 'package:cifraclub/presentation/widgets/icon_text_tile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/domain/version/models/version_data_mock.dart';
import '../../../test_helpers/app_localizations.dart';
import '../../../test_helpers/bloc_stream.dart';
import '../../../test_helpers/test_wrapper.dart';

class _SaveVersionToListBottomSheetMock extends Mock implements SaveVersionToListBottomSheet {}

class _BuildContextMock extends Mock implements BuildContext {}

class _FavoriteUnfavoriteVersionMock extends Mock implements FavoriteUnfavoriteVersion {}

class _GetCredentialStreamMock extends Mock implements GetCredentialStream {}

class _GetIsFavoriteVersionBySongIdMock extends Mock implements GetIsFavoriteVersionBySongId {}

class _OpenLoginPageMock extends Mock implements OpenLoginPage {}

class _ShareLinkMock extends Mock implements ShareLink {}

class _VersionOptionsBottomSheetBlocMock extends Mock implements VersionOptionsBottomSheetBloc {}

class _OpenAppOrStoreMock extends Mock implements OpenAppOrStore {}

class _IsAppInstalledMock extends Mock implements IsAppInstalled {}

void main() {
  late VersionOptionsBottomSheet versionOptionsBottomSheet;
  late _VersionOptionsBottomSheetBlocMock bloc;

  setUpAll(() {
    registerFallbackValue(_BuildContextMock());

    bloc = _VersionOptionsBottomSheetBlocMock();
    when(bloc.init).thenAnswer((_) => SynchronousFuture(null));
    when(() => bloc.shareLink(any(), any())).thenAnswer((_) => SynchronousFuture(null));
    when(() => bloc.onFavorite(any(), any())).thenAnswer((_) => SynchronousFuture(FavoriteVersionSuccess()));
    when(bloc.openLoginPage).thenAnswer((_) => SynchronousFuture(null));
    when(bloc.openAppOrStore).thenAnswer((_) => SynchronousFuture(null));
    when(bloc.toggleLeftHanded).thenReturn(null);
    when(bloc.toggleBeatVisibility).thenReturn(null);
    when(bloc.toggleTabsVisibility).thenReturn(null);
    when(bloc.close).thenAnswer((_) => SynchronousFuture(null));

    versionOptionsBottomSheet = VersionOptionsBottomSheet(
      _SaveVersionToListBottomSheetMock(),
      _GetIsFavoriteVersionBySongIdMock(),
      _GetCredentialStreamMock(),
      _OpenLoginPageMock(),
      _ShareLinkMock(),
      _OpenAppOrStoreMock(),
      _IsAppInstalledMock(),
      _FavoriteUnfavoriteVersionMock(),
    );
  });

  Future<void> setShowVersionOptionsBottomSheet(
    BuildContext context,
    _VersionOptionsBottomSheetBlocMock bloc,
    String artistUrl,
    String songUrl,
    int songId,
    bool isVersionBottomSheet,
    VersionData? versionData,
    bool isPro,
    Function(VersionOptionsBottomSheetAction)? onAction,
  ) =>
      versionOptionsBottomSheet.show(
          context: context,
          artistUrl: artistUrl,
          songUrl: songUrl,
          songId: songId,
          isVersionBottomSheet: isVersionBottomSheet,
          versionData: versionData,
          isPro: isPro,
          onAction: onAction,
          bloc: bloc..init());

  testWidgets("when bottom sheet is open should show all options", (widgetTester) async {
    bloc.mockStream(const VersionOptionsBottomSheetState());
    await widgetTester.pumpWidgetWithWrapper(
      Builder(
        builder: (context) {
          return Scaffold(
            body: InkWell(
              onTap: () async {
                await setShowVersionOptionsBottomSheet(context, bloc, "", "", 1, false, null, false, null);
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
        _GetIsFavoriteVersionBySongIdMock(),
        _GetCredentialStreamMock(),
        _OpenLoginPageMock(),
        _ShareLinkMock(),
        _OpenAppOrStoreMock(),
        _IsAppInstalledMock(),
        _FavoriteUnfavoriteVersionMock(),
      );

      await widgetTester.pumpWidgetWithWrapper(
        Builder(
          builder: (context) {
            return Scaffold(
              body: InkWell(
                onTap: () async {
                  await setShowVersionOptionsBottomSheet(context, bloc, "", "", 1, false, null, false, null);
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
                  await setShowVersionOptionsBottomSheet(context, bloc, "", "", 1, false, null, false, null);
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
                  await setShowVersionOptionsBottomSheet(context, bloc, "", "", 1, false, null, false, null);
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
                  await setShowVersionOptionsBottomSheet(context, bloc, "", "", 1, false, null, false, null);
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

  testWidgets("When tap in shareLink option should call share link", (widgetTester) async {
    bloc.mockStream(const VersionOptionsBottomSheetState());
    final version = getFakeVersionData();
    final link = AppUrls.shareVersionWithConfig(
        artistUrl: version.artist?.url ?? "",
        songUrl: version.song.url,
        instrument: version.instrument,
        capo: version.capo.capoId,
        key: MusicalScale.getMusicalScale(version.key ?? ""),
        tuning: version.tuning?.value,
        versionUrl: version.versionUrl);

    await widgetTester.pumpWidgetWithWrapper(
      Builder(
        builder: (context) {
          return Scaffold(
            body: InkWell(
              onTap: () async {
                await setShowVersionOptionsBottomSheet(context, bloc, version.artist?.url ?? "", version.song.url,
                    version.song.songId, true, version, false, null);
              },
            ),
          );
        },
      ),
    );

    expect(find.byType(InkWell), findsOneWidget);
    await widgetTester.tap(find.byType(InkWell));
    await widgetTester.pumpAndSettle();

    expect(find.byType(IconTextTile), findsNWidgets(5));
    await widgetTester.tap(find.text(appTextEn.share));
    await widgetTester.pumpAndSettle();

    verify(() => bloc.shareLink(link, any())).called(1);
  });

  group("when isVersionBottomSheet true", () {
    testWidgets("should show more options", (widgetTester) async {
      bloc.mockStream(const VersionOptionsBottomSheetState());
      await widgetTester.pumpWidgetWithWrapper(
        Builder(
          builder: (context) {
            return Scaffold(
              body: InkWell(
                onTap: () async {
                  await setShowVersionOptionsBottomSheet(context, bloc, "", "", 1, true, null, false, null);
                },
              ),
            );
          },
        ),
      );

      expect(find.byType(InkWell), findsOneWidget);
      await widgetTester.tap(find.byType(InkWell));
      await widgetTester.pumpAndSettle();

      expect(find.byType(IconTextTile), findsNWidgets(5));
      expect(find.byType(VersionConfigurationTile), findsNWidgets(4));
      expect(find.byType(KeySection), findsOneWidget);
      expect(find.byType(SwitchListTile), findsNWidgets(2));
      expect(find.byType(CifraClubButton), findsOneWidget);
    });

    testWidgets("should show a VersionConfigurationTile with instrument and version selected", (widgetTester) async {
      bloc.mockStream(
          const VersionOptionsBottomSheetState(instrument: Instrument.violaCaipira, selectedVersion: "Principal"));
      await widgetTester.pumpWidgetWithWrapper(
        Builder(
          builder: (context) {
            return Scaffold(
              body: InkWell(
                onTap: () async {
                  await setShowVersionOptionsBottomSheet(context, bloc, "", "", 1, true, null, false, (action) {});
                },
              ),
            );
          },
        ),
      );

      expect(find.byType(InkWell), findsOneWidget);
      await widgetTester.tap(find.byType(InkWell));
      await widgetTester.pumpAndSettle();

      expect(find.byType(VersionConfigurationTile), findsNWidgets(3));
      final finder = find.byWidgetPredicate(
          (Widget widget) => widget is VersionConfigurationTile && widget.name == appTextEn.instrumentViola);
      expect(finder, findsOneWidget);
      expect(find.widgetWithText(VersionConfigurationTile, "Principal"), findsOneWidget);
    });

    testWidgets("and instrument is drums, should show only version selected and tuner", (widgetTester) async {
      bloc.mockStream(const VersionOptionsBottomSheetState(instrument: Instrument.drums));
      await widgetTester.pumpWidgetWithWrapper(
        Builder(
          builder: (context) {
            return Scaffold(
              body: InkWell(
                onTap: () async {
                  await setShowVersionOptionsBottomSheet(context, bloc, "", "", 1, true, null, false, (action) {});
                },
              ),
            );
          },
        ),
      );

      expect(find.byType(InkWell), findsOneWidget);
      await widgetTester.tap(find.byType(InkWell));
      await widgetTester.pumpAndSettle();

      expect(find.byType(IconTextTile), findsNWidgets(5));
      expect(find.byType(VersionConfigurationTile), findsNWidgets(2));
      expect(find.byType(KeySection), findsNothing);
      expect(find.byType(SwitchListTile), findsNothing);
      expect(find.byType(CifraClubButton), findsNothing);
    });

    testWidgets("and instrument is keyboard, should not show tabs switch, left-handed switch, capo and tuning",
        (widgetTester) async {
      bloc.mockStream(const VersionOptionsBottomSheetState(instrument: Instrument.keyboard));
      await widgetTester.pumpWidgetWithWrapper(
        Builder(
          builder: (context) {
            return Scaffold(
              body: InkWell(
                onTap: () async {
                  await setShowVersionOptionsBottomSheet(context, bloc, "", "", 1, true, null, false, (action) {});
                },
              ),
            );
          },
        ),
      );

      expect(find.byType(InkWell), findsOneWidget);
      await widgetTester.tap(find.byType(InkWell));
      await widgetTester.pumpAndSettle();

      expect(find.byType(IconTextTile), findsNWidgets(5));
      expect(find.byType(VersionConfigurationTile), findsNWidgets(2));
      expect(find.byType(KeySection), findsOneWidget);
      expect(find.byType(SwitchListTile), findsNothing);
      expect(find.byType(CifraClubButton), findsOneWidget);
    });

    testWidgets("and instrument is viola caipira, should not show tabs switch and capo", (widgetTester) async {
      bloc.mockStream(const VersionOptionsBottomSheetState(instrument: Instrument.violaCaipira));
      await widgetTester.pumpWidgetWithWrapper(
        Builder(
          builder: (context) {
            return Scaffold(
              body: InkWell(
                onTap: () async {
                  await setShowVersionOptionsBottomSheet(context, bloc, "", "", 1, true, null, false, (action) {});
                },
              ),
            );
          },
        ),
      );

      expect(find.byType(InkWell), findsOneWidget);
      await widgetTester.tap(find.byType(InkWell));
      await widgetTester.pumpAndSettle();

      expect(find.byType(IconTextTile), findsNWidgets(5));
      expect(find.byType(VersionConfigurationTile), findsNWidgets(3));
      expect(find.byType(KeySection), findsOneWidget);
      expect(find.byType(SwitchListTile), findsNWidgets(1));
      expect(find.byType(CifraClubButton), findsOneWidget);
    });

    testWidgets("and tuner tile is tapped, should open app or store", (widgetTester) async {
      bloc.mockStream(const VersionOptionsBottomSheetState());

      await widgetTester.pumpWidgetWithWrapper(
        Builder(
          builder: (context) {
            return Scaffold(
              body: InkWell(
                onTap: () async {
                  await setShowVersionOptionsBottomSheet(context, bloc, "", "", 1, true,
                      getFakeVersionData(instrument: Instrument.guitar), false, (action) {});
                },
              ),
            );
          },
        ),
      );
      expect(find.byType(InkWell), findsOneWidget);
      await widgetTester.tap(find.byType(InkWell));
      await widgetTester.pumpAndSettle();

      final scrollFinder = find.byType(Scrollable).first;
      expect(scrollFinder, findsOneWidget);
      await widgetTester.scrollUntilVisible(find.byType(SizedBox).last, 50, scrollable: scrollFinder);

      final finder = find.widgetWithText(VersionConfigurationTile, appTextEn.tuner, skipOffstage: false);
      expect(finder, findsOneWidget);
      await widgetTester.tap(finder, warnIfMissed: false);
      await widgetTester.pumpAndSettle();

      verify(bloc.openAppOrStore).called(1);
    });

    testWidgets("and tab tile is tapped, should call toggleTabsVisibility", (widgetTester) async {
      bloc.mockStream(const VersionOptionsBottomSheetState());

      await widgetTester.pumpWidgetWithWrapper(
        Builder(
          builder: (context) {
            return Scaffold(
              body: InkWell(
                onTap: () async {
                  await setShowVersionOptionsBottomSheet(context, bloc, "", "", 1, true,
                      getFakeVersionData(instrument: Instrument.guitar), false, (action) {});
                },
              ),
            );
          },
        ),
      );
      expect(find.byType(InkWell), findsOneWidget);
      await widgetTester.tap(find.byType(InkWell));
      await widgetTester.pumpAndSettle();

      final scrollFinder = find.byType(Scrollable).first;
      expect(scrollFinder, findsOneWidget);
      await widgetTester.scrollUntilVisible(find.byType(SizedBox).last, 50, scrollable: scrollFinder);

      final finder = find.widgetWithText(SwitchListTile, appTextEn.showTabs, skipOffstage: false);
      expect(finder, findsOneWidget);
      await widgetTester.tap(finder, warnIfMissed: false);
      await widgetTester.pumpAndSettle();

      verify(bloc.toggleTabsVisibility).called(1);
    });

    testWidgets("and left-handed tile is tapped, should call toggleLeftHanded", (widgetTester) async {
      bloc.mockStream(const VersionOptionsBottomSheetState());

      await widgetTester.pumpWidgetWithWrapper(
        Builder(
          builder: (context) {
            return Scaffold(
              body: InkWell(
                onTap: () async {
                  await setShowVersionOptionsBottomSheet(context, bloc, "", "", 1, true,
                      getFakeVersionData(instrument: Instrument.guitar), false, (action) {});
                },
              ),
            );
          },
        ),
      );
      expect(find.byType(InkWell), findsOneWidget);
      await widgetTester.tap(find.byType(InkWell));
      await widgetTester.pumpAndSettle();

      final scrollFinder = find.byType(Scrollable).first;
      expect(scrollFinder, findsOneWidget);
      await widgetTester.scrollUntilVisible(find.byType(SizedBox).last, 50, scrollable: scrollFinder);

      final finder = find.widgetWithText(SwitchListTile, appTextEn.leftHanded, skipOffstage: false);
      expect(finder, findsOneWidget);

      await widgetTester.tap(finder, warnIfMissed: false);
      await widgetTester.pumpAndSettle();

      verify(bloc.toggleLeftHanded).called(1);
    });
  });
}
