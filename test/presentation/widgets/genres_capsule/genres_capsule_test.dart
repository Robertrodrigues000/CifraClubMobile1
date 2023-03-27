import 'package:cifraclub/presentation/widgets/filter_capsule/filter_capsule.dart';
import 'package:cifraclub/presentation/widgets/genres_capsule/genres_capsule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../shared_mocks/domain/genre/models/genre_mock.dart';
import '../../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When genre all is selected should show all checked", (widgetTester) async {
    await widgetTester.pumpWidget(
      TestWrapper(
        child: GenresCapsule(
          genres: [getFakeGenre(), getFakeGenre()],
          selectedGenre: null,
          onGenreSelected: (_) {},
          onMore: () async => true,
        ),
      ),
    );

    final finder = widgetTester.widget<Text>(find.text("All"));

    expect(finder.style?.color, Colors.white);
  });

  testWidgets("When tap in first capsule should return correctly empty string", (widgetTester) async {
    String? genreUrl;
    final genres = [getFakeGenre(), getFakeGenre()];

    await widgetTester.pumpWidget(
      TestWrapper(
        child: GenresCapsule(
          genres: genres,
          selectedGenre: "",
          onGenreSelected: (genre) {
            genreUrl = genre;
          },
          onMore: () async => true,
        ),
      ),
    );

    await widgetTester.tap(find.byType(FilterCapsule).first);
    await widgetTester.pumpAndSettle();

    expect(genreUrl, isNull);
  });

  testWidgets("When tap should return correctly genreUrl", (widgetTester) async {
    String? genreUrl;
    final genres = [getFakeGenre(), getFakeGenre()];

    await widgetTester.pumpWidget(
      TestWrapper(
        child: GenresCapsule(
          genres: genres,
          selectedGenre: "",
          onGenreSelected: (genre) {
            genreUrl = genre;
          },
          onMore: () async => true,
        ),
      ),
    );

    await widgetTester.tap(find.byType(FilterCapsule).at(1));
    await widgetTester.pumpAndSettle();

    expect(genreUrl, genres.first.url);
  });

  testWidgets("When tap in more should scroll to init", (widgetTester) async {
    final genres = [
      getFakeGenre(),
      getFakeGenre(),
      getFakeGenre(),
      getFakeGenre(),
      getFakeGenre(),
      getFakeGenre(),
      getFakeGenre(),
    ];

    await widgetTester.pumpWidget(
      TestWrapper(
        child: GenresCapsule(
          genres: genres,
          selectedGenre: "",
          onGenreSelected: (_) {},
          onMore: () async => true,
        ),
      ),
    );

    await widgetTester.scrollUntilVisible(find.text("More"), 100);
    await widgetTester.pump();

    expect(find.text("All"), findsNothing);

    await widgetTester.tap(find.byType(FilterCapsule).last);
    await widgetTester.pumpAndSettle();

    expect(find.text("All"), findsOneWidget);
  });
}
