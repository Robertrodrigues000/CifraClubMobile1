import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_list_limit.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_list_limit_state.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit_state.dart';
import 'package:cifraclub/domain/remote_config/use_cases/get_list_limit_constants.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_all_user_songbooks.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_user_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_version_to_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/validate_artist_image_preview.dart';
import 'package:cifraclub/domain/songbook/use_cases/validate_songbook_name.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_pro_status_stream.dart';
import 'package:cifraclub/presentation/bottom_sheets/save_version_to_list_bottom_sheet/save_version_to_list_bottom_sheet.dart';
import 'package:cifraclub/presentation/bottom_sheets/save_version_to_list_bottom_sheet/save_version_to_list_bottom_sheet_bloc.dart';
import 'package:cifraclub/presentation/bottom_sheets/save_version_to_list_bottom_sheet/save_version_to_list_result.dart';
import 'package:cifraclub/presentation/bottom_sheets/save_version_to_list_bottom_sheet/save_version_to_list_state.dart';
import 'package:cifraclub/presentation/dialogs/list_limit_dialog.dart';
import 'package:cifraclub/presentation/dialogs/list_limit_pro_dialog.dart';
import 'package:cifraclub/presentation/dialogs/list_operation_dialogs/input_dialog.dart';
import 'package:cifraclub/presentation/dialogs/list_operation_dialogs/list_operation_dialog.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/lists_state.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/special_lists.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/user_lists.dart';
import 'package:cifraclub/presentation/widgets/selectable_item.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../shared_mocks/domain/songbook/models/songbook_mock.dart';
import '../../../test_helpers/app_localizations.dart';
import '../../../test_helpers/bloc_stream.dart';
import '../../../test_helpers/test_wrapper.dart';

class _BuildContextMock extends Mock implements BuildContext {}

class _GetAllUserSongbooksMock extends Mock implements GetAllUserSongbooks {}

class _InsertUserSongbookMock extends Mock implements InsertUserSongbook {}

class _GetListLimitStateMock extends Mock implements GetListLimitState {}

class _GetVersionsLimitStateMock extends Mock implements GetVersionsLimitState {}

class _InsertVersionToSongbookMock extends Mock implements InsertVersionToSongbook {}

class _ValidateSongbookNameMock extends Mock implements ValidateSongbookName {}

class _GetListLimitMock extends Mock implements GetListLimit {}

class _GetVersionsLimitMock extends Mock implements GetVersionsLimit {}

class _GetProStatusStreamMock extends Mock implements GetProStatusStream {}

class _SaveVersionToListBottomSheetBlocMock extends Mock implements SaveVersionToListBottomSheetBloc {}

class _ValidateArtistImagePreviewMock extends Mock implements ValidateArtistImagePreview {}

class _GetListLimitConstants extends Mock implements GetListLimitConstants {}

void main() {
  late _SaveVersionToListBottomSheetBlocMock bloc;
  late SaveVersionToListBottomSheet saveVersionToListBottomSheet;

  setUpAll(() {
    registerFallbackValue(getFakeSongbook());
    registerFallbackValue(_BuildContextMock());

    bloc = _SaveVersionToListBottomSheetBlocMock();
    when(() => bloc.init()).thenAnswer((_) => SynchronousFuture(null));
    when(() => bloc.getListLimit()).thenAnswer((_) => 10);
    when(() => bloc.getVersionsLimit()).thenAnswer((_) => 100);
    when(() => bloc.addSongToSongbook(name: any(named: "name"))).thenAnswer((_) => Future.value(
        const SaveVersionToListCompleted(name: "TESTANDO", showListsLimitWarning: false, isNewList: false)));
    when(() => bloc.validatePreview(any())).thenReturn([]);
    when(() => bloc.isValidSongbookName(any())).thenAnswer((_) => SynchronousFuture(true));
    when(() => bloc.createNewSongbook(
              any(),
            ))
        .thenAnswer((_) => Future.value(
            const SaveVersionToListCompleted(name: "TESTANDO", showListsLimitWarning: false, isNewList: false)));
    when(bloc.close).thenAnswer((_) => SynchronousFuture(null));

    saveVersionToListBottomSheet = SaveVersionToListBottomSheet(
      _GetAllUserSongbooksMock(),
      _InsertUserSongbookMock(),
      _GetListLimitStateMock(),
      _GetVersionsLimitStateMock(),
      _InsertVersionToSongbookMock(),
      _ValidateSongbookNameMock(),
      _GetListLimitMock(),
      _GetVersionsLimitMock(),
      _GetProStatusStreamMock(),
      _ValidateArtistImagePreviewMock(),
      _GetListLimitConstants(),
    );
  });

  Future<void> setShowSaveVersionToListBottomSheet(
    BuildContext context,
    _SaveVersionToListBottomSheetBlocMock bloc,
    String artistUrl,
    String songUrl,
  ) =>
      saveVersionToListBottomSheet.show(context: context, bloc: bloc..init(), artistUrl: "", songUrl: "");

  group("When open the bottom sheet", () {
    testWidgets("should show user lists and special lists", (widgetTester) async {
      bloc.mockStream(SaveVersionToListState(specialLists: [getFakeSongbook(listType: ListType.cantPlay)]));
      await mockNetworkImagesFor(() async {
        await widgetTester.pumpWidgetWithWrapper(
          Builder(
            builder: (context) {
              return Scaffold(
                body: InkWell(
                  onTap: () async {
                    await setShowSaveVersionToListBottomSheet(context, bloc, "", "");
                  },
                ),
              );
            },
          ),
        );
      });
      expect(find.byType(InkWell), findsOneWidget);
      await widgetTester.tap(find.byType(InkWell));
      await widgetTester.pumpAndSettle();
      expect(find.byType(UserLists, skipOffstage: false), findsOneWidget);
      expect(find.byType(SpecialLists, skipOffstage: false), findsOneWidget);
      expect(find.byType(SelectableItem, skipOffstage: false), findsNWidgets(2));
    });

    testWidgets("when tapping in create new list, should show input dialog", (widgetTester) async {
      bloc.mockStream(const SaveVersionToListState());
      await mockNetworkImagesFor(() async {
        await widgetTester.pumpWidgetWithWrapper(
          Builder(
            builder: (context) {
              return Scaffold(
                body: InkWell(
                  onTap: () async {
                    await setShowSaveVersionToListBottomSheet(context, bloc, "", "");
                  },
                ),
              );
            },
          ),
        );
      });
      expect(find.byType(InkWell), findsOneWidget);
      await widgetTester.tap(find.byType(InkWell));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byKey(const Key("create-new-list")));
      await widgetTester.pumpAndSettle();
      expect(find.byType(InputDialog, skipOffstage: false), findsOneWidget);
    });

    testWidgets("when tapping in create new list and ListLimitState is Reached, should show Limit dialog",
        (widgetTester) async {
      bloc.mockStream(const SaveVersionToListState(listState: ListLimitState.reached));
      await mockNetworkImagesFor(() async {
        await widgetTester.pumpWidgetWithWrapper(
          Builder(
            builder: (context) {
              return Scaffold(
                body: InkWell(
                  onTap: () async {
                    await setShowSaveVersionToListBottomSheet(context, bloc, "", "");
                  },
                ),
              );
            },
          ),
        );
      });
      expect(find.byType(InkWell), findsOneWidget);
      await widgetTester.tap(find.byType(InkWell));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byKey(const Key("create-new-list")));
      await widgetTester.pumpAndSettle();
      expect(find.byType(ListLimitDialog, skipOffstage: false), findsOneWidget);
    });

    testWidgets(
        "when tapping in create new list and ListLimitState is Reachedand user is pro,should show Limit Pro dialog",
        (widgetTester) async {
      bloc.mockStream(const SaveVersionToListState(listState: ListLimitState.reached, isPro: true));
      await mockNetworkImagesFor(() async {
        await widgetTester.pumpWidgetWithWrapper(
          Builder(
            builder: (context) {
              return Scaffold(
                body: InkWell(
                  onTap: () async {
                    await setShowSaveVersionToListBottomSheet(context, bloc, "", "");
                  },
                ),
              );
            },
          ),
        );
      });
      expect(find.byType(InkWell), findsOneWidget);
      await widgetTester.tap(find.byType(InkWell));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byKey(const Key("create-new-list")));
      await widgetTester.pumpAndSettle();
      expect(find.byType(ListLimitProDialog, skipOffstage: false), findsOneWidget);
    });

    testWidgets("when tapping in create new list and save, should call createNewSongbook", (widgetTester) async {
      bloc.mockStream(const SaveVersionToListState());
      when(() => bloc.createNewSongbook(
                any(),
              ))
          .thenAnswer((_) => Future.value(SaveVersionToListCompleted(
              name: "testando",
              showListsLimitWarning: true,
              isNewList: true,
              limitWarning: ListLimitWarning(
                  limit: 10, proLimit: 100, listState: ListLimitState.atWarning, isVersionLimit: false))));
      when(() => bloc.isValidSongbookName(any())).thenAnswer((_) => SynchronousFuture(true));

      await mockNetworkImagesFor(() async {
        await widgetTester.pumpWidgetWithWrapper(
          Builder(
            builder: (context) {
              return Scaffold(
                body: InkWell(
                  onTap: () async {
                    await setShowSaveVersionToListBottomSheet(context, bloc, "", "");
                  },
                ),
              );
            },
          ),
        );
      });

      expect(find.byType(InkWell), findsOneWidget);
      await widgetTester.tap(find.byType(InkWell));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.byKey(const Key("create-new-list")));
      await widgetTester.pumpAndSettle();

      await widgetTester.enterText(find.byType(CosmosInputField), "testando");
      await widgetTester.pumpAndSettle();

      final inputDialogFinder = find.byType(ListOperationDialog);
      expect(inputDialogFinder, findsOneWidget);
      final buttonFinder = find.descendant(
        of: inputDialogFinder,
        matching: find.byKey(const Key("first-button"), skipOffstage: false),
      );
      expect(buttonFinder, findsOneWidget);
      await widgetTester.tap(buttonFinder);
      await widgetTester.pumpAndSettle();
      verify(() => bloc.createNewSongbook(any())).called(1);
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets("when tapping in create new list and name already exists, should not call createNewSongbook",
        (widgetTester) async {
      bloc.mockStream(const SaveVersionToListState());

      when(() => bloc.isValidSongbookName(any())).thenAnswer((_) => SynchronousFuture(false));

      await mockNetworkImagesFor(() async {
        await widgetTester.pumpWidgetWithWrapper(
          Builder(
            builder: (context) {
              return Scaffold(
                body: InkWell(
                  onTap: () async {
                    await setShowSaveVersionToListBottomSheet(context, bloc, "", "");
                  },
                ),
              );
            },
          ),
        );
      });

      expect(find.byType(InkWell), findsOneWidget);
      await widgetTester.tap(find.byType(InkWell));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.byKey(const Key("create-new-list")));
      await widgetTester.pumpAndSettle();

      await widgetTester.enterText(find.byType(CosmosInputField), "testando");
      await widgetTester.pumpAndSettle();

      final inputDialogFinder = find.byType(ListOperationDialog);
      expect(inputDialogFinder, findsOneWidget);
      final buttonFinder = find.descendant(
        of: inputDialogFinder,
        matching: find.byKey(const Key("first-button"), skipOffstage: false),
      );
      expect(buttonFinder, findsOneWidget);
      await widgetTester.tap(buttonFinder);
      await widgetTester.pumpAndSettle();
      verifyNever(() => bloc.createNewSongbook(any()));
    });
  });

  testWidgets("When tap in item and limit is reached and user is not pro should show list limit pro dialog",
      (widgetTester) async {
    final songbook = getFakeSongbook();
    bloc.mockStream(SaveVersionToListState(userLists: [songbook], isPro: true));

    when(() => bloc.addSongToSongbook(name: any(named: "name"), songbookId: any(named: "songbookId")))
        .thenAnswer((_) => SynchronousFuture(const VersionListLimitStateReached(versionsLimit: 100)));

    await widgetTester.pumpWidgetWithWrapper(
      Builder(
        builder: (context) {
          return Scaffold(
            body: InkWell(
              onTap: () async {
                await setShowSaveVersionToListBottomSheet(context, bloc, "", "");
              },
            ),
          );
        },
      ),
    );

    expect(find.byType(InkWell), findsOneWidget);
    await widgetTester.tap(find.byType(InkWell));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.text(songbook.name));
    await widgetTester.pumpAndSettle();

    expect(find.byType(ListLimitProDialog, skipOffstage: false), findsOneWidget);
  });

  testWidgets("When tap in item of user list and error occurs should show error snack bar", (widgetTester) async {
    final songbook = getFakeSongbook();
    bloc.mockStream(SaveVersionToListState(specialLists: [songbook], isPro: true));

    when(() => bloc.addSongToSongbook(name: any(named: "name"), songbookId: any(named: "songbookId")))
        .thenAnswer((_) => SynchronousFuture(SaveToListError(listLimitState: ListLimitState.withinLimit)));

    await widgetTester.pumpWidgetWithWrapper(
      Builder(
        builder: (context) {
          return Scaffold(
            body: InkWell(
              onTap: () async {
                await setShowSaveVersionToListBottomSheet(context, bloc, "", "");
              },
            ),
          );
        },
      ),
    );

    expect(find.byType(InkWell), findsOneWidget);
    await widgetTester.tap(find.byType(InkWell));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.text(songbook.name), warnIfMissed: false);
    await widgetTester.pumpAndSettle();

    expect(find.text(appTextEn.errorListSong), findsOneWidget);
  });

  testWidgets("When save to list and is close to version limit should show snackbars", (widgetTester) async {
    final songbook = getFakeSongbook();
    bloc.mockStream(SaveVersionToListState(specialLists: [songbook]));

    when(() => bloc.addSongToSongbook(name: any(named: "name"), songbookId: any(named: "songbookId"))).thenAnswer((_) =>
        SynchronousFuture(SaveVersionToListCompleted(
            name: songbook.name,
            limitWarning:
                ListLimitWarning(limit: 10, proLimit: 100, listState: ListLimitState.atWarning, isVersionLimit: true),
            showListsLimitWarning: true,
            isNewList: false)));

    await widgetTester.pumpWidgetWithWrapper(
      Builder(
        builder: (context) {
          return Scaffold(
            body: InkWell(
              onTap: () async {
                await setShowSaveVersionToListBottomSheet(context, bloc, "", "");
              },
            ),
          );
        },
      ),
    );

    final inkWell = find.byType(InkWell);
    expect(inkWell, findsOneWidget);
    await widgetTester.tap(inkWell);
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.text(songbook.name), warnIfMissed: false);
    await widgetTester.pumpAndSettle();

    expect(find.text(appTextEn.saveVersionToListMessage(songbook.name)), findsOneWidget);
    ScaffoldMessenger.of(widgetTester.element(inkWell)).hideCurrentSnackBar();
    await widgetTester.pumpAndSettle();
  });

  testWidgets("When tap in item and is success and close to list limit should show snack bars", (widgetTester) async {
    final songbook = getFakeSongbook();
    bloc.mockStream(SaveVersionToListState(specialLists: [songbook]));

    when(() => bloc.addSongToSongbook(
          name: any(named: "name"),
          songbookId: any(named: "songbookId"),
        )).thenAnswer((_) => SynchronousFuture(SaveVersionToListCompleted(
          name: songbook.name,
          limitWarning:
              ListLimitWarning(limit: 10, proLimit: 100, listState: ListLimitState.withinLimit, isVersionLimit: false),
          showListsLimitWarning: true,
          isNewList: true,
        )));

    await widgetTester.pumpWidgetWithWrapper(
      Builder(
        builder: (context) {
          return Scaffold(
            body: InkWell(
              onTap: () async {
                await setShowSaveVersionToListBottomSheet(context, bloc, "", "");
              },
            ),
          );
        },
      ),
    );

    final inkWell = find.byType(InkWell);
    expect(inkWell, findsOneWidget);
    await widgetTester.tap(inkWell);
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.text(songbook.name), warnIfMissed: false);
    await widgetTester.pumpAndSettle();

    expect(find.text(appTextEn.saveVersionToListMessage(songbook.name)), findsOneWidget);
    ScaffoldMessenger.of(widgetTester.element(inkWell)).hideCurrentSnackBar();
    await widgetTester.pumpAndSettle();
    expect(find.text(appTextEn.listLimitWarning(10, 100, appTextEn.lists)), findsOneWidget);
  });

  testWidgets("when tapping in a list and version is already on list, should show snack bar with correct message",
      (widgetTester) async {
    final songbook = getFakeSongbook();
    bloc.mockStream(SaveVersionToListState(specialLists: [songbook]));

    when(() => bloc.addSongToSongbook(
          name: any(named: "name"),
          songbookId: any(named: "songbookId"),
        )).thenAnswer((_) => SynchronousFuture(VersionIsAlreadyOnListError()));

    await widgetTester.pumpWidgetWithWrapper(
      Builder(
        builder: (context) {
          return Scaffold(
            body: InkWell(
              onTap: () async {
                await setShowSaveVersionToListBottomSheet(context, bloc, "", "");
              },
            ),
          );
        },
      ),
    );

    final inkWell = find.byType(InkWell);
    expect(inkWell, findsOneWidget);
    await widgetTester.tap(inkWell, warnIfMissed: false);
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.text(songbook.name, skipOffstage: false), warnIfMissed: false);
    await widgetTester.pumpAndSettle();

    expect(find.text(appTextEn.repeatedSongError), findsOneWidget);
  });
}
