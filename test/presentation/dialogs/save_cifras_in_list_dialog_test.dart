import 'package:cifraclub/presentation/dialogs/save_cifras_in_list_dialog.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When show dialog should show correctly text and calculate the percentage", (widgetTester) async {
    await widgetTester.pumpWidgetWithWrapper(const SaveCifrasInListDialog(totalCifras: 10, count: 3));

    expect(find.text("30%"), findsOneWidget);
    expect(find.text("3/10"), findsOneWidget);
  });
}
