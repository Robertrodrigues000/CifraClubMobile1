// ignore_for_file: deprecated_member_use
import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/widgets/versions_fixed_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../test_helpers/app_localizations.dart';
import '../../../../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When scroll with fixed header should not hide the header", (widgetTester) async {
    await widgetTester.pumpWidgetWithWrapper(
      CustomScrollView(
        slivers: [
          const VersionsFixedHeader(
            isScrolledUnder: true,
            isPro: true,
            tabsCount: 100,
            tabsLimit: 100,
            tabsLimitState: ListLimitState.reached,
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
    widgetTester.view.physicalSize = const Size(850, 1000);
    widgetTester.view.devicePixelRatio = 1.0;

    await widgetTester.pumpWidgetWithWrapper(
      const CustomScrollView(
        slivers: [
          VersionsFixedHeader(
            isScrolledUnder: true,
            isPro: true,
            tabsCount: 100,
            tabsLimit: 100,
            tabsLimitState: ListLimitState.reached,
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

  testWidgets("When device is phone, should show screen size for phone", (widgetTester) async {
    widgetTester.view.physicalSize = const Size(460, 800);
    widgetTester.view.devicePixelRatio = 1.0;

    await widgetTester.pumpWidgetWithWrapper(
      const CustomScrollView(
        slivers: [
          VersionsFixedHeader(
            isScrolledUnder: true,
            isPro: true,
            tabsCount: 100,
            tabsLimit: 100,
            tabsLimitState: ListLimitState.reached,
          ),
        ],
      ),
    );

    await widgetTester.pump(const Duration(seconds: 1));

    final widgetFinder = find.byType(Container).first;
    expect(widgetFinder, findsOneWidget);

    final widgetSize = widgetTester.getSize(widgetFinder);
    expect(widgetSize.height, 114);
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

  testWidgets("When init counter informations should show correctly", (widgetTester) async {
    await widgetTester.pumpWidgetWithWrapper(
      const CustomScrollView(
        slivers: [
          VersionsFixedHeader(
            isScrolledUnder: true,
            isPro: false,
            tabsCount: 100,
            tabsLimit: 100,
            tabsLimitState: ListLimitState.reached,
          ),
        ],
      ),
    );

    expect(find.text(appTextEn.increaseLimit), findsOneWidget);
    expect(find.textContaining("100/100", findRichText: true), findsOneWidget);
  });
}
