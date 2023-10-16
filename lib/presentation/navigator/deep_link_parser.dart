import 'package:cifraclub/presentation/screens/album/album_entry.dart';
import 'package:cifraclub/presentation/screens/artist/artist_entry.dart';
import 'package:cifraclub/presentation/screens/home/home_entry.dart';
import 'package:cifraclub/presentation/screens/songbook/songbook_entry.dart';
import 'package:cifraclub/presentation/screens/songbook/versions_shared/versions_shared_entry.dart';
import 'package:nav/nav.dart';

class DeepLinkParser {
  /// ⚠️ Create new tests in deep_link_parser_test.dart file for ANY modification in this function

  List<ScreenEntry>? parseUrl(String url) {
    final List<String> uriSegments = List.from(Uri.parse(url).pathSegments, growable: true);
    uriSegments.removeWhere((element) => element.isEmpty);

    var entriesList = <ScreenEntry>[
      HomeEntry({}),
    ];

    if (uriSegments.length == 3 && uriSegments[1] == "discografia") {
      entriesList.addAll([
        ArtistEntry({ArtistEntry.artistUrlParamKey: uriSegments[0]}),
        AlbumEntry(
          {
            AlbumEntry.artistUrlParamKey: uriSegments[0],
            AlbumEntry.albumUrlParamKey: uriSegments[2],
          },
        )
      ]);
      return entriesList;
    }

    if (uriSegments.length == 4 && uriSegments[0] == "musico" && uriSegments[2] == "repertorio") {
      entriesList = [
        SongbookEntry({}),
        VersionsSharedEntry({
          VersionsSharedEntry.songbookIdParamKey: uriSegments[3],
          VersionsSharedEntry.userIdParamKey: uriSegments[1],
        })
      ];
      return entriesList;
    }

    return entriesList;
  }
}
