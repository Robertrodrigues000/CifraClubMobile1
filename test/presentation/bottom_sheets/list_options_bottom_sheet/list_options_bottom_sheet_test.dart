import 'dart:async';

import 'package:cifraclub/domain/app/use_cases/share_link.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/clear_versions_from_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/delete_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/update_songbook_data.dart';
import 'package:cifraclub/domain/songbook/use_cases/validate_songbook_name.dart';
import 'package:cifraclub/presentation/bottom_sheets/list_options_bottom_sheet/list_options_bottom_sheet_bloc.dart';
import 'package:cifraclub/presentation/bottom_sheets/privacy_bottom_sheet.dart';
import 'package:cifraclub/presentation/constants/app_urls.dart';
import 'package:cifraclub/presentation/bottom_sheets/list_options_bottom_sheet/list_options_bottom_sheet.dart';
import 'package:cifraclub/presentation/dialogs/list_operation_dialogs/clear_dialog.dart';
import 'package:cifraclub/presentation/dialogs/list_operation_dialogs/delete_dialog.dart';
import 'package:cifraclub/presentation/dialogs/list_operation_dialogs/input_dialog.dart';
import 'package:cifraclub/presentation/screens/songbook/edit_list/edit_list_event.dart';
import 'package:cifraclub/presentation/screens/songbook/edit_list/edit_list_screen_builder.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/cifraclub_button.dart';
import 'package:cifraclub/presentation/widgets/icon_text_tile.dart';
import 'package:cifraclub/presentation/widgets/selectable_item.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/songbook/models/songbook_mock.dart';
import '../../../shared_mocks/presentation/navigator/nav_mock.dart';
import '../../../test_helpers/app_localizations.dart';
import '../../../test_helpers/bloc_stream.dart';
import '../../../test_helpers/test_wrapper.dart';

class _ClearVersionsFromSongbookMock extends Mock implements ClearVersionsFromSongbook {}

class _ShareLinkMock extends Mock implements ShareLink {}

class _DeleteSongbookMock extends Mock implements DeleteSongbook {}

class _UpdateSongbookDataMock extends Mock implements UpdateSongbookData {}

class _ValidateSongbookNameMock extends Mock implements ValidateSongbookName {}

class _ListOptionsBottomSheetBlocMock extends Mock implements ListOptionsBottomSheetBloc {}

class _EditListScreenBuilderMock extends Mock implements EditListScreenBuilder {}

class _BuildContextMock extends Mock implements BuildContext {}

void main() {
  late _ListOptionsBottomSheetBlocMock bloc;
  late ListOptionsBottomSheet listOptionsBottomSheet;
  late EditListScreenBuilder editListScreenBuilder;

  setUpAll(() {
    registerFallbackValue(getFakeSongbook());
    registerFallbackValue(_BuildContextMock());

    bloc = _ListOptionsBottomSheetBlocMock();
    when(() => bloc.clearList(any())).thenAnswer((_) => SynchronousFuture(const Ok(null)));
    when(() => bloc.deleteSongbook(any())).thenAnswer((_) => SynchronousFuture(const Ok(null)));
    when(() => bloc.shareLink(any(), any())).thenAnswer((_) => SynchronousFuture(null));
    when(() => bloc.isValidSongbookName(any())).thenAnswer((_) => SynchronousFuture(true));
    when(() => bloc.updateSongbookData(
        songbookName: any(named: "songbookName"),
        songbook: any(named: "songbook"),
        isPublic: any(named: "isPublic"))).thenAnswer((_) => SynchronousFuture(const Ok(null)));
    when(bloc.close).thenAnswer((_) => SynchronousFuture(null));

    editListScreenBuilder = _EditListScreenBuilderMock();
    when(() => editListScreenBuilder.push(any(), any(), any())).thenAnswer((_) => SynchronousFuture(ReorderSuccess()));

    listOptionsBottomSheet = ListOptionsBottomSheet(
      _ClearVersionsFromSongbookMock(),
      _DeleteSongbookMock(),
      _ShareLinkMock(),
      _UpdateSongbookDataMock(),
      _ValidateSongbookNameMock(),
      editListScreenBuilder,
    );
  });

  Future<void> setOpenListOptionBottomSheet(
    BuildContext context,
    bool isUserList,
    int? ccid,
    Songbook songbook,
    bool haveEditMode,
    _ListOptionsBottomSheetBlocMock bloc, [
    VoidCallback? onDeleteSongbook,
  ]) =>
      listOptionsBottomSheet.open(
        context: context,
        isUserList: isUserList,
        ccid: ccid,
        songbook: songbook,
        onDeleteSongbook: onDeleteSongbook ?? () {},
        haveEditMode: haveEditMode,
        bloc: bloc,
      );

  group("When open the bottom sheet", () {
    testWidgets("and 'isUserList' is true and list is public should show 5 options", (widgetTester) async {
      bloc.mockStream(null);

      await widgetTester.pumpWidgetWithWrapper(
        Builder(
          builder: (context) {
            return Scaffold(
              body: InkWell(
                onTap: () async {
                  await setOpenListOptionBottomSheet(context, true, 1, getFakeSongbook(isPublic: true), false, bloc);
                },
              ),
            );
          },
        ),
      );

      expect(find.byType(InkWell), findsOneWidget);
      await widgetTester.tap(find.byType(InkWell));
      await widgetTester.pumpAndSettle();
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(IconTextTile), findsNWidgets(5));
    });

    testWidgets("and 'isUserList' is true and list is private should show 4 options", (widgetTester) async {
      bloc.mockStream(null);

      await widgetTester.pumpWidgetWithWrapper(
        Builder(
          builder: (context) {
            return Scaffold(
              body: InkWell(
                onTap: () async {
                  await setOpenListOptionBottomSheet(context, true, 1, getFakeSongbook(isPublic: false), false, bloc);
                },
              ),
            );
          },
        ),
      );

      expect(find.byType(InkWell), findsOneWidget);
      await widgetTester.tap(find.byType(InkWell));
      await widgetTester.pumpAndSettle();
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(IconTextTile), findsNWidgets(4));
    });

    testWidgets("and 'isUserList' is true and ccid is null should show 4 options", (widgetTester) async {
      bloc.mockStream(null);

      await widgetTester.pumpWidgetWithWrapper(
        Builder(
          builder: (context) {
            return Scaffold(
              body: InkWell(
                onTap: () async {
                  await setOpenListOptionBottomSheet(context, true, null, getFakeSongbook(isPublic: true), false, bloc);
                },
              ),
            );
          },
        ),
      );

      expect(find.byType(InkWell), findsOneWidget);
      await widgetTester.tap(find.byType(InkWell));
      await widgetTester.pumpAndSettle();
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(IconTextTile), findsNWidgets(4));
    });

    testWidgets("and 'isUserList' is false should show 1 option", (widgetTester) async {
      bloc.mockStream(null);

      await widgetTester.pumpWidgetWithWrapper(
        Builder(
          builder: (context) {
            return Scaffold(
              body: InkWell(
                onTap: () async {
                  await setOpenListOptionBottomSheet(context, false, 1, getFakeSongbook(isPublic: false), false, bloc);
                },
              ),
            );
          },
        ),
      );

      expect(find.byType(InkWell), findsOneWidget);
      await widgetTester.tap(find.byType(InkWell));
      await widgetTester.pumpAndSettle();
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(IconTextTile), findsNWidgets(1));
    });

    testWidgets("and 'haveEditMode' is true should show all options", (widgetTester) async {
      bloc.mockStream(null);

      await widgetTester.pumpWidgetWithWrapper(
        Builder(
          builder: (context) {
            return Scaffold(
              body: InkWell(
                onTap: () async {
                  await setOpenListOptionBottomSheet(context, true, 1, getFakeSongbook(isPublic: true), true, bloc);
                },
              ),
            );
          },
        ),
      );

      expect(find.byType(InkWell), findsOneWidget);
      await widgetTester.tap(find.byType(InkWell));
      await widgetTester.pumpAndSettle();
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(IconTextTile), findsNWidgets(6));
    });
  });

  testWidgets("When tap in clear List option should call dialog and clear list", (widgetTester) async {
    bloc.mockStream(null);
    final songbook = getFakeSongbook(isPublic: true);

    await widgetTester.pumpWidgetWithWrapper(
      Builder(
        builder: (context) {
          return Scaffold(
            body: InkWell(
              onTap: () async {
                await setOpenListOptionBottomSheet(context, true, 1, songbook, false, bloc);
              },
            ),
          );
        },
      ),
    );

    expect(find.byType(InkWell), findsOneWidget);
    await widgetTester.tap(find.byType(InkWell));
    await widgetTester.pumpAndSettle();
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(IconTextTile), findsNWidgets(5));

    await widgetTester.tap(find.text(appTextEn.clearList));
    await widgetTester.pumpAndSettle();

    expect(find.byType(ClearDialog), findsOneWidget);

    await widgetTester.tap(find.widgetWithText(CifraClubButton, appTextEn.yes));
    await widgetTester.pump();

    verify(() => bloc.clearList(songbook.id)).called(1);
  });

  testWidgets("When tap in clear List option songbook is special List should call dialog and clear list",
      (widgetTester) async {
    bloc.mockStream(null);
    final songbook = getFakeSongbook(isPublic: false);

    await widgetTester.pumpWidgetWithWrapper(
      Builder(
        builder: (context) {
          return Scaffold(
            body: InkWell(
              onTap: () async {
                await setOpenListOptionBottomSheet(context, false, 1, songbook, false, bloc);
              },
            ),
          );
        },
      ),
    );

    expect(find.byType(InkWell), findsOneWidget);
    await widgetTester.tap(find.byType(InkWell));
    await widgetTester.pumpAndSettle();
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(IconTextTile), findsNWidgets(1));

    await widgetTester.tap(find.text(appTextEn.clearList));
    await widgetTester.pumpAndSettle();

    expect(find.byType(ClearDialog), findsOneWidget);

    await widgetTester.tap(find.widgetWithText(CifraClubButton, appTextEn.yes));
    await widgetTester.pump();

    verify(() => bloc.clearList(songbook.id)).called(1);
  });

  testWidgets("When tap in clear list option and an error occurred, should show snackbar with message",
      (widgetTester) async {
    bloc.mockStream(null);
    final songbook = getFakeSongbook(isPublic: true);
    when(() => bloc.clearList(any())).thenAnswer((_) => SynchronousFuture(Err(ConnectionError())));

    await widgetTester.pumpWidgetWithWrapper(
      Builder(
        builder: (context) {
          return Scaffold(
            body: InkWell(
              onTap: () async {
                await setOpenListOptionBottomSheet(
                  context,
                  true,
                  1,
                  songbook,
                  false,
                  bloc,
                );
              },
            ),
          );
        },
      ),
    );

    expect(find.byType(InkWell), findsOneWidget);
    await widgetTester.tap(find.byType(InkWell));
    await widgetTester.pumpAndSettle();

    expect(find.byType(SingleChildScrollView), findsOneWidget);

    await widgetTester.tap(find.text(appTextEn.clearList));
    await widgetTester.pumpAndSettle();

    expect(find.byType(ClearDialog), findsOneWidget);

    await widgetTester.tap(find.widgetWithText(CifraClubButton, appTextEn.yes));
    await widgetTester.pump();

    expect(find.text(appTextEn.noConnection), findsOneWidget);
    verify(() => bloc.clearList(songbook.id)).called(1);
  });

  testWidgets("When tap in deleteSongbook option should call dialog and delete songbook", (widgetTester) async {
    bloc.mockStream(null);
    final songbook = getFakeSongbook(isPublic: true);
    final completer = Completer();

    await widgetTester.pumpWidgetWithWrapper(
      Builder(
        builder: (context) {
          return Scaffold(
            body: InkWell(
              onTap: () async {
                await setOpenListOptionBottomSheet(
                  context,
                  true,
                  1,
                  songbook,
                  false,
                  bloc,
                  completer.complete,
                );
              },
            ),
          );
        },
      ),
    );

    expect(find.byType(InkWell), findsOneWidget);
    await widgetTester.tap(find.byType(InkWell));
    await widgetTester.pumpAndSettle();

    expect(find.byType(SingleChildScrollView), findsOneWidget);

    await widgetTester.tap(find.text(appTextEn.deleteList));
    await widgetTester.pumpAndSettle();

    expect(find.byType(DeleteDialog), findsOneWidget);

    await widgetTester.tap(find.widgetWithText(CifraClubButton, appTextEn.yes));
    await widgetTester.pump();

    expect(completer.isCompleted, isTrue);
    verify(() => bloc.deleteSongbook(songbook.id)).called(1);
  });

  testWidgets("When tap in deleteSongbook option and an error occurred, should show snackbar with message",
      (widgetTester) async {
    bloc.mockStream(null);
    final songbook = getFakeSongbook(isPublic: true);
    final completer = Completer();
    when(() => bloc.deleteSongbook(any())).thenAnswer((_) => SynchronousFuture(Err(ServerError(statusCode: 404))));

    await widgetTester.pumpWidgetWithWrapper(
      Builder(
        builder: (context) {
          return Scaffold(
            body: InkWell(
              onTap: () async {
                await setOpenListOptionBottomSheet(
                  context,
                  true,
                  1,
                  songbook,
                  false,
                  bloc,
                  completer.complete,
                );
              },
            ),
          );
        },
      ),
    );

    expect(find.byType(InkWell), findsOneWidget);
    await widgetTester.tap(find.byType(InkWell));
    await widgetTester.pumpAndSettle();

    expect(find.byType(SingleChildScrollView), findsOneWidget);

    await widgetTester.tap(find.text(appTextEn.deleteList));
    await widgetTester.pumpAndSettle();

    expect(find.byType(DeleteDialog), findsOneWidget);

    await widgetTester.tap(find.widgetWithText(CifraClubButton, appTextEn.yes));
    await widgetTester.pump();

    expect(completer.isCompleted, isFalse);
    expect(find.text(appTextEn.listServerError), findsOneWidget);
    verify(() => bloc.deleteSongbook(songbook.id)).called(1);
  });

  testWidgets("When tap in privacy option should show privacy bottom sheet", (widgetTester) async {
    bloc.mockStream(null);
    final songbook = getFakeSongbook(isPublic: true);

    await widgetTester.pumpWidgetWithWrapper(
      Builder(
        builder: (context) {
          return Scaffold(
            body: InkWell(
              onTap: () async {
                await setOpenListOptionBottomSheet(context, true, 1, songbook, false, bloc);
              },
            ),
          );
        },
      ),
    );

    expect(find.byType(InkWell), findsOneWidget);
    await widgetTester.tap(find.byType(InkWell));
    await widgetTester.pumpAndSettle();

    expect(find.byType(SingleChildScrollView), findsOneWidget);

    await widgetTester.tap(find.text(appTextEn.privacyList));
    await widgetTester.pumpAndSettle();

    expect(find.byType(PrivacyBottomSheet), findsOneWidget);
  });

  testWidgets(
      "When tap in privacy option, select privacy from PrivacyBottomSheet and an error occurred, should show snackbar with message",
      (widgetTester) async {
    bloc.mockStream(null);
    final songbook = getFakeSongbook(isPublic: true);

    when(() => bloc.updateSongbookData(
        songbookName: any(named: "songbookName"),
        songbook: any(named: "songbook"),
        isPublic: any(named: "isPublic"))).thenAnswer((_) => SynchronousFuture(Err(ServerError(statusCode: 404))));

    await widgetTester.pumpWidgetWithWrapper(
      Builder(
        builder: (context) {
          return Scaffold(
            body: InkWell(
              onTap: () async {
                await setOpenListOptionBottomSheet(context, true, 1, songbook, false, bloc);
              },
            ),
          );
        },
      ),
    );

    expect(find.byType(InkWell), findsOneWidget);
    await widgetTester.tap(find.byType(InkWell));
    await widgetTester.pumpAndSettle();

    expect(find.byType(SingleChildScrollView), findsOneWidget);

    await widgetTester.tap(find.text(appTextEn.privacyList));
    await widgetTester.pumpAndSettle();

    expect(find.byType(PrivacyBottomSheet), findsOneWidget);
    await widgetTester.tap(find.widgetWithText(SelectableItem, appTextEn.private), warnIfMissed: false);
    await widgetTester.pump();

    expect(find.text(appTextEn.listServerError), findsOneWidget);
    verify(() => bloc.updateSongbookData(songbook: songbook, isPublic: false)).called(1);
  });

  testWidgets("When tap in shareLink option should call share link", (widgetTester) async {
    bloc.mockStream(null);
    final songbook = getFakeSongbook(isPublic: true);
    final link = AppUrls.songbookUrlFormat(1, songbook.id!);

    await widgetTester.pumpWidgetWithWrapper(
      Builder(
        builder: (context) {
          return Scaffold(
            body: InkWell(
              onTap: () async {
                await setOpenListOptionBottomSheet(context, true, 1, songbook, false, bloc);
              },
            ),
          );
        },
      ),
    );

    expect(find.byType(InkWell), findsOneWidget);
    await widgetTester.tap(find.byType(InkWell));
    await widgetTester.pumpAndSettle();

    expect(find.byType(SingleChildScrollView), findsOneWidget);

    await widgetTester.tap(find.text(appTextEn.share));
    await widgetTester.pumpAndSettle();

    verify(() => bloc.shareLink(link, any())).called(1);
  });

  testWidgets("When tap in nameList option should call rename list", (widgetTester) async {
    bloc.mockStream(null);
    const newSongbookName = "teste name";
    final songbook = getFakeSongbook(isPublic: true);

    when(() => bloc.updateSongbookData(
        songbookName: any(named: "songbookName"),
        songbook: any(named: "songbook"),
        isPublic: any(named: "isPublic"))).thenAnswer((_) => SynchronousFuture(const Ok(null)));

    await widgetTester.pumpWidgetWithWrapper(
      Builder(
        builder: (context) {
          return Scaffold(
            body: InkWell(
              onTap: () async {
                await setOpenListOptionBottomSheet(context, true, 1, songbook, false, bloc);
              },
            ),
          );
        },
      ),
    );

    expect(find.byType(InkWell), findsOneWidget);
    await widgetTester.tap(find.byType(InkWell));
    await widgetTester.pumpAndSettle();

    expect(find.byType(SingleChildScrollView), findsOneWidget);

    await widgetTester.tap(find.text(appTextEn.renameList));
    await widgetTester.pumpAndSettle();

    expect(find.byType(InputDialog), findsOneWidget);

    await widgetTester.enterText(find.byType(CosmosInputField), newSongbookName);
    await widgetTester.pumpAndSettle();

    expect(find.text(newSongbookName), findsOneWidget);

    await widgetTester.tap(find.widgetWithText(CifraClubButton, appTextEn.save));
    await widgetTester.pump();

    expect(find.text(appTextEn.renameSongbookSucceed(newSongbookName)), findsOneWidget);
    verify(() => bloc.updateSongbookData(songbook: songbook, songbookName: newSongbookName)).called(1);
  });

  testWidgets("When tap in nameList option and name is repeated should show snackbar message", (widgetTester) async {
    bloc.mockStream(null);
    const newSongbookName = "teste name";
    when(() => bloc.isValidSongbookName(any())).thenAnswer((_) => SynchronousFuture(false));
    final songbook = getFakeSongbook(isPublic: true);

    await widgetTester.pumpWidgetWithWrapper(
      Builder(
        builder: (context) {
          return Scaffold(
            body: InkWell(
              onTap: () async {
                await setOpenListOptionBottomSheet(context, true, 1, songbook, false, bloc);
              },
            ),
          );
        },
      ),
    );

    expect(find.byType(InkWell), findsOneWidget);
    await widgetTester.tap(find.byType(InkWell));
    await widgetTester.pumpAndSettle();

    expect(find.byType(SingleChildScrollView), findsOneWidget);

    await widgetTester.tap(find.text(appTextEn.renameList));
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

  testWidgets("When tap in nameList option and return api error should show snackbar", (widgetTester) async {
    bloc.mockStream(null);
    const newSongbookName = "teste name";
    final songbook = getFakeSongbook(isPublic: true);
    when(() => bloc.isValidSongbookName(any())).thenAnswer((_) => SynchronousFuture(true));
    when(() => bloc.updateSongbookData(songbook: songbook, songbookName: newSongbookName))
        .thenAnswer((_) => SynchronousFuture(Err(ServerError(statusCode: 404))));

    await widgetTester.pumpWidgetWithWrapper(
      Builder(
        builder: (context) {
          return Scaffold(
            body: InkWell(
              onTap: () async {
                await setOpenListOptionBottomSheet(context, true, 1, songbook, false, bloc);
              },
            ),
          );
        },
      ),
    );

    expect(find.byType(InkWell), findsOneWidget);
    await widgetTester.tap(find.byType(InkWell));
    await widgetTester.pumpAndSettle();

    expect(find.byType(SingleChildScrollView), findsOneWidget);

    await widgetTester.tap(find.text(appTextEn.renameList));
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

  testWidgets("When tap in edit option should navigate to edit screen", (widgetTester) async {
    bloc.mockStream(null);
    final songbook = getFakeSongbook(isPublic: true);
    final nav = NavMock.getDummy();

    await widgetTester.pumpWidgetWithWrapper(
      Builder(
        builder: (context) {
          return Scaffold(
            body: InkWell(
              onTap: () async {
                await setOpenListOptionBottomSheet(context, true, 1, songbook, true, bloc);
              },
            ),
          );
        },
      ),
      nav: nav,
    );

    expect(find.byType(InkWell), findsOneWidget);
    await widgetTester.tap(find.byType(InkWell));
    await widgetTester.pumpAndSettle();

    expect(find.byType(SingleChildScrollView), findsOneWidget);

    await widgetTester.tap(find.text(appTextEn.editTabsList));
    await widgetTester.pumpAndSettle();

    verify(() => editListScreenBuilder.push(any(), songbook.name, songbook.id!)).called(1);
  });

  testWidgets("When tap in edit option should navigate to edit screen", (widgetTester) async {
    bloc.mockStream(null);
    final songbook = getFakeSongbook(isPublic: true);
    final nav = NavMock.getDummy();

    await widgetTester.pumpWidgetWithWrapper(
      Builder(
        builder: (context) {
          return Scaffold(
            body: InkWell(
              onTap: () async {
                await setOpenListOptionBottomSheet(context, true, 1, songbook, true, bloc);
              },
            ),
          );
        },
      ),
      nav: nav,
    );

    expect(find.byType(InkWell), findsOneWidget);
    await widgetTester.tap(find.byType(InkWell));
    await widgetTester.pumpAndSettle();

    expect(find.byType(SingleChildScrollView), findsOneWidget);

    await widgetTester.tap(find.text(appTextEn.editTabsList));
    await widgetTester.pumpAndSettle();

    expect(find.byType(SnackBar), findsOneWidget);
    verify(() => editListScreenBuilder.push(any(), songbook.name, songbook.id!)).called(1);
  });

  testWidgets("When tap in privacy option should update songbook to privacy option selected", (widgetTester) async {
    bloc.mockStream(null);
    final songbook = getFakeSongbook(isPublic: true);
    final nav = NavMock.getDummy();

    when(() => bloc.updateSongbookData(
        songbookName: any(named: "songbookName"),
        songbook: any(named: "songbook"),
        isPublic: any(named: "isPublic"))).thenAnswer((_) => SynchronousFuture(const Ok(null)));

    await widgetTester.pumpWidgetWithWrapper(
      Builder(
        builder: (context) {
          return Scaffold(
            body: InkWell(
              onTap: () async {
                await setOpenListOptionBottomSheet(context, true, 1, songbook, true, bloc);
              },
            ),
          );
        },
      ),
      nav: nav,
    );

    expect(find.byType(InkWell), findsOneWidget);
    await widgetTester.tap(find.byType(InkWell));
    await widgetTester.pumpAndSettle();

    expect(find.byType(SingleChildScrollView), findsOneWidget);

    await widgetTester.tap(find.text(appTextEn.privacyList));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(
        find.text(
          appTextEn.private,
        ),
        warnIfMissed: false);
    await widgetTester.pumpAndSettle();

    expect(find.text(appTextEn.privacyChangeSucceed), findsOneWidget);

    verify(() => bloc.updateSongbookData(songbook: songbook, isPublic: false)).called(1);
  });
}
