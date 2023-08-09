import 'package:cifraclub/presentation/screens/artist_songs/widgets/artist_songs_collapsed_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When scroll with collapse header should hide the header", (widgetTester) async {
    await widgetTester.pumpWidgetWithWrapper(
      CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: ArtistSongsCollapsedHeader(
              isScrolledUnder: true,
              artist: "Artista",
              filter: "Todos",
              totalSongs: 150,
            ),
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

    expect(find.byType(ArtistSongsCollapsedHeader), findsOneWidget);

    final listFinder = find.byType(Scrollable).first;
    expect(listFinder, findsOneWidget);

    await widgetTester.scrollUntilVisible(find.byType(SizedBox).last, 50, scrollable: listFinder);
    await widgetTester.pump();

    expect(find.byType(ArtistSongsCollapsedHeader), findsNothing);
  });
}
