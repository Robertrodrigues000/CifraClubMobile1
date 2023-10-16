import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/widgets/songbook_information_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When scroll with collapse header should hide the header", (widgetTester) async {
    await widgetTester.pumpWidgetWithWrapper(
      CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: SongbookInformationSection(
              isScrolledUnder: true,
              isPublic: false,
              songbookName: "Songbook name",
              listType: ListType.user,
              preview: [],
              isPro: false,
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

    expect(find.byType(SongbookInformationSection), findsOneWidget);

    final listFinder = find.byType(Scrollable).first;
    expect(listFinder, findsOneWidget);

    await widgetTester.scrollUntilVisible(find.byType(SizedBox).last, 50, scrollable: listFinder);
    await widgetTester.pump();

    expect(find.byType(SongbookInformationSection), findsNothing);
  });

  testWidgets("When songbook is not null should show username", (widgetTester) async {
    const username = "Joao";
    await widgetTester.pumpWidgetWithWrapper(
      CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: SongbookInformationSection(
              isScrolledUnder: true,
              isPublic: false,
              songbookName: "Songbook name",
              listType: ListType.user,
              preview: [],
              isPro: false,
              userName: username,
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
    expect(find.text(username), findsOneWidget);
  });
}
