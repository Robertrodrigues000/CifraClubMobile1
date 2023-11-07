import 'dart:async';

import 'package:cifraclub/domain/version/models/capo.dart';
import 'package:cifraclub/presentation/bottom_sheets/capo_bottom_sheet.dart';
import 'package:cifraclub/presentation/widgets/selectable_item.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helpers/app_localizations.dart';
import '../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When creating a bottom sheet should open with the selected capo selected", (widgetTester) async {
    await widgetTester.pumpWidgetWithWrapper(
      CapoBottomSheet(
        onTap: (capo) {},
        selectedCapo: Capo.noCapo,
      ),
    );

    expect(find.textContaining(appTextEn.noCapo), findsOneWidget);

    final selectableItem = widgetTester.firstWidget<SelectableItem>(find.byType(SelectableItem).first);
    expect(selectableItem.isSelected, isTrue);
  });

  testWidgets("When tap on item should return capo", (widgetTester) async {
    final completer = Completer<Capo>.sync();

    await widgetTester.pumpWidgetWithWrapper(
      CapoBottomSheet(
        onTap: completer.complete,
        selectedCapo: Capo.noCapo,
      ),
    );

    await widgetTester.tap(find.text(appTextEn.capo3).first, warnIfMissed: false);
    expect(completer.isCompleted, true);
    final capo = await completer.future;
    expect(capo, Capo.capo3);
  });
}
