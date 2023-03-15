import 'dart:async';

import 'package:cifraclub/presentation/screens/home/widgets/home_top_artists.dart';
import 'package:cifraclub/presentation/widgets/remote_image_cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../shared_mocks/domain/artist/models/artist_mock.dart';
import '../../../../test_helpers/fake_cache_manager.dart';
import '../../../../test_helpers/image_data.dart';
import '../../../../test_helpers/test_wrapper.dart';

void main() {
  late FakeCacheManager cacheManager;

  setUp(() {
    cacheManager = FakeCacheManager();
  });

  tearDown(() {
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
  });

  testWidgets("When tapping an item should show call onTap", (widgetTester) async {
    final completer = Completer();
    final artists = getFakeArtist();

    await widgetTester.pumpWidget(TestWrapper(
      child: CustomScrollView(
        slivers: [
          HomeTopArtists(
            key: const Key('artista'),
            artists: [artists],
            onTap: completer.complete,
          ),
        ],
      ),
    ));

    await widgetTester.tap(find.text(artists.name));

    expect(completer.isCompleted, isTrue);
  });

  testWidgets("When image return error should show artists placeholder", (widgetTester) async {
    final artists = getFakeArtist();
    cacheManager.throwsNotFound("");

    await widgetTester.pumpWidget(TestWrapper(
      child: RemoteImageCacheManager(
        cacheManager: cacheManager,
        child: CustomScrollView(
          slivers: [
            HomeTopArtists(
              key: const Key('artista'),
              artists: [artists],
              onTap: (_) {},
            ),
          ],
        ),
      ),
    ));

    await widgetTester.pumpAndSettle();

    expect(find.byKey(const Key("Artists placeholder")), findsOneWidget);
  });
}
