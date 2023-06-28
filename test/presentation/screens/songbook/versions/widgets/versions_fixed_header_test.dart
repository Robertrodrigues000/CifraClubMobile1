// ignore_for_file: deprecated_member_use

import 'package:cifraclub/presentation/screens/songbook/versions/widgets/versions_fixed_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../test_helpers/test_wrapper.dart';

void main() {
  final TestWidgetsFlutterBinding binding = TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("When scroll with fixed header should not hide the header", (widgetTester) async {
    await widgetTester.pumpWidgetWithWrapper(
      CustomScrollView(
        slivers: [
          const VersionsFixedHeader(
            isScrolledUnder: true,
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

    expect(find.byType(VersionsFixedHeader), findsOneWidget);

    final scrollFinder = find.byType(Scrollable).first;
    expect(scrollFinder, findsOneWidget);

    await widgetTester.scrollUntilVisible(find.byType(SizedBox).last, 50, scrollable: scrollFinder);
    await widgetTester.pump();

    expect(find.byType(VersionsFixedHeader), findsOneWidget);
  });

  testWidgets("When device is tablet, should show screen size for tablet", (widgetTester) async {
    binding.window.physicalSizeTestValue = const Size(850, 1000);
    binding.window.devicePixelRatioTestValue = 1.0;

    await widgetTester.pumpWidgetWithWrapper(
      const CustomScrollView(
        slivers: [
          VersionsFixedHeader(
            isScrolledUnder: true,
          ),
        ],
      ),
    );

    await widgetTester.pump(const Duration(seconds: 1));

    final widgetFinder = find.byType(Container).first;
    expect(widgetFinder, findsOneWidget);

    final widgetSize = widgetTester.getSize(widgetFinder);
    expect(widgetSize.height, 154);
  });

  testWidgets("When device is phone, should show screen size for phone", (widgetTester) async {
    binding.window.physicalSizeTestValue = const Size(460, 800);
    binding.window.devicePixelRatioTestValue = 1.0;

    await widgetTester.pumpWidgetWithWrapper(
      const CustomScrollView(
        slivers: [
          VersionsFixedHeader(
            isScrolledUnder: true,
          ),
        ],
      ),
    );

    await widgetTester.pump(const Duration(seconds: 1));

    final widgetFinder = find.byType(Container).first;
    expect(widgetFinder, findsOneWidget);

    final widgetSize = widgetTester.getSize(widgetFinder);
    expect(widgetSize.height, 130);
  });

  group("When `shouldRebuild` is called", () {
    test("return false if all elements are the same", () {
      final child = Container();

      final delegate1 = VersionFixedHeaderDelegate(
        haveScroll: true,
        maxExtend: 250,
        child: child,
      );

      final delegate2 = VersionFixedHeaderDelegate(
        haveScroll: true,
        maxExtend: 250,
        child: child,
      );

      expect(delegate1.shouldRebuild(delegate2), false);
    });

    test("return true if not all elements are the same", () {
      final delegate1 = VersionFixedHeaderDelegate(
        haveScroll: true,
        maxExtend: 250,
        child: Container(),
      );

      final delegate2 = VersionFixedHeaderDelegate(
        haveScroll: false,
        maxExtend: 250,
        child: Container(),
      );

      expect(delegate1.shouldRebuild(delegate2), true);
    });
  });
}
