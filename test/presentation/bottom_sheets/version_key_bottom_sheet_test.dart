import 'dart:async';

import 'package:cifraclub/domain/version/models/musical_scale.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_key_bottom_sheet.dart';
import 'package:cifraclub/presentation/widgets/key_button/key_button.dart';
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
              const VersionKeyBottomSheet(
                musicalScale: MusicalScale.majorScale,
                originalKey: "A",
                selectedKey: "B",
              ).open(context: context);
            },
          );
        },
      ),
    );

    expect(find.byType(InkWell), findsOneWidget);
    await widgetTester.tap(find.byType(InkWell));
    await widgetTester.pumpAndSettle();
    expect(find.byType(VersionKeyBottomSheet), findsOneWidget);
    expect(find.byType(KeyButton), findsNWidgets(12));
  });

  group("When bottom sheet is open", () {
    testWidgets("and a key is tapped, should return the selected key and close", (widgetTester) async {
      final completer = Completer<String>();

      await widgetTester.pumpWidgetWithWrapper(
        Builder(
          builder: (context) {
            return InkWell(
              onTap: () {
                const VersionKeyBottomSheet(
                  musicalScale: MusicalScale.majorScale,
                  originalKey: "A",
                  selectedKey: "B",
                ).open(context: context).then(completer.complete);
              },
            );
          },
        ),
      );

      await widgetTester.tap(find.byType(InkWell));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.text("C"));
      expect(await completer.future, "C");

      await widgetTester.pumpAndSettle();
      expect(find.byType(VersionKeyBottomSheet), findsNothing);
    });
  });
}
