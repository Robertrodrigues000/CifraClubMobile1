import 'dart:async';

import 'package:cifraclub/presentation/bottom_sheets/privacy_bottom_sheet.dart';
import 'package:cifraclub/presentation/widgets/selectable_item.dart';
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
              PrivacyBottomSheet(
                isPublic: true,
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
    expect(find.byType(PrivacyBottomSheet), findsOneWidget);
  });

  group("When bottom sheet is open", () {
    testWidgets("and private tile is tapped, should change privacy to private and close the bottom sheet",
        (widgetTester) async {
      final completer = Completer<bool>();

      await widgetTester.pumpWidgetWithWrapper(
        PrivacyBottomSheet(
          isPublic: true,
          onTap: (e) {
            completer.complete(e);
          },
        ),
      );

      expect(find.byType(SelectableItem), findsNWidgets(2));
      await widgetTester.tap(find.byType(SelectableItem).last);
      expect(await completer.future, isFalse);

      await widgetTester.pumpAndSettle();
      expect(find.byType(PrivacyBottomSheet), findsNothing);
    });

    testWidgets("and public tile is tapped, should change privacy to public and close the bottom sheet",
        (widgetTester) async {
      final completer = Completer<bool>();

      await widgetTester.pumpWidgetWithWrapper(
        PrivacyBottomSheet(
          isPublic: false,
          onTap: (e) {
            completer.complete(e);
          },
        ),
      );

      expect(find.byType(SelectableItem), findsNWidgets(2));
      await widgetTester.tap(find.byType(SelectableItem).first);
      expect(await completer.future, isTrue);

      await widgetTester.pumpAndSettle();
      expect(find.byType(PrivacyBottomSheet), findsNothing);
    });
  });
}
