import 'dart:async';

import 'package:cifraclub/presentation/screens/top_artists/widgets/top_artists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../shared_mocks/domain/artist/models/artist_mock.dart';
import '../../../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("when TopArtist is tapped, should call onTap callback", (widgetTester) async {
    final completer = Completer<void>();
    final topArtists = [getFakeArtist(), getFakeArtist()];

    await widgetTester.pumpWidget(
      TestWrapper(
        child: CustomScrollView(slivers: [
          TopArtists(
            topArtists: topArtists,
            onTap: (artist) => completer.complete(),
            selectedGenre: "",
          ),
        ]),
      ),
    );

    await widgetTester.tap(
      find.byKey(
        Key(
          topArtists.first.name,
        ),
      ),
    );

    expect(completer.isCompleted, isTrue);
  });
}
