import 'package:cifraclub/domain/chord/models/instrument_chord_representation.dart';
import 'package:cifraclub/domain/version/models/capo.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/presentation/bottom_sheets/chord_shape_bottom_sheet.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/domain/chord/models/neck.dart';
import 'package:cifraclub/presentation/screens/version/widgets/chord/capo_widget.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/cifraclub_button.dart';
import 'package:cifraclub/presentation/widgets/svg_image.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../shared_mocks/domain/chord/chord_representation_mock.dart';
import '../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When creating a bottom sheet should open with the selected shape visible", (widgetTester) async {
    final shapes = List.generate(5, (index) => getFakeChordRepresentation(name: "A"));
    final selectedChord = shapes[2];

    await widgetTester.pumpWidgetWithWrapper(
      ChordShapeBottomSheet(
        selectedChord: selectedChord,
        shapes: shapes,
        instrument: Instrument.guitar,
        onTap: (chord) {},
      ),
    );

    expect(find.byKey(ValueKey(selectedChord.original)), findsOneWidget);
  });

  testWidgets("When shapes has one item should not show arrow buttons", (widgetTester) async {
    final shapes = [getFakeChordRepresentation(name: "A")];
    final selectedChord = shapes.first;

    await widgetTester.pumpWidgetWithWrapper(
      ChordShapeBottomSheet(
        selectedChord: selectedChord,
        shapes: shapes,
        instrument: Instrument.guitar,
        onTap: (chord) {},
      ),
    );

    expect(find.byKey(const ValueKey("leftArrow")), findsNothing);
    expect(find.byKey(const ValueKey("rightArrow")), findsNothing);
  });

  testWidgets("When showing the last item should disable right arrow button", (widgetTester) async {
    final shapes = [
      getFakeChordRepresentation(name: "A"),
      getFakeChordRepresentation(name: "A"),
      getFakeChordRepresentation(name: "A")
    ];
    final selectedChord = shapes.last;

    await widgetTester.pumpWidgetWithWrapper(
      ChordShapeBottomSheet(
        selectedChord: selectedChord,
        shapes: shapes,
        instrument: Instrument.guitar,
        onTap: (chord) {},
      ),
    );
    final finder = find.byWidgetPredicate(
      (Widget widget) =>
          widget is IgnorePointer && widget.key == const ValueKey("rightArrow") && widget.ignoring == true,
    );
    expect(finder, findsOneWidget);
  });

  testWidgets("When showing the first item should disable left arrow button", (widgetTester) async {
    final shapes = [
      getFakeChordRepresentation(name: "A"),
      getFakeChordRepresentation(name: "A"),
      getFakeChordRepresentation(name: "A")
    ];
    final selectedChord = shapes.first;

    await widgetTester.pumpWidgetWithWrapper(
      ChordShapeBottomSheet(
        selectedChord: selectedChord,
        shapes: shapes,
        instrument: Instrument.guitar,
        onTap: (chord) {},
      ),
    );
    final finder = find.byWidgetPredicate(
      (Widget widget) =>
          widget is IgnorePointer && widget.key == const ValueKey("leftArrow") && widget.ignoring == true,
    );
    expect(finder, findsOneWidget);
  });

  testWidgets("When tap on right arrow button should show next chord", (widgetTester) async {
    final shapes = List.generate(5, (index) => getFakeChordRepresentation(name: "A"));
    final selectedChord = shapes[3];

    await widgetTester.pumpWidgetWithWrapper(
      ChordShapeBottomSheet(
        selectedChord: selectedChord,
        shapes: shapes,
        instrument: Instrument.guitar,
        onTap: (chord) {},
      ),
    );
    await widgetTester.tap(find.byKey(const ValueKey("rightArrow")));
    await widgetTester.pump();
    expect(find.byKey(ValueKey(shapes[4].original)), findsOneWidget);
  });

  testWidgets("When tap on left arrow button should show previous chord", (widgetTester) async {
    final shapes = List.generate(5, (index) => getFakeChordRepresentation(name: "A"));
    final selectedChord = shapes[3];

    await widgetTester.pumpWidgetWithWrapper(
      ChordShapeBottomSheet(
        selectedChord: selectedChord,
        shapes: shapes,
        instrument: Instrument.guitar,
        onTap: (chord) {},
      ),
    );
    await widgetTester.tap(find.byKey(const ValueKey("leftArrow")));
    await widgetTester.pump();
    expect(find.byKey(ValueKey(shapes[2].original)), findsOneWidget);
  });

  testWidgets("When showing shape different from default should enable restore button", (widgetTester) async {
    final shapes = [
      getFakeChordRepresentation(name: "A"),
      getFakeChordRepresentation(name: "A"),
      getFakeChordRepresentation(name: "A")
    ];
    final selectedChord = shapes.last;

    await widgetTester.pumpWidgetWithWrapper(
      ChordShapeBottomSheet(
        selectedChord: selectedChord,
        shapes: shapes,
        instrument: Instrument.guitar,
        onTap: (chord) {},
      ),
    );
    final finder = find.byWidgetPredicate(
      (Widget widget) =>
          widget is SvgImage && widget.key == const ValueKey("restoreButton") && widget.color == CosmosColors.grey10,
    );
    expect(finder, findsOneWidget);
  });

  testWidgets("When tap on restore button should show default chord", (widgetTester) async {
    final shapes = List.generate(5, (index) => getFakeChordRepresentation(name: "A"));
    final selectedChord = shapes[3];

    await widgetTester.pumpWidgetWithWrapper(
      ChordShapeBottomSheet(
        selectedChord: selectedChord,
        shapes: shapes,
        instrument: Instrument.guitar,
        onTap: (chord) {},
      ),
    );
    await widgetTester.tap(find.byType(CifraClubButton));
    await widgetTester.pump();
    expect(find.byKey(ValueKey(shapes[0].original)), findsOneWidget);
  });

  testWidgets("When chord has capo should show capo", (widgetTester) async {
    final shapes = [
      getFakeChordRepresentation(name: "A", capo: Capo.capo10, neck: const Neck(start: 0)),
      getFakeChordRepresentation(name: "A", capo: Capo.capo10, neck: const Neck(start: 0)),
      getFakeChordRepresentation(name: "A", capo: Capo.capo10, neck: const Neck(start: 0))
    ];
    final selectedChord = shapes.last;

    await widgetTester.pumpWidgetWithWrapper(
      ChordShapeBottomSheet(
        selectedChord: selectedChord,
        shapes: shapes,
        instrument: Instrument.guitar,
        onTap: (chord) {},
      ),
    );

    expect(find.byType(CapoWidget), findsOneWidget);
  });

  testWidgets("When chord instrument is viola should use viola assets", (widgetTester) async {
    final shapes = [
      getFakeChordRepresentation(name: "A", capo: Capo.capo10, instrument: ViolaChordRepresentation()),
      getFakeChordRepresentation(name: "A", capo: Capo.capo10, instrument: ViolaChordRepresentation()),
      getFakeChordRepresentation(name: "A", capo: Capo.capo10, instrument: ViolaChordRepresentation())
    ];
    final selectedChord = shapes.last;

    await widgetTester.pumpWidgetWithWrapper(
      ChordShapeBottomSheet(
        selectedChord: selectedChord,
        shapes: shapes,
        instrument: Instrument.violaCaipira,
        onTap: (chord) {},
      ),
    );
    final finder = find.byWidgetPredicate(
      (Widget widget) => widget is SvgImage && widget.assetPath == AppSvgs.violaStrings,
    );
    expect(finder, findsOneWidget);
  });

  testWidgets("When chord instrument is cavaco or ukuelele should use cavaco ukulele assets", (widgetTester) async {
    final shapes = [
      getFakeChordRepresentation(name: "A", capo: Capo.capo10, instrument: CavacoChordRepresentation()),
      getFakeChordRepresentation(name: "A", capo: Capo.capo10, instrument: CavacoChordRepresentation()),
      getFakeChordRepresentation(name: "A", capo: Capo.capo10, instrument: CavacoChordRepresentation())
    ];
    final selectedChord = shapes.last;

    await widgetTester.pumpWidgetWithWrapper(
      ChordShapeBottomSheet(
        selectedChord: selectedChord,
        shapes: shapes,
        instrument: Instrument.cavaco,
        onTap: (chord) {},
      ),
    );
    final finder = find.byWidgetPredicate(
      (Widget widget) => widget is SvgImage && widget.assetPath == AppSvgs.ukuleleCavacoStrings,
    );
    expect(finder, findsOneWidget);
  });
}
