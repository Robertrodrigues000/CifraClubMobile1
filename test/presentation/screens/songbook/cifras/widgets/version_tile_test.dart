import 'dart:async';

import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/songbook/cifras/widgets/version_tile.dart';
import 'package:cifraclub/presentation/widgets/svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When tapping a tab item, should call onVersionTap", (widgetTester) async {
    final completer = Completer();
    await widgetTester.pumpWidgetWithWrapper(VersionTile(
        song: "Tempo Perdido",
        artist: "Legião Urbana",
        type: "Violão",
        tone: "A",
        onOptionsTap: () {},
        onVersionTap: completer.complete,
        onDeleteTap: () {},
        onDragTap: () {}));
    await widgetTester.tap(find.text("Tempo Perdido"));
    expect(completer.isCompleted, isTrue);
  });

  group("When draggable is true", () {
    final tab = VersionTile(
      song: "Tempo Perdido",
      artist: "Legião Urbana",
      type: "Violão",
      tone: "A",
      onOptionsTap: () {},
      onVersionTap: () {},
      onDeleteTap: () {},
      onDragTap: () {},
      editable: true,
    );

    testWidgets("should show delete icon", (widgetTester) async {
      await widgetTester.pumpWidgetWithWrapper(tab);

      await widgetTester.pumpAndSettle();
      expect(find.byIcon(Icons.remove_circle), findsOneWidget);
    });

    testWidgets("should hide options icon", (widgetTester) async {
      await widgetTester.pumpWidgetWithWrapper(tab);
      await widgetTester.pumpAndSettle();
      expect(
          find.byWidgetPredicate(
            (Widget widget) {
              return widget is SvgImage && widget.assetPath == AppSvgs.songbookOptionsIcon;
            },
            description: 'widget with options icon',
          ),
          findsNothing);
    });
  });
}
