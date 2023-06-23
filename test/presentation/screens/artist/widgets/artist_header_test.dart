import 'dart:async';

import 'package:cifraclub/presentation/screens/artist/widgets/artist_header.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/artist_header_tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When artist name is not empty,artist name should be displayed", (widgetTester) async {
    final scrollController = ScrollController();
    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidget(TestWrapper(
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            ArtistHeader(
              scrollController: scrollController,
              maxOffset: 56,
              isLoading: false,
              color: "#C43A3A",
              image: "",
              artistName: "Legiao Urbana",
              genreName: "",
              onFavorite: () {},
              onShare: () {},
            ),
          ],
        ),
      ));
    });

    expect(find.text("Legiao Urbana"), findsNWidgets(2));
  });

  testWidgets("When favorite is clicked, should call onFavorite", (widgetTester) async {
    final scrollController = ScrollController();
    final completer = Completer();
    await widgetTester.pumpWidget(TestWrapper(
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          ArtistHeader(
            scrollController: scrollController,
            maxOffset: 56,
            isLoading: false,
            color: "#C43A3A",
            image: "",
            artistName: "Legiao Urbana",
            genreName: "Rock",
            onFavorite: completer.complete,
            onShare: () {},
          ),
        ],
      ),
    ));
    await widgetTester.tap(find.byKey(const Key("favorite button")));
    expect(completer.isCompleted, isTrue);
  });

  testWidgets("When share is clicked, should call onShare", (widgetTester) async {
    final scrollController = ScrollController();
    final completer = Completer();

    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidget(TestWrapper(
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            ArtistHeader(
              scrollController: scrollController,
              maxOffset: 56,
              isLoading: false,
              color: "#C43A3A",
              image: "",
              artistName: "Legiao Urbana",
              genreName: "Rock",
              onFavorite: () {},
              onShare: completer.complete,
            ),
          ],
        ),
      ));
    });
    await widgetTester.tap(find.byKey(const Key("share button")));
    expect(completer.isCompleted, isTrue);
  });

  testWidgets("When genre name is empty, should not show genre tag", (widgetTester) async {
    final scrollController = ScrollController(initialScrollOffset: 60);
    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidget(TestWrapper(
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            ArtistHeader(
              scrollController: scrollController,
              maxOffset: 56,
              isLoading: false,
              color: "#C43A3A",
              image: "",
              artistName: "Legiao Urbana",
              genreName: "",
              onFavorite: () {},
              onShare: () {},
            ),
          ],
        ),
      ));
    });

    await widgetTester.pumpAndSettle();
    expect(find.byType(ArtistHeaderTag), findsNothing);
  });
}
