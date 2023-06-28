import 'dart:async';

import 'package:cifraclub/domain/home/models/news.dart';
import 'package:cifraclub/presentation/screens/home/widgets/news/blog.dart';
import 'package:cifraclub/presentation/screens/home/widgets/news/news_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../../shared_mocks/domain/home/models/news_mock.dart';
import '../../../../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("when news is not empty should show news items", (widgetTester) async {
    final news = [getFakeNews(), getFakeNews()];

    await widgetTester.pumpWidget(
      TestWrapper(
        child: CustomScrollView(slivers: [
          Blog(
            list: news,
            onTap: (_) {},
          ),
        ]),
      ),
    );

    await widgetTester.pump();

    expect(find.byType(NewsItem), findsNWidgets(2));
  });

  testWidgets("when news item is tapped, should trigger onTap callback", (widgetTester) async {
    final newsList = [getFakeNews(), getFakeNews()];
    final completer = Completer<News>();
    await widgetTester.pumpWidget(
      TestWrapper(
        child: CustomScrollView(slivers: [
          Blog(
            list: newsList,
            onTap: completer.complete,
          )
        ]),
      ),
    );

    await widgetTester.pumpAndSettle();

    await widgetTester.tap(
      find
          .byKey(
            Key(newsList.first.headline),
          )
          .first,
    );
    expect(completer.isCompleted, isTrue);
    expect((await completer.future).headline, newsList.first.headline);
  });
}
