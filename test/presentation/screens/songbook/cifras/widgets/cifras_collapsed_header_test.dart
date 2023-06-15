// ignore_for_file: deprecated_member_use

import 'package:cifraclub/presentation/screens/songbook/cifras/widgets/cifras_collapsed_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../test_helpers/test_wrapper.dart';

void main() {
  final TestWidgetsFlutterBinding binding = TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("When scroll with collapse header should hide the header", (widgetTester) async {
    await widgetTester.pumpWidgetWithWrapper(
      CustomScrollView(
        slivers: [
          const CifrasCollapsedHeader(
            isScrolledUnder: true,
            isPublic: false,
            songbookName: "Songbook name",
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 50,
              (context, index) => const SizedBox(
                height: 50,
              ),
            ),
          ),
        ],
      ),
    );

    expect(find.byType(CifrasCollapsedHeader), findsOneWidget);

    final listFinder = find.byType(Scrollable).first;
    expect(listFinder, findsOneWidget);

    await widgetTester.scrollUntilVisible(find.byType(SizedBox).last, 50, scrollable: listFinder);
    await widgetTester.pump();

    expect(find.byType(CifrasCollapsedHeader), findsNothing);
  });

  testWidgets("When device is tablet and text have 2 lines, should show screen size for tablet", (widgetTester) async {
    binding.window.physicalSizeTestValue = const Size(850, 1000);
    binding.window.devicePixelRatioTestValue = 1.0;

    await widgetTester.pumpWidgetWithWrapper(
      const CustomScrollView(
        slivers: [
          CifrasCollapsedHeader(
            isScrolledUnder: true,
            isPublic: false,
            songbookName:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
          ),
        ],
      ),
    );

    await widgetTester.pump(const Duration(seconds: 1));

    final widgetFinder = find.byType(Container).first;
    expect(widgetFinder, findsOneWidget);

    final singleScrollFinder = find.byType(SingleChildScrollView).first;
    expect(singleScrollFinder, findsOneWidget);

    final widgetSize = widgetTester.getSize(widgetFinder);
    final singleScrollSize = widgetTester.getSize(widgetFinder);
    expect(widgetSize.height, 148);
    expect(widgetSize.height, singleScrollSize.height);
  });

  testWidgets("When device is tablet and text have 1 lines, should show screen size for tablet", (widgetTester) async {
    binding.window.physicalSizeTestValue = const Size(850, 1000);
    binding.window.devicePixelRatioTestValue = 1.0;

    await widgetTester.pumpWidgetWithWrapper(
      const CustomScrollView(
        slivers: [
          CifrasCollapsedHeader(
            isScrolledUnder: true,
            isPublic: false,
            songbookName: "1500s",
          ),
        ],
      ),
    );

    await widgetTester.pump(const Duration(seconds: 1));

    final widgetFinder = find.byType(Container).first;
    expect(widgetFinder, findsOneWidget);

    final singleScrollFinder = find.byType(SingleChildScrollView).first;
    expect(singleScrollFinder, findsOneWidget);

    final widgetSize = widgetTester.getSize(widgetFinder);
    final singleScrollSize = widgetTester.getSize(widgetFinder);
    expect(widgetSize.height, 124);
    expect(widgetSize.height, singleScrollSize.height);
  });

  testWidgets("When device is phone and text have 2 lines, should show screen size for phone", (widgetTester) async {
    binding.window.physicalSizeTestValue = const Size(460, 800);
    binding.window.devicePixelRatioTestValue = 1.0;

    await widgetTester.pumpWidgetWithWrapper(
      const CustomScrollView(
        slivers: [
          CifrasCollapsedHeader(
            isScrolledUnder: true,
            isPublic: false,
            songbookName:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
          ),
        ],
      ),
    );

    await widgetTester.pump(const Duration(seconds: 1));

    final widgetFinder = find.byType(Container).first;
    expect(widgetFinder, findsOneWidget);

    final singleScrollFinder = find.byType(SingleChildScrollView).first;
    expect(singleScrollFinder, findsOneWidget);

    final widgetSize = widgetTester.getSize(widgetFinder);
    final singleScrollSize = widgetTester.getSize(widgetFinder);
    expect(widgetSize.height, 132);
    expect(widgetSize.height, singleScrollSize.height);
  });

  testWidgets("When device is phone and text have 1 line, should show screen size for phone", (widgetTester) async {
    binding.window.physicalSizeTestValue = const Size(460, 800);
    binding.window.devicePixelRatioTestValue = 1.0;

    await widgetTester.pumpWidgetWithWrapper(
      const CustomScrollView(
        slivers: [
          CifrasCollapsedHeader(
            isScrolledUnder: true,
            isPublic: true,
            songbookName: "1500s",
          ),
        ],
      ),
    );

    await widgetTester.pump(const Duration(seconds: 1));

    final widgetFinder = find.byType(Container).first;
    expect(widgetFinder, findsOneWidget);

    final singleScrollFinder = find.byType(SingleChildScrollView).first;
    expect(singleScrollFinder, findsOneWidget);

    final widgetSize = widgetTester.getSize(widgetFinder);
    final singleScrollSize = widgetTester.getSize(widgetFinder);
    expect(widgetSize.height, 108);
    expect(widgetSize.height, singleScrollSize.height);
  });

  group("When `shouldRebuild` is called", () {
    test("return false if all elements are the same", () {
      final delegate1 = CifrasCollapsedHeaderDelegate(
        isScrolledUnder: true,
        isPublic: true,
        maxExtend: 250,
        songbookName: 'Teste',
      );

      final delegate2 = CifrasCollapsedHeaderDelegate(
        isScrolledUnder: true,
        isPublic: true,
        maxExtend: 250,
        songbookName: 'Teste',
      );

      expect(delegate1.shouldRebuild(delegate2), false);
    });

    test("return true if not all elements are the same", () {
      final delegate1 = CifrasCollapsedHeaderDelegate(
        isScrolledUnder: true,
        isPublic: true,
        maxExtend: 250,
        songbookName: 'Teste',
      );

      final delegate2 = CifrasCollapsedHeaderDelegate(
        isScrolledUnder: true,
        isPublic: false,
        maxExtend: 250,
        songbookName: 'Teste',
      );

      expect(delegate1.shouldRebuild(delegate2), true);
    });
  });
}
