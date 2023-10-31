import 'dart:async';
import 'package:cifraclub/domain/app/use_cases/share_link.dart';
import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/use_cases/clear_versions_from_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/delete_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/update_songbook_data.dart';
import 'package:cifraclub/domain/songbook/use_cases/validate_songbook_name.dart';
import 'package:cifraclub/presentation/bottom_sheets/list_options_bottom_sheet/list_options_bottom_sheet_bloc.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/dialogs/list_limit_dialog.dart';
import 'package:cifraclub/presentation/dialogs/list_limit_pro_dialog.dart';
import 'package:cifraclub/presentation/dialogs/list_operation_dialogs/delete_dialog.dart';
import 'package:cifraclub/presentation/dialogs/list_operation_dialogs/input_dialog.dart';
import 'package:cifraclub/presentation/dialogs/logout_dialog.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/add_versions_to_list_entry.dart';
import 'package:cifraclub/presentation/bottom_sheets/list_options_bottom_sheet/list_options_bottom_sheet.dart';
import 'package:cifraclub/presentation/screens/songbook/edit_list/edit_list_screen_builder.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/lists_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/lists_screen.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/lists_state.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/user_list_item.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/cifraclub_button.dart';
import 'package:cifraclub/presentation/widgets/svg_image.dart';
import 'package:cifraclub/presentation/widgets/user_card.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../../shared_mocks/domain/songbook/models/songbook_mock.dart';
import '../../../../shared_mocks/domain/user/models/user_mock.dart';
import '../../../../shared_mocks/presentation/navigator/nav_mock.dart';
import '../../../../test_helpers/app_localizations.dart';
import '../../../../test_helpers/bloc_stream.dart';
import '../../../../test_helpers/test_wrapper.dart';

class _ListsBlocMock extends Mock implements ListsBloc {}

class _ListOptionBottomSheetMock extends Mock implements ListOptionsBottomSheet {}

class _BuildContextMock extends Mock implements BuildContext {}

class _ClearVersionFromSongbookMock extends Mock implements ClearVersionsFromSongbook {}

class _ShareLinkMock extends Mock implements ShareLink {}

class _DeleteSongbookMock extends Mock implements DeleteSongbook {}

class _UpdateSongbookDataMock extends Mock implements UpdateSongbookData {}

class _ValidateSongbookNameMock extends Mock implements ValidateSongbookName {}

class _ListOptionsBottomSheetBlocMock extends Mock implements ListOptionsBottomSheetBloc {}

class _EditListScreenBuilderMock extends Mock implements EditListScreenBuilder {}

void main() {
  late ListsBloc bloc;
  late ListOptionsBottomSheet bottomSheet;
  late _ListOptionsBottomSheetBlocMock blocBottomSheet;
  final songbookFake = getFakeSongbook();

  setUpAll(() {
    registerFallbackValue(_BuildContextMock());
    registerFallbackValue(getFakeSongbook());

    final bottomSheetMock = _ListOptionBottomSheetMock();
    when(() => bottomSheetMock.open(
        context: any(named: 'context'),
        isUserList: any(named: 'isUserList'),
        ccid: any(named: 'ccid'),
        onDeleteSongbook: any(named: 'onDeleteSongbook'),
        songbook: any(named: 'songbook'))).thenAnswer((_) => SynchronousFuture(null));

    registerFallbackValue(getFakeSongbook());
    bloc = _ListsBlocMock();
    when(bloc.init).thenReturn(null);
    when(bloc.openLoginPage).thenReturn(null);
    when(bloc.openUserProfilePage).thenReturn(null);
    when(() => bloc.validatePreview(any())).thenReturn([]);
    when(bloc.logout).thenAnswer((_) => SynchronousFuture(null));
    when(bloc.close).thenAnswer((_) => SynchronousFuture(null));
    when(() => bloc.createNewSongbook(any())).thenAnswer((_) => SynchronousFuture(Ok(songbookFake)));
    when(() => bloc.isValidSongbookName(any())).thenAnswer((_) => SynchronousFuture(true));
    when(bloc.initListLimitStreams).thenAnswer((_) => SynchronousFuture(null));

    blocBottomSheet = _ListOptionsBottomSheetBlocMock();
    when(() => blocBottomSheet.deleteSongbook(any())).thenAnswer((_) => SynchronousFuture(true));
    when(blocBottomSheet.close).thenAnswer((_) => SynchronousFuture(null));

    bottomSheet = bottomSheetMock;
  });

  testWidgets("When user is logged out, should open login when tapping user card", (widgetTester) async {
    bloc.mockStream(const ListsState(user: null));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<ListsBloc>.value(
        value: bloc,
        child: ListsScreen(onTapSongbook: (_) {}, listOptionsBottomSheet: bottomSheet, isTablet: false),
      ),
    );

    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.byType(UserCard, skipOffstage: false));
    verify(bloc.openLoginPage).called(1);
  });

  testWidgets("When user is logged in and user card is tapped, should open profile", (widgetTester) async {
    bloc.mockStream(ListsState(user: getFakeUser()));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<ListsBloc>.value(
        value: bloc,
        child: ListsScreen(onTapSongbook: (_) {}, listOptionsBottomSheet: bottomSheet, isTablet: false),
      ),
    );

    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.byType(UserCard));
    verify(bloc.openUserProfilePage).called(1);
  });

  testWidgets("When user is logged in and logout button is tapped, should open LogoutDialog", (widgetTester) async {
    bloc.mockStream(ListsState(user: getFakeUser()));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<ListsBloc>.value(
        value: bloc,
        child: ListsScreen(onTapSongbook: (_) {}, listOptionsBottomSheet: bottomSheet, isTablet: false),
      ),
    );

    final logoutFinder = find.byWidgetPredicate(
      (Widget widget) => widget is SvgImage && widget.assetPath == AppSvgs.logoutIcon,
    );
    expect(logoutFinder, findsOneWidget);

    await widgetTester.pumpAndSettle();
    await widgetTester.tap(logoutFinder, warnIfMissed: false);

    await widgetTester.pumpAndSettle();
    expect(find.byType(LogoutDialog), findsOneWidget);

    await widgetTester.tap(find.widgetWithText(CifraClubButton, "Log out"));
    verify(() => bloc.logout()).called(1);
  });

  testWidgets(
      "Tapping add icon should open InputDialog and create a new songbook and navigate to addCifrasToList screen",
      (widgetTester) async {
    bloc.mockStream(
      const ListsState(shouldShowLimitToast: true, listState: ListLimitState.atWarning),
    );
    var newSongbookName = "list";
    final nav = NavMock.getDummy();

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<ListsBloc>.value(
        value: bloc,
        child: ListsScreen(onTapSongbook: (_) {}, listOptionsBottomSheet: bottomSheet, isTablet: false),
      ),
      nav: nav,
    );

    final addIconFinder = find.byWidgetPredicate((widget) =>
        widget is SvgPicture &&
        widget.pictureProvider is ExactAssetPicture &&
        (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.addIcon);
    expect(addIconFinder, findsOneWidget);

    await widgetTester.tap(addIconFinder);
    await widgetTester.pumpAndSettle();

    expect(find.byType(InputDialog), findsOneWidget);
    expect(find.byType(CosmosInputField), findsOneWidget);

    await widgetTester.enterText(find.byType(CosmosInputField), newSongbookName);
    await widgetTester.pumpAndSettle();

    expect(find.text(newSongbookName), findsOneWidget);

    await widgetTester.tap(find.widgetWithText(CifraClubButton, appTextEn.create));
    await widgetTester.pumpAndSettle();
    verify(() => bloc.createNewSongbook(newSongbookName)).called(1);
    verify(() => AddVersionsToListEntry.push(nav, songbookFake.id!)).called(1);
  });

  testWidgets("Tapping add icon should should show LimitDialog if ListLimitState is reached", (widgetTester) async {
    bloc.mockStream(const ListsState(listState: ListLimitState.reached, shouldShowLimitToast: false));
    final nav = NavMock.getDummy();

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<ListsBloc>.value(
        value: bloc,
        child: ListsScreen(onTapSongbook: (_) {}, listOptionsBottomSheet: bottomSheet, isTablet: false),
      ),
      nav: nav,
    );

    final addIconFinder = find.byWidgetPredicate((widget) =>
        widget is SvgPicture &&
        widget.pictureProvider is ExactAssetPicture &&
        (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.addIcon);
    expect(addIconFinder, findsOneWidget);

    await widgetTester.tap(addIconFinder, warnIfMissed: false);
    await widgetTester.pumpAndSettle();

    expect(find.byType(InputDialog), findsNothing);
    expect(find.byType(CosmosInputField), findsNothing);
    expect(find.byType(ListLimitDialog), findsOneWidget);
  });

  testWidgets("Tapping add icon should should show LimitDialog if ListLimitState is reached and user is pro",
      (widgetTester) async {
    bloc.mockStream(const ListsState(listState: ListLimitState.reached, shouldShowLimitToast: false, isPro: true));
    final nav = NavMock.getDummy();

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<ListsBloc>.value(
        value: bloc,
        child: ListsScreen(onTapSongbook: (_) {}, listOptionsBottomSheet: bottomSheet, isTablet: false),
      ),
      nav: nav,
    );

    final addIconFinder = find.byWidgetPredicate((widget) =>
        widget is SvgPicture &&
        widget.pictureProvider is ExactAssetPicture &&
        (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.addIcon);
    expect(addIconFinder, findsOneWidget);

    await widgetTester.tap(addIconFinder, warnIfMissed: false);
    await widgetTester.pumpAndSettle();

    expect(find.byType(InputDialog), findsNothing);
    expect(find.byType(CosmosInputField), findsNothing);
    expect(find.byType(ListLimitProDialog), findsOneWidget);
  });
  testWidgets("Tapping add icon and songbook is repeated should show a dialog with information", (widgetTester) async {
    bloc.mockStream(const ListsState());
    var newSongbookName = "list";
    when(() => bloc.isValidSongbookName(any())).thenAnswer((_) => SynchronousFuture(false));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<ListsBloc>.value(
        value: bloc,
        child: ListsScreen(onTapSongbook: (_) {}, listOptionsBottomSheet: bottomSheet, isTablet: false),
      ),
    );

    final addIconFinder = find.byWidgetPredicate((widget) =>
        widget is SvgPicture &&
        widget.pictureProvider is ExactAssetPicture &&
        (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.addIcon);
    expect(addIconFinder, findsOneWidget);

    await widgetTester.tap(addIconFinder);
    await widgetTester.pumpAndSettle();

    expect(find.byType(InputDialog), findsOneWidget);
    expect(find.byType(CosmosInputField), findsOneWidget);

    await widgetTester.enterText(find.byType(CosmosInputField), newSongbookName);
    await widgetTester.pumpAndSettle();

    expect(find.text(newSongbookName), findsOneWidget);

    await widgetTester.tap(find.widgetWithText(CifraClubButton, appTextEn.create));
    await widgetTester.pump();

    expect(find.text(appTextEn.listUsedName), findsOneWidget);
    expect(find.byType(InputDialog), findsOneWidget);
  });

  testWidgets("Tapping add icon and return api error should show snackbar", (widgetTester) async {
    bloc.mockStream(const ListsState());
    var newSongbookName = "list";
    when(() => bloc.isValidSongbookName(any())).thenAnswer((_) => SynchronousFuture(true));
    when(() => bloc.createNewSongbook(newSongbookName))
        .thenAnswer((_) => SynchronousFuture(Err(ServerError(statusCode: 404))));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<ListsBloc>.value(
        value: bloc,
        child: ListsScreen(onTapSongbook: (_) {}, listOptionsBottomSheet: bottomSheet, isTablet: false),
      ),
    );

    final addIconFinder = find.byWidgetPredicate((widget) =>
        widget is SvgPicture &&
        widget.pictureProvider is ExactAssetPicture &&
        (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.addIcon);
    expect(addIconFinder, findsOneWidget);

    await widgetTester.tap(addIconFinder);
    await widgetTester.pumpAndSettle();

    expect(find.byType(InputDialog), findsOneWidget);
    expect(find.byType(CosmosInputField), findsOneWidget);

    await widgetTester.enterText(find.byType(CosmosInputField), newSongbookName);
    await widgetTester.pumpAndSettle();

    expect(find.text(newSongbookName), findsOneWidget);

    await widgetTester.tap(find.widgetWithText(CifraClubButton, appTextEn.create));
    await widgetTester.pumpAndSettle();

    expect(find.text(appTextEn.listServerError), findsOneWidget);
    expect(find.byType(InputDialog), findsOneWidget);
  });

  testWidgets("Tapping songbook tile should open version list screen", (widgetTester) async {
    final songbook = getFakeSongbook(name: "Teste");
    bloc.mockStream(ListsState(userLists: [getFakeSongbook(), songbook]));
    final complete = Completer();

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<ListsBloc>.value(
        value: bloc,
        child: ListsScreen(
            onTapSongbook: (_) {
              complete.complete();
            },
            listOptionsBottomSheet: bottomSheet,
            isTablet: false),
      ),
    );

    final songbookTile = find.text(songbook.name, skipOffstage: false);
    expect(songbookTile, findsOneWidget);

    await widgetTester.pumpAndSettle();
    await widgetTester.tap(songbookTile);

    expect(complete.isCompleted, isTrue);
  });

  testWidgets("When tap on songbook options should open bottom sheet", (widgetTester) async {
    final songbook = getFakeSongbook();
    bloc.mockStream(ListsState(userLists: [songbook]));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<ListsBloc>.value(
        value: bloc,
        child: ListsScreen(onTapSongbook: (_) {}, listOptionsBottomSheet: bottomSheet, isTablet: false),
      ),
    );

    final optionsIconFinder = find.byWidgetPredicate((widget) =>
        widget is SvgPicture &&
        widget.pictureProvider is ExactAssetPicture &&
        (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.songbookOptionsIcon);
    expect(optionsIconFinder, findsOneWidget);

    await widgetTester.tap(optionsIconFinder);
    await widgetTester.pumpAndSettle();

    verify(() => bottomSheet.open(
        context: any(named: 'context'),
        isUserList: true,
        ccid: null,
        songbook: songbook,
        onDeleteSongbook: any(named: 'onDeleteSongbook'))).called(1);
  });

  testWidgets("When tap on delete songbook and songbook is selected should call callback", (widgetTester) async {
    final deleteSongbookMock = _DeleteSongbookMock();
    when(() => deleteSongbookMock(any())).thenAnswer((_) => SynchronousFuture(const Ok(null)));
    final completer = Completer();

    bottomSheet = ListOptionsBottomSheet(
      _ClearVersionFromSongbookMock(),
      deleteSongbookMock,
      _ShareLinkMock(),
      _UpdateSongbookDataMock(),
      _ValidateSongbookNameMock(),
      _EditListScreenBuilderMock(),
    );

    final songbook = getFakeSongbook();
    bloc.mockStream(ListsState(userLists: [songbook], specialLists: [getFakeSongbook(listType: ListType.recents)]));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<ListsBloc>.value(
        value: bloc,
        child: ListsScreen(
          onTapSongbook: (_) {
            completer.complete();
          },
          listOptionsBottomSheet: bottomSheet,
          isTablet: true,
          selectedSongbookId: songbook.id,
        ),
      ),
    );

    expect(find.byType(UserListItem), findsOneWidget);

    final optionsIconFinder = find.byWidgetPredicate((widget) =>
        widget is SvgPicture &&
        widget.pictureProvider is ExactAssetPicture &&
        (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.songbookOptionsIcon);
    expect(optionsIconFinder, findsOneWidget);

    await widgetTester.tap(optionsIconFinder);
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.text(appTextEn.deleteList));
    await widgetTester.pumpAndSettle();

    expect(find.byType(DeleteDialog), findsOneWidget);

    await widgetTester.tap(find.widgetWithText(CifraClubButton, appTextEn.yes));
    await widgetTester.pumpAndSettle();

    expect(completer.isCompleted, isTrue);
  });
}
