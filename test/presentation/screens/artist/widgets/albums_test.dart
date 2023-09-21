import 'package:cifraclub/domain/artist/models/album.dart';
import 'package:cifraclub/domain/search/models/search_models/album_search.dart';
import 'package:cifraclub/domain/search/models/search_models/search_item.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/album_item.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/albums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../shared_mocks/domain/artist/models/album_mock.dart';
import '../../../../shared_mocks/domain/search/models/search_mock.dart';
import '../../../../test_helpers/app_localizations.dart';
import '../../../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When searchItems is not empty should show list with SearchAlbum`s", (widgetTester) async {
    List<SearchItem> searchItems = [getFakeAlbumSearch(), getFakeAlbumSearch(), getFakeAlbumSearch()];
    await widgetTester.pumpWidgetWithWrapper(
      CustomScrollView(
        slivers: [
          Albums(
            searchItems: searchItems,
          ),
        ],
      ),
    );

    expect(find.byType(AlbumItem), findsNWidgets(searchItems.length));
    for (var item in searchItems) {
      expect(find.text((item as AlbumSearch).artistName), findsOneWidget);
    }
  });

  testWidgets("When albums is not empty should show list with Album`s", (widgetTester) async {
    List<Album> albums = [getFakeAlbum(), getFakeAlbum(), getFakeAlbum()];
    await widgetTester.pumpWidgetWithWrapper(
      CustomScrollView(
        slivers: [
          Albums(
            albums: albums,
          ),
        ],
      ),
    );

    expect(find.byType(AlbumItem), findsNWidgets(albums.length));
    for (var album in albums) {
      expect(find.text("${album.totalSongs} ${appTextEn.songs(album.totalSongs ?? 0)} • ${album.releaseYear}"),
          findsOneWidget);
    }
  });
}
