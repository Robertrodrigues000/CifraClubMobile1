import 'dart:async';

import 'package:cifraclub/domain/app/use_cases/share_link.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/use_cases/clear_songs_from_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/delete_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/update_songbook_data.dart';
import 'package:cifraclub/domain/songbook/use_cases/validate_songbook_name.dart';
import 'package:cifraclub/presentation/bottom_sheets/list_options_bottom_sheet.dart';
import 'package:cifraclub/presentation/bottom_sheets/list_options_bottom_sheet_bloc.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/dialogs/list_operation_dialogs/delete_dialog.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/add_versions_to_list_entry.dart';
import 'package:cifraclub/presentation/screens/songbook/edit_list/edit_list_screen_builder.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_screen.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_state.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/widgets/empty_list_empty_state.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/widgets/version_tile.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/widgets/versions_collapsed_header.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/widgets/versions_fixed_header.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/cifraclub_button.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
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

class _ClearSongsFromSongbookMock extends Mock implements ClearSongsFromSongbook {}

class _ShareLinkMock extends Mock implements ShareLink {}

class _DeleteSongbookMock extends Mock implements DeleteSongbook {}

class _UpdateSongbookDataMock extends Mock implements UpdateSongbookData {}

class _ValidateSongbookNameMock extends Mock implements ValidateSongbookName {}

class _ListOptionsBottomSheetBlocMock extends Mock implements ListOptionsBottomSheetBloc {}

class _EditListScreenBuilderMock extends Mock implements EditListScreenBuilder {}

void main() {
  late VersionsBloc bloc;
  late ListOptionsBottomSheet bottomSheet;
  late _ListOptionsBottomSheetBlocMock blocBottomSheet;
  final TestWidgetsFlutterBinding binding = TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    registerFallbackValue(_BuildContextMock());
    registerFallbackValue(getFakeSongbook());

    blocBottomSheet = _ListOptionsBottomSheetBlocMock();
    when(() => blocBottomSheet.deleteSongbook(any())).thenAnswer((_) => SynchronousFuture(true));
    when(blocBottomSheet.close).thenAnswer((_) => SynchronousFuture(null));

    final bottomSheetMock = _ListOptionBottomSheetMock();
    when(() => bottomSheetMock.open(
        context: any(named: 'context'),
        isUserList: any(named: 'isUserList'),
        ccid: any(named: 'ccid'),
        onDeleteSongbook: any(named: 'onDeleteSongbook'),
        songbook: any(named: 'songbook'))).thenAnswer((_) => SynchronousFuture(null));
    bottomSheet = bottomSheetMock;

    bloc = _VersionsBlocMock();
    when(() => bloc.init(any())).thenAnswer((_) => SynchronousFuture(null));
    when(() => bloc.shareLink(any(), any())).thenAnswer((_) => SynchronousFuture(null));
    when(bloc.close).thenAnswer((_) => SynchronousFuture(null));
  });

  testWidgets('When scroll up should show serach bar', (widgetTester) async {
    bloc.mockStream(VersionsState(versions: [getFakeVersion(), getFakeVersion()], songbook: getFakeSongbook()));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<VersionsBloc>.value(
        value: bloc,
        child: VersionsScreen(
          isTablet: true,
          listOptionsbottomSheet: bottomSheet,
          songbookId: 1,
        ),
      ),
    );

    await widgetTester.drag(find.byType(CustomScrollView).first, const Offset(0, 100));
    await widgetTester.pumpAndSettle();

    expect(find.byType(CosmosSearchBar), findsOneWidget);
  });

  testWidgets('When start should load screen correctly', (widgetTester) async {
    bloc.mockStream(VersionsState(versions: [getFakeVersion(), getFakeVersion()], songbook: getFakeSongbook()));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<VersionsBloc>.value(
        value: bloc,
        child: VersionsScreen(
          isTablet: true,
          listOptionsbottomSheet: bottomSheet,
          songbookId: 1,
        ),
      ),
    );

    expect(find.byType(CosmosSearchBar), findsNothing);
    expect(find.byType(VersionsCollapsedHeader), findsOneWidget);
    expect(find.byType(VersionsFixedHeader), findsOneWidget);
    expect(find.byType(VersionTile), findsNWidgets(2));
  });

  testWidgets('When start and sonbook is private should not show share icon should omit the share icon',
      (widgetTester) async {
    bloc.mockStream(
        VersionsState(versions: [getFakeVersion(), getFakeVersion()], songbook: getFakeSongbook(isPublic: false)));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<VersionsBloc>.value(
        value: bloc,
        child: VersionsScreen(
          isTablet: true,
          listOptionsbottomSheet: bottomSheet,
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
          listOptionsbottomSheet: bottomSheet,
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
    // ignore: deprecated_member_use
    binding.window.physicalSizeTestValue = const Size(460, 800);
    // ignore: deprecated_member_use
    binding.window.devicePixelRatioTestValue = 1.0;
    bloc.mockStream(VersionsState(songbook: getFakeSongbook(isPublic: true)));

    final nav = NavMock.getDummy();

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<VersionsBloc>.value(
        value: bloc,
        child: VersionsScreen(
          isTablet: false,
          listOptionsbottomSheet: bottomSheet,
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
    // ignore: deprecated_member_use
    binding.window.physicalSizeTestValue = const Size(460, 800);
    // ignore: deprecated_member_use
    binding.window.devicePixelRatioTestValue = 1.0;
    bloc.mockStream(VersionsState(songbook: getFakeSongbook(isPublic: true)));

    final nav = NavMock.getDummy();

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<VersionsBloc>.value(
        value: bloc,
        child: VersionsScreen(
          isTablet: false,
          listOptionsbottomSheet: bottomSheet,
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

    await widgetTester.tap(finder);

    verify(() => bloc.shareLink(any(), any())).called(1);
  });

  testWidgets('When click in options should call options bottom sheet', (widgetTester) async {
    // ignore: deprecated_member_use
    binding.window.physicalSizeTestValue = const Size(460, 800);
    // ignore: deprecated_member_use
    binding.window.devicePixelRatioTestValue = 1.0;
    final songbook = getFakeSongbook(isPublic: true);
    bloc.mockStream(VersionsState(songbook: songbook));

    final nav = NavMock.getDummy();

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<VersionsBloc>.value(
        value: bloc,
        child: VersionsScreen(
          isTablet: false,
          listOptionsbottomSheet: bottomSheet,
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
        haveEditMode: false,
        onDeleteSongbook: any(named: 'onDeleteSongbook'))).called(1);
  });

  testWidgets('When click in add should navigate to addCifrasTolistScreen', (widgetTester) async {
    // ignore: deprecated_member_use
    binding.window.physicalSizeTestValue = const Size(460, 800);
    // ignore: deprecated_member_use
    binding.window.devicePixelRatioTestValue = 1.0;
    bloc.mockStream(VersionsState(songbook: getFakeSongbook(isPublic: true)));

    final nav = NavMock.getDummy();

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<VersionsBloc>.value(
        value: bloc,
        child: VersionsScreen(
          isTablet: false,
          listOptionsbottomSheet: bottomSheet,
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

    verify(() => nav.push(screenName: AddVersionsToListEntry.name, params: AddVersionsToListEntry.declareParams(1)));
  });

  testWidgets("When versions is empty and click in serch songs should navigato to addVersionsScreen",
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
          listOptionsbottomSheet: bottomSheet,
          songbookId: 1,
          userId: 1,
        ),
      ),
      nav: nav,
    );

    expect(find.byType(EmptyListEmptyState), findsOneWidget);
    await widgetTester.tap(find.text(appTextEn.searchSongs));

    verify(() => nav.push(screenName: AddVersionsToListEntry.name, params: AddVersionsToListEntry.declareParams(1)));
  });

  testWidgets("When tap on delete songbook and is phone should pop to previus screen", (widgetTester) async {
    // ignore: deprecated_member_use
    binding.window.physicalSizeTestValue = const Size(460, 800);
    // ignore: deprecated_member_use
    binding.window.devicePixelRatioTestValue = 1.0;

    final deleteSongbookMock = _DeleteSongbookMock();
    when(() => deleteSongbookMock(any())).thenAnswer((_) => SynchronousFuture(const Ok(null)));

    bottomSheet = ListOptionsBottomSheet(
      _ClearSongsFromSongbookMock(),
      deleteSongbookMock,
      _ShareLinkMock(),
      _UpdateSongbookDataMock(),
      _ValidateSongbookNameMock(),
      _EditListScreenBuilderMock(),
    );

    final songbook = getFakeSongbook();
    bloc.mockStream(VersionsState(songbook: getFakeSongbook(isPublic: true), versions: []));
    final nav = NavMock.getDummy();

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<VersionsBloc>.value(
        value: bloc,
        child: VersionsScreen(
          listOptionsbottomSheet: bottomSheet,
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
    // ignore: deprecated_member_use
    binding.window.physicalSizeTestValue = const Size(800, 1200);
    // ignore: deprecated_member_use
    binding.window.devicePixelRatioTestValue = 1.0;

    final deleteSongbookMock = _DeleteSongbookMock();
    when(() => deleteSongbookMock(any())).thenAnswer((_) => SynchronousFuture(const Ok(null)));
    final completer = Completer();

    bottomSheet = ListOptionsBottomSheet(
      _ClearSongsFromSongbookMock(),
      deleteSongbookMock,
      _ShareLinkMock(),
      _UpdateSongbookDataMock(),
      _ValidateSongbookNameMock(),
      _EditListScreenBuilderMock(),
    );

    final songbook = getFakeSongbook();
    bloc.mockStream(VersionsState(songbook: getFakeSongbook(isPublic: true), versions: []));
    final nav = NavMock.getDummy();

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<VersionsBloc>.value(
        value: bloc,
        child: VersionsScreen(
          listOptionsbottomSheet: bottomSheet,
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
}
