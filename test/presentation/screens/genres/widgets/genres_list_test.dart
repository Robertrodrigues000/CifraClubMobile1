import 'dart:async';

import 'package:cifraclub/domain/genre/models/all_genres.dart';
import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:cifraclub/presentation/screens/genres/models/genre_item.dart';
import 'package:cifraclub/presentation/screens/genres/widgets/genre_header.dart';
import 'package:cifraclub/presentation/screens/genres/widgets/genres_list.dart';
import 'package:cifraclub/presentation/widgets/icon_text_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../../shared_mocks/domain/genre/models/genre_mock.dart';
import '../../../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("when genre list is not empty, should show genre tiles", (widgetTester) async {
    final allGenres = AllGenres(top: [getFakeGenre(), getFakeGenre()], all: [getFakeGenre(), getFakeGenre()]);
    final genreItems = [
      const GenreHeaderItem(type: GenreHeaderType.top),
      GenreListItem(genre: allGenres.top.first),
      GenreListItem(genre: allGenres.top.last),
      GenreDivider(),
      const GenreHeaderItem(type: GenreHeaderType.all),
      GenreListItem(genre: allGenres.all.first),
      GenreListItem(genre: allGenres.all.last),
    ];
    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidget(
        TestWrapper(
          child: GenresList(genres: genreItems, onTap: (_) {}),
        ),
      );
    });

    await widgetTester.pumpAndSettle();

    expect(find.byType(GenreHeader), findsNWidgets(2));
    expect(find.byType(IconTextTile), findsNWidgets(4));
    expect(find.byType(Divider), findsOneWidget);
  });

  testWidgets("when a genre is tapped, onTap should be called", (widgetTester) async {
    final allGenres = AllGenres(top: [getFakeGenre(), getFakeGenre()], all: [getFakeGenre(), getFakeGenre()]);
    final genreItems = [
      const GenreHeaderItem(type: GenreHeaderType.top),
      GenreListItem(genre: allGenres.top.first),
      GenreListItem(genre: allGenres.top.last),
      GenreDivider(),
      const GenreHeaderItem(type: GenreHeaderType.all),
      GenreListItem(genre: allGenres.all.first),
      GenreListItem(genre: allGenres.all.last),
    ];
    final completer = Completer<Genre>();
    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidget(
        TestWrapper(
          child: GenresList(genres: genreItems, onTap: completer.complete),
        ),
      );
    });

    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.text(allGenres.top.first.name));

    expect(completer.isCompleted, isTrue);
    expect(await completer.future, equals(allGenres.top.first));
  });
}
