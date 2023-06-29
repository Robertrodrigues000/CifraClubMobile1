import 'dart:async';

import 'package:cifraclub/presentation/bottom_sheets/list_version_options_bottom_sheet.dart';
import 'package:cifraclub/presentation/widgets/icon_text_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When tap open bottom sheet", (widgetTester) async {
    await widgetTester.pumpWidgetWithWrapper(
      Builder(
        builder: (context) {
          return InkWell(
            onTap: () {
              ListVersionOptionsBottomSheet(
                onTap: () {},
              ).show(context);
            },
          );
        },
      ),
    );

    expect(find.byType(InkWell), findsOneWidget);
    await widgetTester.tap(find.byType(InkWell));
    await widgetTester.pumpAndSettle();
    expect(find.byType(ListVersionOptionsBottomSheet), findsOneWidget);
  });

  testWidgets("When open bottom sheet and tap tile, should close bottom sheet and call onTap", (widgetTester) async {
    final completer = Completer();
    await widgetTester.pumpWidgetWithWrapper(
      ListVersionOptionsBottomSheet(
        onTap: completer.complete,
      ),
    );

    expect(find.byType(IconTextTile), findsOneWidget);

    await widgetTester.tap(find.byType(IconTextTile));
    await widgetTester.pumpAndSettle();

    expect(find.byType(ListVersionOptionsBottomSheet), findsNothing);
    expect(completer.isCompleted, isTrue);
  });
}
