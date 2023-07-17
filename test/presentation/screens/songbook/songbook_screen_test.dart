import 'package:cifraclub/domain/app/use_cases/share_link.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/user/models/user_credential.dart';
import 'package:cifraclub/presentation/bottom_sheets/list_options_bottom_sheet.dart';
import 'package:cifraclub/domain/songbook/use_cases/clear_songs_from_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/delete_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/update_songbook_data.dart';
import 'package:cifraclub/domain/songbook/use_cases/validate_songbook_name.dart';
import 'package:cifraclub/presentation/bottom_sheets/list_options_bottom_sheet_bloc.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/dialogs/list_operation_dialogs/delete_dialog.dart';
import 'package:cifraclub/presentation/screens/songbook/edit_list/edit_list_screen_builder.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_entry.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_screen.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_state.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/lists_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/lists_screen.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/lists_state.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/user_list_item.dart';
import 'package:cifraclub/presentation/screens/songbook/songbook_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/songbook_screen.dart';
import 'package:cifraclub/presentation/screens/songbook/songbook_state.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/cifraclub_button.dart';
import 'package:cifraclub/presentation/widgets/device_type_builder.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/songbook/models/songbook_mock.dart';
import '../../../shared_mocks/presentation/navigator/nav_mock.dart';
import '../../../test_helpers/app_localizations.dart';
import '../../../test_helpers/bloc_stream.dart';
import '../../../test_helpers/test_wrapper.dart';

class _SongbookBlocMock extends Mock implements SongbookBloc {}

class _ListsBlocMock extends Mock implements ListsBloc {}

class _VersionsBlocMock extends Mock implements VersionsBloc {}

class _SongbookFake extends Fake implements Songbook {}

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
  late SongbookBloc bloc;
  late ListsBloc listsBloc;
  late VersionsBloc versionsBloc;
  late ListOptionsBottomSheet bottomSheet;
  late _ListOptionsBottomSheetBlocMock blocBottomSheet;

  setUpAll(() {
    registerFallbackValue(_SongbookFake());
    registerFallbackValue(_BuildContextMock());

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

    bloc = _SongbookBlocMock();
    when(() => bloc.onSelectSongbook(any())).thenReturn(null);
    when(bloc.close).thenAnswer((_) => SynchronousFuture(null));

    listsBloc = _ListsBlocMock();
    when(listsBloc.init).thenReturn(null);
    when(listsBloc.openLoginPage).thenReturn(null);
    when(listsBloc.openUserProfilePage).thenReturn(null);
    when(listsBloc.logout).thenAnswer((_) => SynchronousFuture(null));
    when(listsBloc.close).thenAnswer((_) => SynchronousFuture(null));
    when(() => listsBloc.createNewSongbook(any())).thenAnswer((_) => SynchronousFuture(Ok(getFakeSongbook())));
    when(() => listsBloc.isValidSongbookName(any())).thenAnswer((_) => SynchronousFuture(true));
    when(listsBloc.initListLimitStreams).thenAnswer((_) => SynchronousFuture(null));

    versionsBloc = _VersionsBlocMock();
    when(() => versionsBloc.init(any())).thenAnswer((_) => SynchronousFuture(null));
    when(() => versionsBloc.shareLink(any(), any())).thenAnswer((_) => SynchronousFuture(null));
    when(versionsBloc.close).thenAnswer((_) => SynchronousFuture(null));
  });

  group("When start songbook screen", () {
    testWidgets("and user is not logged, should show error description", (widgetTester) async {
      bloc.mockStream(const SongbookState(userCredential: UserCredential(isUserLoggedIn: false)));

      await widgetTester.pumpWidget(
        TestWrapper(
          child: BlocProvider<SongbookBloc>.value(
            value: bloc,
            child: SongbookScreen(
              DeviceType.phone,
              bottomSheet,
            ),
          ),
        ),
      );

      expect(find.byType(ErrorDescriptionWidget), findsOneWidget);
      expect(find.text(appTextEn.loggedOutListErrorDescription), findsOneWidget);
    });

    group("in a phone", () {
      testWidgets("should show lists screen", (widgetTester) async {
        widgetTester.view.physicalSize = const Size(460, 800);
        widgetTester.view.devicePixelRatio = 1.0;

        bloc.mockStream(
            const SongbookState(selectedSongbookId: null, userCredential: UserCredential(isUserLoggedIn: true)));
        listsBloc.mockStream(const ListsState());

        await widgetTester.pumpWidgetWithWrapper(
          MultiBlocProvider(
            providers: [
              BlocProvider<SongbookBloc>.value(value: bloc),
              BlocProvider<ListsBloc>.value(value: listsBloc),
            ],
            child: SongbookScreen(
              DeviceType.phone,
              bottomSheet,
            ),
          ),
        );

        expect(find.byType(VersionsScreen), findsNothing);
      });

      testWidgets("and click in a songbook should push to a new versions screen", (widgetTester) async {
        widgetTester.view.physicalSize = const Size(460, 800);
        widgetTester.view.devicePixelRatio = 1.0;

        final songbook = getFakeSongbook();
        bloc.mockStream(const SongbookState(
          selectedSongbookId: null,
          userCredential: UserCredential(isUserLoggedIn: true),
        ));
        listsBloc.mockStream(ListsState(userLists: [songbook]));

        final nav = NavMock.getDummy();

        await widgetTester.pumpWidgetWithWrapper(
          MultiBlocProvider(
            providers: [
              BlocProvider<SongbookBloc>.value(value: bloc),
              BlocProvider<ListsBloc>.value(value: listsBloc),
            ],
            child: SongbookScreen(
              DeviceType.phone,
              bottomSheet,
            ),
          ),
          nav: nav,
        );

        final finder = find.byType(UserListItem).first;

        await widgetTester.tap(finder);
        await widgetTester.pump();
        verify(() => nav.push(screenName: VersionsEntry.name, params: any(named: "params"))).called(1);
      });
    });

    group("in a tablet", () {
      testWidgets("should show lists and version screen", (widgetTester) async {
        widgetTester.view.physicalSize = const Size(850, 1000);
        widgetTester.view.devicePixelRatio = 1.0;

        final songbook = getFakeSongbook(isPublic: true);
        bloc.mockStream(const SongbookState(
          selectedSongbookId: null,
          userCredential: UserCredential(isUserLoggedIn: true),
        ));
        listsBloc.mockStream(const ListsState());
        versionsBloc.mockStream(VersionsState(songbook: songbook));

        await widgetTester.pumpWidgetWithWrapper(
          MultiBlocProvider(
            providers: [
              BlocProvider<SongbookBloc>.value(value: bloc),
              BlocProvider<ListsBloc>.value(value: listsBloc),
              BlocProvider<VersionsBloc>.value(value: versionsBloc),
            ],
            child: SongbookScreen(
              DeviceType.tablet,
              bottomSheet,
            ),
          ),
        );

        expect(find.byType(ListsScreen), findsOneWidget);
        expect(find.byType(VersionsScreen), findsOneWidget);
      });

      testWidgets("and click in a songbook should emit new songbook", (widgetTester) async {
        widgetTester.view.physicalSize = const Size(850, 1000);
        widgetTester.view.devicePixelRatio = 1.0;

        final songbook = getFakeSongbook(isPublic: true);
        bloc.mockStream(
            const SongbookState(selectedSongbookId: null, userCredential: UserCredential(isUserLoggedIn: true)));
        listsBloc.mockStream(ListsState(userLists: [songbook]));
        versionsBloc.mockStream(VersionsState(songbook: songbook));

        await widgetTester.pumpWidgetWithWrapper(
          MultiBlocProvider(
            providers: [
              BlocProvider<SongbookBloc>.value(value: bloc),
              BlocProvider<ListsBloc>.value(value: listsBloc),
              BlocProvider<VersionsBloc>.value(value: versionsBloc),
            ],
            child: SongbookScreen(
              DeviceType.tablet,
              bottomSheet,
            ),
          ),
        );

        final finder = find.byType(UserListItem).first;

        await widgetTester.tap(finder);
        verify(() => bloc.onSelectSongbook(any())).called(1);
      });

      testWidgets("and click to delete songbook should change to default songbook", (widgetTester) async {
        widgetTester.view.physicalSize = const Size(850, 1000);
        widgetTester.view.devicePixelRatio = 1.0;

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

        final songbook = getFakeSongbook(isPublic: true);
        bloc.mockStream(
            const SongbookState(selectedSongbookId: null, userCredential: UserCredential(isUserLoggedIn: true)));
        listsBloc.mockStream(ListsState(userLists: [songbook]));
        versionsBloc.mockStream(VersionsState(songbook: songbook));

        await widgetTester.pumpWidgetWithWrapper(
          MultiBlocProvider(
            providers: [
              BlocProvider<SongbookBloc>.value(value: bloc),
              BlocProvider<ListsBloc>.value(value: listsBloc),
              BlocProvider<VersionsBloc>.value(value: versionsBloc),
            ],
            child: SongbookScreen(
              DeviceType.tablet,
              bottomSheet,
            ),
          ),
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

        verify(() => bloc.onSelectSongbook(any())).called(1);
      });
    });
  });
}
