import 'dart:async';

import 'package:cifraclub/presentation/screens/top_songs/widgets/top_songs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../shared_mocks/domain/song/models/song_mock.dart';
import '../../../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("when TopSong item is tap, should call onTap callback", (widgetTester) async {
    final completer = Completer<void>();
    final topSongs = [getFakeSong(), getFakeSong()];
    await widgetTester.pumpWidget(
      TestWrapper(
        child: CustomScrollView(slivers: [
          TopSongs(
            topSongs: topSongs,
            onTap: (song) => completer.complete(),
            selectedGenre: "",
          ),
        ]),
      ),
    );
    await widgetTester.tap(
      find.byKey(
        Key(
          topSongs.first.name,
        ),
      ),
    );
    expect(completer.isCompleted, isTrue);
  });
}
