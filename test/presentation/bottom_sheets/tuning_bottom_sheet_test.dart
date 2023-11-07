import 'dart:async';

import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/domain/version/models/tuning.dart';
import 'package:cifraclub/presentation/bottom_sheets/tuning_bottom_sheet.dart';
import 'package:cifraclub/presentation/widgets/selectable_item.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helpers/app_localizations.dart';
import '../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When creating a bottom sheet should open with the selected tuning selected", (widgetTester) async {
    await widgetTester.pumpWidgetWithWrapper(
      TuningBottomSheet(
        selectedTuning: Tuning.defaultTuning,
        instrument: Instrument.guitar,
        onTap: (tuning) {},
      ),
    );

    expect(find.textContaining(appTextEn.tuning), findsOneWidget);

    final selectableItem = widgetTester.firstWidget<SelectableItem>(find.byType(SelectableItem).first);
    expect(selectableItem.isSelected, isTrue);
  });

  testWidgets("When tap on item should return tuning", (widgetTester) async {
    final completer = Completer<Tuning>.sync();

    await widgetTester.pumpWidgetWithWrapper(
      TuningBottomSheet(
        selectedTuning: Tuning.defaultTuning,
        instrument: Instrument.guitar,
        onTap: completer.complete,
      ),
    );

    await widgetTester.tap(find.text(Tuning.defaultTuning.name).first, warnIfMissed: false);
    expect(completer.isCompleted, true);
    final tuning = await completer.future;
    expect(tuning, Tuning.defaultTuning);
  });
}
