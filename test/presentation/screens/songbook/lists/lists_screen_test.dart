import 'dart:async';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/dialogs/list_operation_dialogs/input_dialog.dart';
import 'package:cifraclub/presentation/dialogs/logout_dialog.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/add_versions_to_list_entry.dart';
import 'package:cifraclub/presentation/bottom_sheets/list_options_bottom_sheet.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/lists_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/lists_screen.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/lists_state.dart';
import 'package:cifraclub/presentation/dialogs/list_operation_dialogs/clear_dialog.dart';
import 'package:cifraclub/presentation/dialogs/list_operation_dialogs/delete_dialog.dart';
import 'package:cifraclub/presentation/widgets/icon_text_tile.dart';
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

void main() {
  late ListsBloc bloc;
  final songbookFake = getFakeSongbook();

  setUpAll(() {
    registerFallbackValue(getFakeSongbook());
    bloc = _ListsBlocMock();
    when(bloc.init).thenReturn(null);
    when(bloc.openLoginPage).thenReturn(null);
    when(bloc.openUserProfilePage).thenReturn(null);
    when(() => bloc.deleteSongbook(any())).thenAnswer((_) => SynchronousFuture(null));
    when(bloc.logout).thenAnswer((_) => SynchronousFuture(null));
    when(() => bloc.updateSongbookData(
        songbook: any(named: "songbook"),
        isPublic: any(named: "isPublic"),
        songbookName: any(named: "songbookName"))).thenAnswer((_) => SynchronousFuture(const Ok(null)));
    when(bloc.close).thenAnswer((_) => SynchronousFuture(null));
    when(() => bloc.createNewSongbook(any())).thenAnswer((_) => SynchronousFuture(Ok(songbookFake)));
    when(() => bloc.isValidSongbookName(any())).thenAnswer((_) => SynchronousFuture(true));
    when(bloc.initListLimitStreams).thenAnswer((_) => SynchronousFuture(null));
  });

  testWidgets("When user is logged out, should open login when tapping user card", (widgetTester) async {
    bloc.mockStream(const ListsState(user: null));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<ListsBloc>.value(
        value: bloc,
        child: ListsScreen(onTapSongbook: (_) {}),
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
        child: ListsScreen(onTapSongbook: (_) {}),
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
        child: ListsScreen(onTapSongbook: (_) {}),
      ),
    );

    final logoutFinder = find.byWidgetPredicate(
      (Widget widget) => widget is SvgImage && widget.assetPath == AppSvgs.logoutIcon,
    );
    expect(logoutFinder, findsOneWidget);

    await widgetTester.pumpAndSettle();
    await widgetTester.tap(logoutFinder);

    await widgetTester.pumpAndSettle();
    expect(find.byType(LogoutDialog), findsOneWidget);

    await widgetTester.tap(find.widgetWithText(CifraClubButton, "Log out"));
    verify(() => bloc.logout()).called(1);
  });

  testWidgets(
      "Tapping add icon should open InputDialog and create a new songbook and navigate to addCifrasToList screen",
      (widgetTester) async {
    bloc.mockStream(const ListsState());
    var newSongbookName = "list";
    final nav = NavMock.getDummy();

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<ListsBloc>.value(
        value: bloc,
        child: ListsScreen(
          onTapSongbook: (_) {},
        ),
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
    verify(() => bloc.createNewSongbook(newSongbookName)).called(1);
    verify(() => nav.push(
          screenName: AddVersionsToListEntry.name,
          params: AddVersionsToListEntry.declareParams(songbookFake.id!),
        )).called(1);
  });

  testWidgets("Tapping add icon and songbook is repeated should show a dialog with information", (widgetTester) async {
    bloc.mockStream(const ListsState());
    var newSongbookName = "list";
    when(() => bloc.isValidSongbookName(any())).thenAnswer((_) => SynchronousFuture(false));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<ListsBloc>.value(
        value: bloc,
        child: ListsScreen(
          onTapSongbook: (_) {},
        ),
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
        child: ListsScreen(
          onTapSongbook: (_) {},
        ),
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

  testWidgets("Tapping songbook tile should call delete songbook", (widgetTester) async {
    final songbook = getFakeSongbook();
    bloc.mockStream(ListsState(userLists: [getFakeSongbook(), songbook]));
    final complete = Completer();

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<ListsBloc>.value(
        value: bloc,
        child: ListsScreen(onTapSongbook: (_) {
          complete.complete();
        }),
      ),
    );

    final songbookTile = find.text(songbook.name, skipOffstage: false);
    expect(songbookTile, findsOneWidget);

    await widgetTester.pumpAndSettle();
    await widgetTester.tap(songbookTile);

    expect(complete.isCompleted, isTrue);
  });

  testWidgets("When tap on renameList option should call `updateSongbookData`", (widgetTester) async {
    final songbook = getFakeSongbook();
    bloc.mockStream(ListsState(userLists: [songbook]));
    when(() => bloc.isValidSongbookName(any())).thenAnswer((_) => SynchronousFuture(true));
    const newSongbookName = "new songbook name";

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<ListsBloc>.value(
        value: bloc,
        child: ListsScreen(
          onTapSongbook: (_) {},
        ),
      ),
    );

    final optionsIconFinder = find.byWidgetPredicate((widget) =>
        widget is SvgPicture &&
        widget.pictureProvider is ExactAssetPicture &&
        (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.songbookOptionsIcon);
    expect(optionsIconFinder, findsOneWidget);

    await widgetTester.tap(optionsIconFinder);
    await widgetTester.pumpAndSettle();

    expect(find.byType(ListOptionsBottomSheet), findsOneWidget);
    final renameListTile = find.byType(IconTextTile).at(0);
    expect(renameListTile, findsOneWidget);

    await widgetTester.tap(renameListTile);
    await widgetTester.pumpAndSettle();

    expect(find.byType(InputDialog), findsOneWidget);

    await widgetTester.enterText(find.byType(CosmosInputField), newSongbookName);
    await widgetTester.pumpAndSettle();

    expect(find.text(newSongbookName), findsOneWidget);

    await widgetTester.tap(find.widgetWithText(CifraClubButton, appTextEn.save));
    verify(() => bloc.updateSongbookData(songbook: songbook, songbookName: newSongbookName)).called(1);
  });

  testWidgets("When tap on renameList option and name is repeated should show snackbar message", (widgetTester) async {
    final songbook = getFakeSongbook();
    bloc.mockStream(ListsState(userLists: [songbook]));
    when(() => bloc.isValidSongbookName(any())).thenAnswer((_) => SynchronousFuture(false));
    const newSongbookName = "new songbook name";

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<ListsBloc>.value(
        value: bloc,
        child: ListsScreen(
          onTapSongbook: (_) {},
        ),
      ),
    );

    final optionsIconFinder = find.byWidgetPredicate((widget) =>
        widget is SvgPicture &&
        widget.pictureProvider is ExactAssetPicture &&
        (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.songbookOptionsIcon);
    expect(optionsIconFinder, findsOneWidget);

    await widgetTester.tap(optionsIconFinder);
    await widgetTester.pumpAndSettle();

    expect(find.byType(ListOptionsBottomSheet), findsOneWidget);
    final renameListTile = find.byType(IconTextTile).at(0);
    expect(renameListTile, findsOneWidget);

    await widgetTester.tap(renameListTile);
    await widgetTester.pumpAndSettle();

    expect(find.byType(InputDialog), findsOneWidget);

    await widgetTester.enterText(find.byType(CosmosInputField), newSongbookName);
    await widgetTester.pumpAndSettle();

    expect(find.text(newSongbookName), findsOneWidget);

    await widgetTester.tap(find.widgetWithText(CifraClubButton, appTextEn.save));
    await widgetTester.pump();

    expect(find.text(appTextEn.listUsedName), findsOneWidget);
    expect(find.byType(InputDialog), findsOneWidget);
  });

  testWidgets("When tap on renameList option return api error should show snackbar", (widgetTester) async {
    final songbook = getFakeSongbook();
    bloc.mockStream(ListsState(userLists: [songbook]));
    const newSongbookName = "new songbook name";
    when(() => bloc.isValidSongbookName(any())).thenAnswer((_) => SynchronousFuture(true));
    when(() => bloc.updateSongbookData(songbook: songbook, songbookName: newSongbookName))
        .thenAnswer((_) => SynchronousFuture(Err(ServerError(statusCode: 404))));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<ListsBloc>.value(
        value: bloc,
        child: ListsScreen(
          onTapSongbook: (_) {},
        ),
      ),
    );

    final optionsIconFinder = find.byWidgetPredicate((widget) =>
        widget is SvgPicture &&
        widget.pictureProvider is ExactAssetPicture &&
        (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.songbookOptionsIcon);
    expect(optionsIconFinder, findsOneWidget);

    await widgetTester.tap(optionsIconFinder);
    await widgetTester.pumpAndSettle();

    expect(find.byType(ListOptionsBottomSheet), findsOneWidget);
    final renameListTile = find.byType(IconTextTile).at(0);
    expect(renameListTile, findsOneWidget);

    await widgetTester.tap(renameListTile);
    await widgetTester.pumpAndSettle();

    expect(find.byType(InputDialog), findsOneWidget);

    await widgetTester.enterText(find.byType(CosmosInputField), newSongbookName);
    await widgetTester.pumpAndSettle();

    expect(find.text(newSongbookName), findsOneWidget);

    await widgetTester.tap(find.widgetWithText(CifraClubButton, appTextEn.save));
    await widgetTester.pumpAndSettle();

    expect(find.text(appTextEn.listServerError), findsOneWidget);
    expect(find.byType(InputDialog), findsOneWidget);
  });

  testWidgets("When tap on deleteList option should delete a songbook", (widgetTester) async {
    final songbook = getFakeSongbook();
    bloc.mockStream(ListsState(userLists: [songbook]));
    when(() => bloc.isValidSongbookName(any())).thenAnswer((_) => SynchronousFuture(false));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<ListsBloc>.value(
        value: bloc,
        child: ListsScreen(
          onTapSongbook: (_) {},
        ),
      ),
    );

    final optionsIconFinder = find.byWidgetPredicate((widget) =>
        widget is SvgPicture &&
        widget.pictureProvider is ExactAssetPicture &&
        (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.songbookOptionsIcon);
    expect(optionsIconFinder, findsOneWidget);

    await widgetTester.tap(optionsIconFinder);
    await widgetTester.pumpAndSettle();

    expect(find.byType(ListOptionsBottomSheet), findsOneWidget);
    final renameListTile = find.byType(IconTextTile).at(2);
    expect(renameListTile, findsOneWidget);

    await widgetTester.tap(renameListTile);
    await widgetTester.pumpAndSettle();

    expect(find.byType(DeleteDialog), findsOneWidget);

    await widgetTester.tap(find.widgetWithText(CifraClubButton, appTextEn.yes));
    await widgetTester.pump();

    verify(() => bloc.deleteSongbook(songbook.id)).called(1);
  });

  testWidgets("When tap on clear option should clear list of songs", (widgetTester) async {
    final songbook = getFakeSongbook();
    bloc.mockStream(ListsState(userLists: [songbook]));
    when(() => bloc.clearList(any())).thenAnswer((_) => SynchronousFuture(null));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<ListsBloc>.value(
        value: bloc,
        child: ListsScreen(
          onTapSongbook: (_) {},
        ),
      ),
    );

    final optionsIconFinder = find.byWidgetPredicate((widget) =>
        widget is SvgPicture &&
        widget.pictureProvider is ExactAssetPicture &&
        (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.songbookOptionsIcon);
    expect(optionsIconFinder, findsOneWidget);

    await widgetTester.tap(optionsIconFinder);
    await widgetTester.pumpAndSettle();

    expect(find.byType(ListOptionsBottomSheet), findsOneWidget);
    final clearListTile = find.byType(IconTextTile).at(1);
    expect(clearListTile, findsOneWidget);

    await widgetTester.tap(clearListTile);
    await widgetTester.pumpAndSettle();

    expect(find.byType(ClearDialog), findsOneWidget);

    await widgetTester.tap(find.widgetWithText(CifraClubButton, appTextEn.yes));
    await widgetTester.pump();

    verify(() => bloc.clearList(songbook.id)).called(1);
  });
}
