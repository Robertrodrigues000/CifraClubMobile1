import 'dart:async';

import 'package:cifraclub/presentation/screens/songbook/bottom_sheet/list_options_bottom_sheet.dart';
import 'package:cifraclub/presentation/widgets/icon_text_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets(
      "When open bottom sheet and isUserlist is true should show all options and return correctly OptionsBottomSheet",
      (widgetTester) async {
    final completer = Completer<OptionsBottomSheet>();

    await widgetTester.pumpWidgetWithWrapper(
      ListOptionsBottomSheet(
        isUserList: true,
        onTap: (e) {
          completer.complete(e);
        },
      ),
    );

    expect(find.byType(IconTextTile), findsNWidgets(5));
    await widgetTester.tap(find.byType(IconTextTile).first);
    expect(await completer.future, OptionsBottomSheet.share);
  });

  testWidgets(
      "When open bottom sheet and isUserlist is false should show only 1 option and return correctly OptionsBottomSheet",
      (widgetTester) async {
    final completer = Completer<OptionsBottomSheet>();

    await widgetTester.pumpWidgetWithWrapper(
      ListOptionsBottomSheet(
        isUserList: false,
        onTap: (e) {
          completer.complete(e);
        },
      ),
    );

    expect(find.byType(IconTextTile), findsOneWidget);
    await widgetTester.tap(find.byType(IconTextTile));
    expect(await completer.future, OptionsBottomSheet.clear);
  });

  testWidgets("When tap open bottom sheet", (widgetTester) async {
    await widgetTester.pumpWidgetWithWrapper(
      Builder(
        builder: (context) {
          return InkWell(
            onTap: () {
              ListOptionsBottomSheet(
                isUserList: true,
                onTap: (p0) {},
              ).show(context);
            },
          );
        },
      ),
    );

    expect(find.byType(InkWell), findsOneWidget);
    await widgetTester.tap(find.byType(InkWell));
    await widgetTester.pumpAndSettle();
    expect(find.byType(ListOptionsBottomSheet), findsOneWidget);
  });
}
