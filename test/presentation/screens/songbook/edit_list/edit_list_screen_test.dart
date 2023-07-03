import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/dialogs/list_operation_dialogs/edit_mode_dialog.dart';
import 'package:cifraclub/presentation/screens/songbook/edit_list/edit_list_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/edit_list/edit_list_screen.dart';
import 'package:cifraclub/presentation/screens/songbook/edit_list/edit_list_state.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/cifraclub_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../shared_mocks/domain/version/models/version_mock.dart';
import '../../../../test_helpers/app_localizations.dart';
import '../../../../test_helpers/bloc_stream.dart';
import '../../../../test_helpers/test_wrapper.dart';

class _EditListBlocMock extends Mock implements EditListBloc {}

void main() {
  late EditListBloc bloc;

  setUpAll(() {
    bloc = _EditListBlocMock();
    when(bloc.close).thenAnswer((_) => SynchronousFuture(null));
  });

  group("When editing", () {
    testWidgets("and AppBar back icon is tapped, should show EditModeDialog", (tester) async {
      bloc.mockStream(const EditListState(hasChanges: true, songbookId: 0));
      await tester.pumpWidget(
        TestWrapper(
          child: BlocProvider<EditListBloc>.value(
            value: bloc,
            child: const EditListScreen(name: "Teste"),
          ),
        ),
      );
      final finder = find.byWidgetPredicate(
        (Widget widget) =>
            widget is SvgPicture &&
            widget.pictureProvider is ExactAssetPicture &&
            (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.backArrowIcon,
        description: 'widget with back arrow',
      );
      await tester.tap(finder);
      await tester.pumpAndSettle();
      expect(find.byType(EditModeDialog), findsOneWidget);
    });

    testWidgets("and Cancel button is tapped, should show EditModeDialog", (tester) async {
      bloc.mockStream(const EditListState(hasChanges: true, songbookId: 0));
      await tester.pumpWidget(
        TestWrapper(
          child: BlocProvider<EditListBloc>.value(
            value: bloc,
            child: const EditListScreen(name: "Teste"),
          ),
        ),
      );

      await tester.tap(find.widgetWithText(CifraClubButton, appTextEn.cancel));
      await tester.pumpAndSettle();
      expect(find.byType(EditModeDialog), findsOneWidget);
    });

    testWidgets("and Save button is tapped, should call bloc.save", (tester) async {
      bloc.mockStream(const EditListState(hasChanges: true, songbookId: 0));
      await tester.pumpWidget(
        TestWrapper(
          child: BlocProvider<EditListBloc>.value(
            value: bloc,
            child: const EditListScreen(name: "Teste"),
          ),
        ),
      );

      await tester.tap(find.widgetWithText(CifraClubButton, appTextEn.save));
      verify(() => bloc.save()).called(1);
    });
  });

  testWidgets("When deleteIcon is tapped, should delete version from list", (tester) async {
    bloc.mockStream(EditListState(songbookId: 0, versions: [getFakeVersion(), getFakeVersion()]));
    await tester.pumpWidget(
      TestWrapper(
        child: BlocProvider<EditListBloc>.value(
          value: bloc,
          child: const EditListScreen(name: "Teste"),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.remove_circle).first);
    verify(() => bloc.deleteVersion(0)).called(1);
  });

  testWidgets("When hasChanges is false and back button is tapped, shouldn't open dialog", (tester) async {
    bloc.mockStream(const EditListState(hasChanges: false, songbookId: 0));
    await tester.pumpWidget(
      TestWrapper(
        child: BlocProvider<EditListBloc>.value(
          value: bloc,
          child: const EditListScreen(name: "Teste"),
        ),
      ),
    );
    final finder = find.byWidgetPredicate(
      (Widget widget) =>
          widget is SvgPicture &&
          widget.pictureProvider is ExactAssetPicture &&
          (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.backArrowIcon,
      description: 'widget with back arrow',
    );
    await tester.tap(finder);
    await tester.pumpAndSettle();
    expect(find.byType(EditModeDialog), findsNothing);
  });

  group("When EditModeDialog is open", () {
    testWidgets("and keep editing button is tapped, should close dialog only", (tester) async {
      bloc.mockStream(const EditListState(hasChanges: true, songbookId: 0));
      await tester.pumpWidget(
        TestWrapper(
          child: BlocProvider<EditListBloc>.value(
            value: bloc,
            child: const EditListScreen(name: "Teste"),
          ),
        ),
      );
      final finder = find.byWidgetPredicate(
        (Widget widget) =>
            widget is SvgPicture &&
            widget.pictureProvider is ExactAssetPicture &&
            (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.backArrowIcon,
        description: 'widget with back arrow',
      );
      await tester.tap(finder);
      await tester.pumpAndSettle();
      expect(find.byType(EditModeDialog), findsOneWidget);

      await tester.tap(find.widgetWithText(CifraClubButton, appTextEn.editListDialogPrimaryButton));
      await tester.pumpAndSettle();
      expect(find.byType(EditModeDialog), findsNothing);
      expect(find.byType(ReorderableListView), findsOneWidget);
    });

    testWidgets("and cancel editing is tapped, should close dialog and pop screen", (tester) async {
      bloc.mockStream(const EditListState(hasChanges: true, songbookId: 0));
      await tester.pumpWidget(
        TestWrapper(
          child: BlocProvider<EditListBloc>.value(
            value: bloc,
            child: const EditListScreen(name: "Teste"),
          ),
        ),
      );
      final finder = find.byWidgetPredicate(
        (Widget widget) =>
            widget is SvgPicture &&
            widget.pictureProvider is ExactAssetPicture &&
            (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.backArrowIcon,
        description: 'widget with back arrow',
      );
      await tester.tap(finder);
      await tester.pumpAndSettle();
      expect(find.byType(EditModeDialog), findsOneWidget);

      await tester.tap(find.widgetWithText(CifraClubButton, appTextEn.exit));
      await tester.pumpAndSettle();
      expect(find.byType(EditModeDialog), findsNothing);
      expect(find.byType(ReorderableListView), findsNothing);
    });
  });
}
