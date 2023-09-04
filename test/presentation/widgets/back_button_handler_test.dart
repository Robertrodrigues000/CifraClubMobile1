import 'package:cifraclub/presentation/widgets/back_button_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("When S.O. is Android, use WillPopScope widget", (widgetTester) async {
    await widgetTester.pumpWidget(BackButtonHandler(
      isIos: false,
      child: const SizedBox(),
      onWillPop: () => SynchronousFuture(false),
    ));
    expect(find.byType(WillPopScope), findsOneWidget);
  });
  testWidgets("When S.O. is iOS, do not use WillPopScope widget", (widgetTester) async {
    await widgetTester.pumpWidget(BackButtonHandler(
      isIos: true,
      child: const SizedBox(),
      onWillPop: () => SynchronousFuture(false),
    ));
    expect(find.byType(WillPopScope), findsNothing);
  });
}
