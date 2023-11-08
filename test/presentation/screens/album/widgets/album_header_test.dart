import 'dart:async';

import 'package:cifraclub/presentation/constants/app_webp.dart';
import 'package:cifraclub/presentation/screens/album/widgets/album_header.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/artist_header_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When share button is tap, should call onShare callback", (widgetTester) async {
    final scrollController = ScrollController(initialScrollOffset: 60);
    final completer = Completer();

    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidget(TestWrapper(
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            AlbumHeader(
              scrollController: scrollController,
              maxOffset: 56,
              isLoading: false,
              isError: false,
              color: "#C43A3A",
              image: "",
              artistName: "Legiao Urbana",
              onShare: completer.complete,
              albumName: '',
              albumThumbSize: 80,
              releaseYear: 1998,
              totalSongs: 12,
              onTapArtistName: () {},
            ),
          ],
        ),
      ));
    });

    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.byKey(const Key("share button")));
    expect(completer.isCompleted, true);
  });
  testWidgets("When isLoading is true,should display large placeholder", (widgetTester) async {
    final scrollController = ScrollController();

    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidget(TestWrapper(
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            AlbumHeader(
              scrollController: scrollController,
              maxOffset: 56,
              isLoading: true,
              isError: false,
              color: "#C43A3A",
              image: "",
              artistName: "Legiao Urbana",
              onShare: () {},
              albumName: '',
              albumThumbSize: 80,
              releaseYear: 2023,
              totalSongs: 12,
              onTapArtistName: () {},
            ),
          ],
        ),
      ));
    });

    final headerPlaceholderFinder = find.byType(HeaderPlaceholder);
    expect(headerPlaceholderFinder, findsOneWidget);

    final headerPlaceholder = widgetTester.widget<HeaderPlaceholder>(headerPlaceholderFinder);
    expect(headerPlaceholder.placeholder, AppWebp.largePlaceholder);
  });

  testWidgets("When isError is true,should display artist placeholder", (widgetTester) async {
    final scrollController = ScrollController();

    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidget(TestWrapper(
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            AlbumHeader(
              scrollController: scrollController,
              maxOffset: 56,
              isLoading: false,
              isError: true,
              color: "#C43A3A",
              image: "",
              artistName: "Legiao Urbana",
              onShare: () {},
              albumName: '',
              albumThumbSize: 80,
              releaseYear: 2023,
              totalSongs: 12,
              onTapArtistName: () {},
            ),
          ],
        ),
      ));
    });

    final headerPlaceholderFinder = find.byType(HeaderPlaceholder);
    expect(headerPlaceholderFinder, findsOneWidget);

    final headerPlaceholder = widgetTester.widget<HeaderPlaceholder>(headerPlaceholderFinder);
    expect(headerPlaceholder.placeholder, AppWebp.artistPlaceholder);
  });

  testWidgets("When isLoading and isError are false, should show header content", (widgetTester) async {
    final scrollController = ScrollController();

    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidget(TestWrapper(
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            AlbumHeader(
              scrollController: scrollController,
              maxOffset: 56,
              isLoading: false,
              isError: false,
              color: "#C43A3A",
              image: "",
              artistName: "Legiao Urbana",
              onShare: () {},
              albumName: '',
              albumThumbSize: 80,
              releaseYear: 2023,
              totalSongs: 12,
              onTapArtistName: () {},
            ),
          ],
        ),
      ));
    });
    expect(find.byKey(const Key("Header content")), findsOneWidget);
  });

  testWidgets("When releaseYear name is valid, should show release year", (widgetTester) async {
    final scrollController = ScrollController(initialScrollOffset: 60);
    const releaseYear = 2023;
    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidget(TestWrapper(
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            AlbumHeader(
              scrollController: scrollController,
              maxOffset: 56,
              isLoading: false,
              isError: false,
              color: "#C43A3A",
              image: "",
              artistName: "Legiao Urbana",
              onShare: () {},
              albumName: '',
              albumThumbSize: 80,
              releaseYear: releaseYear,
              totalSongs: 12,
              onTapArtistName: () {},
            ),
          ],
        ),
      ));
    });

    await widgetTester.pumpAndSettle();

    expect(find.textContaining("$releaseYear"), findsOneWidget);
  });
}
