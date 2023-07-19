// ignore_for_file: deprecated_member_use

import 'package:cifraclub/presentation/screens/songbook/versions/widgets/versions_collapsed_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When scroll with collapse header should hide the header", (widgetTester) async {
    await widgetTester.pumpWidgetWithWrapper(
      CustomScrollView(
        slivers: [
          const VersionsCollapsedHeader(
            isScrolledUnder: true,
            isPublic: false,
            songbookName: "Songbook name",
            isTablet: true,
            width: 400,
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

    expect(find.byType(VersionsCollapsedHeader), findsOneWidget);

    final listFinder = find.byType(Scrollable).first;
    expect(listFinder, findsOneWidget);

    await widgetTester.scrollUntilVisible(find.byType(SizedBox).last, 50, scrollable: listFinder);
    await widgetTester.pump();

    expect(find.byType(VersionsCollapsedHeader), findsNothing);
  });

  testWidgets("When device is tablet and text have 2 lines, should show screen size for tablet", (widgetTester) async {
    widgetTester.view.physicalSize = const Size(850, 1000);
    widgetTester.view.devicePixelRatio = 1.0;

    await widgetTester.pumpWidgetWithWrapper(
      const CustomScrollView(
        slivers: [
          VersionsCollapsedHeader(
            isScrolledUnder: true,
            isPublic: false,
            songbookName:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
            isTablet: true,
            width: 400,
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
    widgetTester.view.physicalSize = const Size(850, 1000);
    widgetTester.view.devicePixelRatio = 1.0;

    await widgetTester.pumpWidgetWithWrapper(
      const CustomScrollView(
        slivers: [
          VersionsCollapsedHeader(
            isScrolledUnder: true,
            isPublic: false,
            songbookName: "1500s",
            isTablet: true,
            width: 400,
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
    widgetTester.view.physicalSize = const Size(460, 800);
    widgetTester.view.devicePixelRatio = 1.0;

    await widgetTester.pumpWidgetWithWrapper(
      const CustomScrollView(
        slivers: [
          VersionsCollapsedHeader(
            isScrolledUnder: true,
            isPublic: false,
            songbookName:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
            isTablet: false,
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
    widgetTester.view.physicalSize = const Size(460, 800);
    widgetTester.view.devicePixelRatio = 1.0;

    await widgetTester.pumpWidgetWithWrapper(
      const CustomScrollView(
        slivers: [
          VersionsCollapsedHeader(
            isScrolledUnder: true,
            isPublic: true,
            songbookName: "1500s",
            isTablet: false,
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
    Widget getContainer({required Color color}) => Container(color: color, key: const Key('testContainer'));

    test("return false if all elements are the same", () {
      final container = getContainer(color: Colors.black);

      final delegate1 = VersionsCollapsedHeaderDelegate(isScrolledUnder: true, maxExtend: 250, child: container);

      final delegate2 = VersionsCollapsedHeaderDelegate(isScrolledUnder: true, maxExtend: 250, child: container);

      expect(delegate1.shouldRebuild(delegate2), false);
    });

    test("return true if not all elements are the same", () {
      final container = getContainer(color: Colors.black);

      final delegate1 = VersionsCollapsedHeaderDelegate(isScrolledUnder: true, maxExtend: 250, child: container);

      final delegate2 = VersionsCollapsedHeaderDelegate(isScrolledUnder: false, maxExtend: 250, child: container);

      expect(delegate1.shouldRebuild(delegate2), true);
    });
  });
}
