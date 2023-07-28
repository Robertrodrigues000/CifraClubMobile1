import 'package:cifraclub/presentation/screens/artist_songs/widgets/artist_songs_fixed_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When scroll with fixed header should not hide the header", (widgetTester) async {
    await widgetTester.pumpWidgetWithWrapper(Scaffold(
      body: CustomScrollView(
        slivers: [
          ArtistSongsFixedHeader(
              isScrolledUnder: true,
              tabController: TabController(length: 3, vsync: const TestVSync(), initialIndex: 0),
              pageController: PageController(),
              shouldShowSearch: true),
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
    ));

    expect(find.byType(ArtistSongsFixedHeader), findsOneWidget);

    final scrollFinder = find.byType(Scrollable).first;
    expect(scrollFinder, findsOneWidget);

    await widgetTester.scrollUntilVisible(find.byType(SizedBox).last, 50, scrollable: scrollFinder);
    await widgetTester.pump();

    expect(find.byType(ArtistSongsFixedHeader), findsOneWidget);
  });

  group("When `shouldRebuild` is called", () {
    test("return false if all elements are the same", () {
      final child = Container();

      final delegate1 = ArtistSongsFixedHeaderDelegate(maxExtend: 250, child: child, haveScroll: true);

      final delegate2 = ArtistSongsFixedHeaderDelegate(maxExtend: 250, child: child, haveScroll: true);

      expect(delegate1.shouldRebuild(delegate2), false);
    });

    test("return true if not all elements are the same", () {
      final delegate1 = ArtistSongsFixedHeaderDelegate(maxExtend: 250, child: Container(), haveScroll: true);

      final delegate2 = ArtistSongsFixedHeaderDelegate(maxExtend: 250, child: Container(), haveScroll: false);

      expect(delegate1.shouldRebuild(delegate2), true);
    });
  });
}
