import 'dart:async';

import 'package:cifraclub/presentation/widgets/top_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When tapping an item, show call onTap", (widgetTester) async {
    final completer = Completer();
    await widgetTester.pumpWidget(TestWrapper(
      child: TopListItem(
        key: const Key('artista'),
        title: "Artista",
        ranking: "1",
        onTap: completer.complete,
        imageUrl: "",
      ),
    ));
    await widgetTester.tap(find.byKey(const Key("artista")));
    expect(completer.isCompleted, isTrue);
  });

  testWidgets("when trailing is not nul should show trailing", (widgetTester) async {
    await widgetTester.pumpWidget(TestWrapper(
      child: TopListItem(
        key: const Key('artista'),
        title: "Artista",
        ranking: "1",
        onTap: () {},
        trailing: const Text("trailing"),
      ),
    ));
    await widgetTester.pumpAndSettle();
    expect(find.text("trailing"), findsOneWidget);
  });

  testWidgets("when imageUrl is invalid should show correct avatar placeholder", (widgetTester) async {
    await widgetTester.pumpWidget(TestWrapper(
      child: TopListItem(
        title: "Artista",
        ranking: "1",
        onTap: () {},
      ),
    ));
    await widgetTester.pumpAndSettle();

    expect(find.byKey(const Key("avatarPlaceHolder")), findsOneWidget);
  });
}
