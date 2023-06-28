import 'package:cifraclub/presentation/dialogs/list_limit_dialog.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helpers/app_localizations.dart';
import '../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When isVersionLimit is true, should show limit dialog for number of versions in a list", (tester) async {
    const limitCount = 100;
    await tester.pumpWidgetWithWrapper(const ListLimitDialog(isVersionLimit: true, limitCount: limitCount));

    await tester.pumpAndSettle();
    final richText = appTextEn.versionsLimitDescription1(limitCount) +
        appTextEn.tenTimes +
        appTextEn.listLimitDescription2 +
        appTextEn.cifraClubProLimit;

    expect(find.text(appTextEn.versionsLimitTitle), findsOneWidget);
    expect(find.text(richText, findRichText: true), findsOneWidget);
  });

  testWidgets("When isVersionLimit is false, should show limit dialog for number of lists created", (tester) async {
    const limitCount = 10;
    await tester.pumpWidgetWithWrapper(const ListLimitDialog(isVersionLimit: false, limitCount: limitCount));

    await tester.pumpAndSettle();
    final richText = appTextEn.listLimitDescription1(limitCount) +
        appTextEn.hundredTimes +
        appTextEn.listLimitDescription2 +
        appTextEn.cifraClubProLimit;

    expect(find.text(appTextEn.listLimitTitle), findsOneWidget);
    expect(find.text(richText, findRichText: true), findsOneWidget);
  });

  testWidgets("when notNow button is pressed, should close dialog", (tester) async {
    const limitCount = 100;
    await tester.pumpWidgetWithWrapper(const ListLimitDialog(isVersionLimit: false, limitCount: limitCount));

    await tester.pumpAndSettle();
    await tester.tap(find.text(appTextEn.notNow));

    await tester.pumpAndSettle();
    expect(find.byType(ListLimitDialog), findsNothing);
  });
}
