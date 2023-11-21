import 'dart:async';

import 'package:cifraclub/domain/app/use_cases/share_link.dart';
import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/use_cases/clear_versions_from_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/clear_recents.dart';
import 'package:cifraclub/domain/songbook/use_cases/delete_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/update_songbook_data.dart';
import 'package:cifraclub/domain/songbook/use_cases/validate_songbook_name.dart';
import 'package:cifraclub/presentation/bottom_sheets/list_options_bottom_sheet/list_options_bottom_sheet.dart';
import 'package:cifraclub/presentation/bottom_sheets/list_options_bottom_sheet/list_options_bottom_sheet_bloc.dart';
import 'package:cifraclub/presentation/bottom_sheets/list_version_options_bottom_sheet.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/dialogs/list_operation_dialogs/list_operation_dialog.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/add_versions_to_list_entry.dart';
import 'package:cifraclub/presentation/dialogs/list_operation_dialogs/delete_dialog.dart';
import 'package:cifraclub/presentation/screens/songbook/edit_list/edit_list_screen_builder.dart';
import 'package:cifraclub/presentation/screens/songbook/songbook_result.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_screen.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_state.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/widgets/version_tile.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/widgets/songbook_information_section.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/widgets/versions_fixed_header.dart';
import 'package:cifraclub/presentation/screens/version/version_entry.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget.dart';
import 'package:cifraclub/presentation/widgets/icon_text_tile.dart';
import 'package:cifraclub/presentation/widgets/limit_warning.dart';
import 'package:cosmos/cosmos.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/cifraclub_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:typed_result/typed_result.dart';

import '../../../../shared_mocks/domain/songbook/models/songbook_mock.dart';
import '../../../../shared_mocks/domain/version/models/version_mock.dart';
import '../../../../shared_mocks/presentation/navigator/nav_mock.dart';
import '../../../../test_helpers/app_localizations.dart';
import '../../../../test_helpers/bloc_stream.dart';
import '../../../../test_helpers/test_wrapper.dart';

class _VersionsBlocMock extends Mock implements VersionsBloc {}

class _ListOptionBottomSheetMock extends Mock implements ListOptionsBottomSheet {}

class _BuildContextMock extends Mock implements BuildContext {}

class _ClearVersionsFromSongbookMock extends Mock implements ClearVersionsFromSongbook {}

class _ShareLinkMock extends Mock implements ShareLink {}

class _DeleteSongbookMock extends Mock implements DeleteSongbook {}

class _UpdateSongbookDataMock extends Mock implements UpdateSongbookData {}

class _ValidateSongbookNameMock extends Mock implements ValidateSongbookName {}

class _ListOptionsBottomSheetBlocMock extends Mock implements ListOptionsBottomSheetBloc {}

class _EditListScreenBuilderMock extends Mock implements EditListScreenBuilder {}

class _ClearRecentsMock extends Mock implements ClearRecents {}

void main() {
  late VersionsBloc bloc;
  late ListOptionsBottomSheet bottomSheet;
  late _ListOptionsBottomSheetBlocMock blocBottomSheet;

  setUpAll(() {
    registerFallbackValue(_BuildContextMock());
    registerFallbackValue(getFakeSongbook());
    registerFallbackValue(getFakeVersion());

    blocBottomSheet = _ListOptionsBottomSheetBlocMock();
    when(() => blocBottomSheet.deleteSongbook(any())).thenAnswer((_) => SynchronousFuture(const Ok(null)));
    when(blocBottomSheet.close).thenAnswer((_) => SynchronousFuture(null));

    final bottomSheetMock = _ListOptionBottomSheetMock();
    when(() => bottomSheetMock.open(
        context: any(named: 'context'),
        isUserList: any(named: 'isUserList'),
        ccid: any(named: 'ccid'),
        onDeleteSongbook: any(named: 'onDeleteSongbook'),
        haveEditMode: any(named: 'haveEditMode'),
        songbook: any(named: 'songbook'))).thenAnswer((_) => SynchronousFuture(null));
    bottomSheet = bottomSheetMock;

    bloc = _VersionsBlocMock();
    when(() => bloc.init(any())).thenAnswer((_) => SynchronousFuture(null));
    when(() => bloc.shareLink(any(), any())).thenAnswer((_) => SynchronousFuture(null));
    when(() => bloc.deleteVersion(any(), any())).thenAnswer((_) => SynchronousFuture(OnVersionDeleted()));
    when(() => bloc.getPreview()).thenReturn([]);
    when(() => bloc.getListLimitState(any())).thenAnswer((_) => SynchronousFuture(ListLimitState.withinLimit));
    when(bloc.close).thenAnswer((_) => SynchronousFuture(null));
  });

  /*testWidgets('When scroll up should show search bar', (widgetTester) async {
    bloc.mockStream(VersionsState(versions: [getFakeVersion(), getFakeVersion()], songbook: getFakeSongbook()));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<VersionsBloc>.value(
        value: bloc,
        child: VersionsScreen(
          isTablet: true,
          listOptionsBottomSheet: bottomSheet,
          songbookId: 1,
        ),
      ),
    );

    await widgetTester.drag(find.byType(CustomScrollView).first, const Offset(0, 100));
    await widgetTester.pumpAndSettle();

    expect(find.byType(CosmosSearchBar), findsOneWidget);
  });*/

  testWidgets('When start should load screen correctly', (widgetTester) async {
    bloc.mockStream(VersionsState(versions: [getFakeVersion(), getFakeVersion()], songbook: getFakeSongbook()));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<VersionsBloc>.value(
        value: bloc,
        child: VersionsScreen(
          isTablet: true,
          listOptionsBottomSheet: bottomSheet,
          songbookId: 1,
        ),
      ),
    );

    expect(find.byType(CosmosSearchBar), findsNothing);
    expect(find.byType(SongbookInformationSection), findsOneWidget);
    expect(find.byType(VersionsFixedHeader), findsOneWidget);
    expect(find.byType(VersionTile, skipOffstage: false), findsNWidgets(2));
  });

  testWidgets('When start and songbook is private should not show share icon should omit the share icon',
      (widgetTester) async {
    bloc.mockStream(
        VersionsState(versions: [getFakeVersion(), getFakeVersion()], songbook: getFakeSongbook(isPublic: false)));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<VersionsBloc>.value(
        value: bloc,
        child: VersionsScreen(
          isTablet: true,
          listOptionsBottomSheet: bottomSheet,
          userId: 1,
          songbookId: 1,
        ),
      ),
    );

    final finder = find.byWidgetPredicate(
      (Widget widget) =>
          widget is SvgPicture &&
          widget.pictureProvider is ExactAssetPicture &&
          (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.shareIcon,
      description: 'share icon',
    );

    expect(finder, findsNothing);
  });

  testWidgets('When start and is not user list type should omit the share icon', (widgetTester) async {
    bloc.mockStream(VersionsState(
        versions: [getFakeVersion(), getFakeVersion()],
        songbook: getFakeSongbook(listType: ListType.favorites, isPublic: true)));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<VersionsBloc>.value(
        value: bloc,
        child: VersionsScreen(
          isTablet: true,
          listOptionsBottomSheet: bottomSheet,
          userId: 1,
          songbookId: 1,
        ),
      ),
    );

    final finder = find.byWidgetPredicate(
      (Widget widget) =>
          widget is SvgPicture &&
          widget.pictureProvider is ExactAssetPicture &&
          (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.shareIcon,
      description: 'share icon',
    );

    expect(finder, findsNothing);
  });

  testWidgets('When is phone as click to back should call pop', (widgetTester) async {
    widgetTester.view.physicalSize = const Size(460, 800);
    widgetTester.view.devicePixelRatio = 1.0;
    bloc.mockStream(VersionsState(songbook: getFakeSongbook(isPublic: true)));

    final nav = NavMock.getDummy();

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<VersionsBloc>.value(
        value: bloc,
        child: VersionsScreen(
          isTablet: false,
          listOptionsBottomSheet: bottomSheet,
          songbookId: 1,
        ),
      ),
      nav: nav,
    );

    final finder = find.byWidgetPredicate(
      (Widget widget) =>
          widget is SvgPicture &&
          widget.pictureProvider is ExactAssetPicture &&
          (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.backArrowIcon,
      description: 'widget with back arrow',
    );
    expect(finder, findsOneWidget);

    await widgetTester.tap(finder, warnIfMissed: false);
    await widgetTester.pumpAndSettle();

    verify(nav.pop).called(1);
  });

  testWidgets('When click in share should call lib', (widgetTester) async {
    widgetTester.view.physicalSize = const Size(460, 800);
    widgetTester.view.devicePixelRatio = 1.0;
    bloc.mockStream(VersionsState(songbook: getFakeSongbook(isPublic: true)));

    final nav = NavMock.getDummy();

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<VersionsBloc>.value(
        value: bloc,
        child: VersionsScreen(
          isTablet: false,
          listOptionsBottomSheet: bottomSheet,
          songbookId: 1,
          userId: 1,
        ),
      ),
      nav: nav,
    );

    final finder = find.byWidgetPredicate(
      (Widget widget) =>
          widget is SvgPicture &&
          widget.pictureProvider is ExactAssetPicture &&
          (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.shareIcon,
      description: 'share icon',
    );
    expect(finder, findsOneWidget);

    await widgetTester.tap(finder, warnIfMissed: false);

    verify(() => bloc.shareLink(any(), any())).called(1);
  });

  testWidgets('When click in options should call options bottom sheet', (widgetTester) async {
    widgetTester.view.physicalSize = const Size(460, 800);
    widgetTester.view.devicePixelRatio = 1.0;
    final songbook = getFakeSongbook(isPublic: true);
    bloc.mockStream(VersionsState(songbook: songbook));

    final nav = NavMock.getDummy();

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<VersionsBloc>.value(
        value: bloc,
        child: VersionsScreen(
          isTablet: false,
          listOptionsBottomSheet: bottomSheet,
          songbookId: 1,
          userId: 1,
        ),
      ),
      nav: nav,
    );

    final finder = find.byWidgetPredicate(
      (Widget widget) =>
          widget is SvgPicture &&
          widget.pictureProvider is ExactAssetPicture &&
          (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.overflowIcon,
      description: 'overflow icon',
    );
    expect(finder, findsOneWidget);

    await widgetTester.tap(finder);

    verify(() => bottomSheet.open(
        context: any(named: 'context'),
        isUserList: true,
        ccid: 1,
        songbook: songbook,
        haveEditMode: true,
        onDeleteSongbook: any(named: 'onDeleteSongbook'))).called(1);
  });

  testWidgets('When click in add should navigate to addVersionsToListScreen', (widgetTester) async {
    widgetTester.view.physicalSize = const Size(460, 800);
    widgetTester.view.devicePixelRatio = 1.0;
    bloc.mockStream(VersionsState(
      songbook: getFakeSongbook(
        isPublic: true,
      ),
      versionLimitState: ListLimitState.atWarning,
    ));

    final nav = NavMock.getDummy();

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<VersionsBloc>.value(
        value: bloc,
        child: VersionsScreen(
          isTablet: false,
          listOptionsBottomSheet: bottomSheet,
          songbookId: 1,
          userId: 1,
        ),
      ),
      nav: nav,
    );

    final finder = find.byWidgetPredicate(
      (Widget widget) =>
          widget is SvgPicture &&
          widget.pictureProvider is ExactAssetPicture &&
          (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.addIcon,
      description: 'add icon',
    );
    expect(finder, findsOneWidget);

    await widgetTester.tap(finder);

    verify(() => AddVersionsToListEntry.push(nav, 1));
  });

  testWidgets('When click in add and ListLimitState is reached should not navigate to addVersionsToListScreen ',
      (widgetTester) async {
    widgetTester.view.physicalSize = const Size(460, 800);
    widgetTester.view.devicePixelRatio = 1.0;
    bloc.mockStream(
        VersionsState(songbook: getFakeSongbook(isPublic: true), versionLimitState: ListLimitState.reached));

    final nav = NavMock.getDummy();

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<VersionsBloc>.value(
        value: bloc,
        child: VersionsScreen(
          isTablet: false,
          listOptionsBottomSheet: bottomSheet,
          songbookId: 1,
          userId: 1,
        ),
      ),
      nav: nav,
    );

    final finder = find.byWidgetPredicate(
      (Widget widget) =>
          widget is SvgPicture &&
          widget.pictureProvider is ExactAssetPicture &&
          (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.addIcon,
      description: 'add icon',
    );
    expect(finder, findsOneWidget);

    await widgetTester.tap(finder);
    await widgetTester.pumpAndSettle();
    verifyNever(() => AddVersionsToListEntry.push(nav, 1));
  });

  testWidgets("When versions is empty and click in search songs should navigate to addVersionsScreen",
      (widgetTester) async {
    widgetTester.view.physicalSize = const Size(460, 800);
    widgetTester.view.devicePixelRatio = 1.0;
    bloc.mockStream(VersionsState(songbook: getFakeSongbook(isPublic: true), versions: []));

    final nav = NavMock.getDummy();

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<VersionsBloc>.value(
        value: bloc,
        child: VersionsScreen(
          isTablet: false,
          listOptionsBottomSheet: bottomSheet,
          songbookId: 1,
          userId: 1,
        ),
      ),
      nav: nav,
    );

    expect(find.byType(ErrorDescriptionWidget), findsOneWidget);
    await widgetTester.tap(find.text(appTextEn.searchSongs));

    verify(() => AddVersionsToListEntry.push(nav, 1));
  });

  testWidgets("When tap on delete songbook and is phone should pop to previous screen", (widgetTester) async {
    widgetTester.view.physicalSize = const Size(460, 800);
    widgetTester.view.devicePixelRatio = 1.0;

    final deleteSongbookMock = _DeleteSongbookMock();
    when(() => deleteSongbookMock(any())).thenAnswer((_) => SynchronousFuture(const Ok(null)));

    bottomSheet = ListOptionsBottomSheet(
      _ClearVersionsFromSongbookMock(),
      deleteSongbookMock,
      _ShareLinkMock(),
      _UpdateSongbookDataMock(),
      _ValidateSongbookNameMock(),
      _EditListScreenBuilderMock(),
      _ClearRecentsMock(),
    );

    final songbook = getFakeSongbook();
    bloc.mockStream(VersionsState(songbook: getFakeSongbook(isPublic: true), versions: []));
    final nav = NavMock.getDummy();

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<VersionsBloc>.value(
        value: bloc,
        child: VersionsScreen(
          listOptionsBottomSheet: bottomSheet,
          isTablet: false,
          onDeleteSongbook: () {},
          songbookId: songbook.id,
        ),
      ),
      nav: nav,
    );

    final finder = find.byWidgetPredicate(
      (Widget widget) =>
          widget is SvgPicture &&
          widget.pictureProvider is ExactAssetPicture &&
          (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.overflowIcon,
      description: 'overflow icon',
    );
    expect(finder, findsOneWidget);

    await widgetTester.tap(finder);
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.text(appTextEn.deleteList));
    await widgetTester.pumpAndSettle();

    expect(find.byType(DeleteDialog), findsOneWidget);

    await widgetTester.tap(find.widgetWithText(CifraClubButton, appTextEn.yes));
    await widgetTester.pumpAndSettle();

    verify(nav.pop).called(1);
  });

  testWidgets("When tap on delete songbook and is tablet should call onDeleteSongbook callback", (widgetTester) async {
    widgetTester.view.physicalSize = const Size(800, 1200);
    widgetTester.view.devicePixelRatio = 1.0;

    final deleteSongbookMock = _DeleteSongbookMock();
    when(() => deleteSongbookMock(any())).thenAnswer((_) => SynchronousFuture(const Ok(null)));
    final completer = Completer();

    bottomSheet = ListOptionsBottomSheet(
      _ClearVersionsFromSongbookMock(),
      deleteSongbookMock,
      _ShareLinkMock(),
      _UpdateSongbookDataMock(),
      _ValidateSongbookNameMock(),
      _EditListScreenBuilderMock(),
      _ClearRecentsMock(),
    );

    final songbook = getFakeSongbook();
    bloc.mockStream(VersionsState(songbook: getFakeSongbook(isPublic: true), versions: []));
    final nav = NavMock.getDummy();

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<VersionsBloc>.value(
        value: bloc,
        child: VersionsScreen(
          listOptionsBottomSheet: bottomSheet,
          isTablet: true,
          onDeleteSongbook: completer.complete,
          songbookId: songbook.id,
        ),
      ),
      nav: nav,
    );

    final finder = find.byWidgetPredicate(
      (Widget widget) =>
          widget is SvgPicture &&
          widget.pictureProvider is ExactAssetPicture &&
          (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.overflowIcon,
      description: 'overflow icon',
    );
    expect(finder, findsOneWidget);

    await widgetTester.tap(finder);
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.text(appTextEn.deleteList));
    await widgetTester.pumpAndSettle();

    expect(find.byType(DeleteDialog), findsOneWidget);

    await widgetTester.tap(find.widgetWithText(CifraClubButton, appTextEn.yes));
    await widgetTester.pumpAndSettle();

    expect(completer.isCompleted, isTrue);
  });

  testWidgets('When tap version options icon and tap delete, should delete version from songbook',
      (widgetTester) async {
    final version = getFakeVersion();
    bloc.mockStream(VersionsState(versions: [version], songbook: getFakeSongbook(isPublic: true)));

    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidgetWithWrapper(
        BlocProvider<VersionsBloc>.value(
          value: bloc,
          child: VersionsScreen(
            isTablet: true,
            listOptionsBottomSheet: bottomSheet,
            userId: 1,
            songbookId: 1,
          ),
        ),
      );
    });

    expect(find.byType(VersionTile), findsOneWidget);

    await widgetTester.tap(find.byKey(const Key("options-button")));
    await widgetTester.pumpAndSettle();

    expect(find.byType(ListVersionOptionsBottomSheet), findsOneWidget);

    await widgetTester.tap(find.byType(IconTextTile));
    await widgetTester.pumpAndSettle();

    expect(find.byType(ListOperationDialog), findsOneWidget);

    await widgetTester.tap(find.text(appTextEn.yes));
    await widgetTester.pumpAndSettle();

    expect(find.byType(ListOperationDialog), findsNothing);

    verify(() => bloc.deleteVersion(any(), any())).called(1);
  });

  testWidgets(
      'When click in add and ListLimitState is reached and user is pro should not navigate to AddVersionsToList screen ',
      (widgetTester) async {
    widgetTester.view.physicalSize = const Size(460, 800);
    widgetTester.view.devicePixelRatio = 1.0;
    bloc.mockStream(
      VersionsState(
        isPro: true,
        songbook: getFakeSongbook(isPublic: true),
        versionLimitState: ListLimitState.reached,
      ),
    );

    final nav = NavMock.getDummy();

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<VersionsBloc>.value(
        value: bloc,
        child: VersionsScreen(
          isTablet: false,
          listOptionsBottomSheet: bottomSheet,
          songbookId: 1,
          userId: 1,
        ),
      ),
      nav: nav,
    );

    final finder = find.byWidgetPredicate(
      (Widget widget) =>
          widget is SvgPicture &&
          widget.pictureProvider is ExactAssetPicture &&
          (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.addIcon,
      description: 'add icon',
    );
    expect(finder, findsOneWidget);

    await widgetTester.tap(finder);
    await widgetTester.pumpAndSettle();
    verifyNever(() => AddVersionsToListEntry.push(nav, 1));
  });

  testWidgets(
      'When click in add and navigate to AddVersionsToList screen when ListLimitState is not withinLimit should show limit warning snackbar',
      (widgetTester) async {
    widgetTester.view.physicalSize = const Size(460, 800);
    widgetTester.view.devicePixelRatio = 1.0;
    bloc.mockStream(
      VersionsState(
        isPro: false,
        songbook: getFakeSongbook(isPublic: true),
        versionLimitState: ListLimitState.withinLimit,
      ),
    );

    when(() => bloc.getListLimitState(any())).thenAnswer((_) => SynchronousFuture(ListLimitState.atWarning));

    final nav = NavMock.getDummy();

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<VersionsBloc>.value(
        value: bloc,
        child: VersionsScreen(
          isTablet: false,
          listOptionsBottomSheet: bottomSheet,
          songbookId: 1,
          userId: 1,
        ),
      ),
      nav: nav,
    );

    final finder = find.byWidgetPredicate(
      (Widget widget) =>
          widget is SvgPicture &&
          widget.pictureProvider is ExactAssetPicture &&
          (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.addIcon,
      description: 'add icon',
    );
    expect(finder, findsOneWidget);

    await widgetTester.tap(finder);

    await widgetTester.pump();
    expect(find.byType(LimitWarning), findsOneWidget);
    verify(() => AddVersionsToListEntry.push(nav, 1));
  });

  testWidgets("when tap version tile, should navigate to version screen", (widgetTester) async {
    final version = getFakeVersion(name: "a");
    bloc.mockStream(VersionsState(versions: [version], songbook: getFakeSongbook(isPublic: true)));
    final nav = NavMock.getDummy();

    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidgetWithWrapper(
        BlocProvider<VersionsBloc>.value(
          value: bloc,
          child: VersionsScreen(
            isTablet: true,
            listOptionsBottomSheet: bottomSheet,
            userId: 1,
            songbookId: 1,
          ),
        ),
        nav: nav,
      );
    });

    expect(find.byType(VersionTile, skipOffstage: false), findsOneWidget);
    await widgetTester.tap(find.byType(VersionTile), warnIfMissed: false);
    verify(() => VersionEntry.pushFromSong(nav, version.artist.url, version.songUrl, version.artist.name, version.name))
        .called(1);
  });
}
