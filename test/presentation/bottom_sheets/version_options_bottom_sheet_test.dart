import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet.dart';
import 'package:cifraclub/presentation/widgets/icon_text_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("when bottom sheet is open should show all options", (widgetTester) async {
    await widgetTester.pumpWidgetWithWrapper(
      Builder(
        builder: (context) {
          return Scaffold(
            body: InkWell(
              onTap: () async {
                await const VersionOptionsBottomSheet().open(context: context);
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
}
