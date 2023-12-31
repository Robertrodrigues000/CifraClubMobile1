import 'package:cifraclub/presentation/dialogs/list_limit_pro_dialog.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helpers/app_localizations.dart';
import '../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When isVersionLimit is true, should show pro limit dialog for number of versions in a list",
      (tester) async {
    const limitCount = 1000;
    await tester.pumpWidgetWithWrapper(const ListLimitProDialog(
      isVersionLimit: true,
      limitCount: limitCount,
    ));

    await tester.pumpAndSettle();
    final richText = "${appTextEn.versionsLimitProDescription1}$limitCount ${appTextEn.versionsLimitProDescription2}";

    expect(find.text(appTextEn.versionsLimitProTitle(limitCount)), findsOneWidget);
    expect(find.text(richText, findRichText: true), findsOneWidget);
  });

  testWidgets("When isVersionLimit is false, should show pro limit dialog for number of lists created", (tester) async {
    const limitCount = 1000;
    await tester.pumpWidgetWithWrapper(const ListLimitProDialog(
      isVersionLimit: false,
      limitCount: limitCount,
    ));

    await tester.pumpAndSettle();
    final richText = "${appTextEn.listLimitProDescription1}$limitCount ${appTextEn.listLimitProDescription2}";

    expect(find.text(appTextEn.listLimitProTitle(limitCount)), findsOneWidget);
    expect(find.text(richText, findRichText: true), findsOneWidget);
  });

  testWidgets("when gotIt button is pressed, should close dialog", (tester) async {
    const limitCount = 1000;
    await tester.pumpWidgetWithWrapper(const ListLimitProDialog(isVersionLimit: false, limitCount: limitCount));

    await tester.pumpAndSettle();
    await tester.tap(find.text(appTextEn.gotIt));

    await tester.pumpAndSettle();
    expect(find.byType(ListLimitProDialog), findsNothing);
  });
}
