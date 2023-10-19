import 'dart:async';

import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/presentation/bottom_sheets/instruments_versions_bottom_sheet/instruments_versions_bottom_sheet.dart';
import 'package:cifraclub/presentation/screens/version/version_filter.dart';
import 'package:cifraclub/presentation/widgets/selectable_item.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../shared_mocks/domain/version/models/instrument_version_mock.dart';
import '../../../test_helpers/app_localizations.dart';
import '../../../test_helpers/test_wrapper.dart';

void main() {
  final version = [getFakeInstrumentVersion(), getFakeInstrumentVersion()];

  final instrumentVersions = [
    (instrument: Instrument.bass, versions: version),
    (instrument: Instrument.harmonica, versions: version),
    (instrument: Instrument.guitar, versions: version),
  ];

  testWidgets("When creating a bottom sheet should open with the selected instrument and version selected",
      (widgetTester) async {
    await widgetTester.pumpWidgetWithWrapper(
      InstrumentVersionsBottomSheet(
        instrumentVersions: instrumentVersions,
        selectedInstrument: Instrument.bass,
        selectedVersionName: version.first.versionName,
        onTap: (versionFilter) {},
      ),
    );

    expect(find.textContaining(appTextEn.instrumentBass, findRichText: true), findsOneWidget);
    expect(find.textContaining(appTextEn.instrumentHarmonica, findRichText: true), findsOneWidget);
    expect(find.textContaining(appTextEn.instrumentGuitar, findRichText: true), findsOneWidget);

    final selectableItem = widgetTester.firstWidget<SelectableItem>(find.byType(SelectableItem).first);
    expect(selectableItem.isSelected, isTrue);
  });

  testWidgets("When tap on item should return versionFilter", (widgetTester) async {
    final completer = Completer<VersionFilter>.sync();

    await widgetTester.pumpWidgetWithWrapper(
      InstrumentVersionsBottomSheet(
        instrumentVersions: instrumentVersions,
        selectedInstrument: Instrument.bass,
        selectedVersionName: version.first.versionName,
        onTap: (versionFilter) {
          completer.complete(versionFilter);
        },
      ),
    );

    await widgetTester.tap(find.text(version.last.versionName).first, warnIfMissed: false);
    expect(completer.isCompleted, true);
    final versionFilter = await completer.future;
    expect(versionFilter.instrument, Instrument.bass);
    expect(versionFilter.isVerified, version.last.isVerified);
    expect(versionFilter.versionName, version.last.versionName);
    expect(versionFilter.versionUrl, version.last.versionUrl);
  });
}
