import 'package:cifraclub/presentation/bottom_sheets/save_version_to_list_bottom_sheet/save_version_to_list_bottom_sheet.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet.dart';
import 'package:cifraclub/presentation/widgets/icon_text_tile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../test_helpers/app_localizations.dart';
import '../../test_helpers/test_wrapper.dart';

class _SaveToListBottomSheetMock extends Mock implements SaveVersionToListBottomSheet {}

class _BuildContextMock extends Mock implements BuildContext {}

void main() {
  setUpAll(() {
    registerFallbackValue(_BuildContextMock());
  });
  testWidgets("when bottom sheet is open should show all options", (widgetTester) async {
    await widgetTester.pumpWidgetWithWrapper(
      Builder(
        builder: (context) {
          return Scaffold(
            body: InkWell(
              onTap: () async {
                await VersionOptionsBottomSheet(_SaveToListBottomSheetMock())
                    .open(screenContext: context, artistUrl: '', songUrl: '');
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

  testWidgets(
      "when bottom sheet is open and save versions to list is tapped,  should show SaveVersionToList Bottom sheet",
      (widgetTester) async {
    final saveVersionToListBottomSheet = _SaveToListBottomSheetMock();
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
                await VersionOptionsBottomSheet(saveVersionToListBottomSheet)
                    .open(screenContext: context, artistUrl: '', songUrl: '');
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
        context: any(named: "context"), artistUrl: any(named: "artistUrl"), songUrl: any(named: "songUrl"))).called(1);
  });
}
