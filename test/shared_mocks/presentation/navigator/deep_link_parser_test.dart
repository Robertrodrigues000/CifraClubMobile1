import 'package:cifraclub/presentation/navigator/deep_link_parser.dart';
import 'package:cifraclub/presentation/screens/album/album_entry.dart';
import 'package:cifraclub/presentation/screens/artist/artist_entry.dart';
import 'package:cifraclub/presentation/screens/home/home_entry.dart';
import 'package:cifraclub/presentation/screens/songbook/songbook_entry.dart';
import 'package:cifraclub/presentation/screens/songbook/versions_shared/versions_shared_entry.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nav/nav.dart';

void main() {
  group("When parseUrl is called", () {
    test('when url is from artist album should return correct entries', () async {
      const url = "https://www.cifraclub.com.br/bruno-e-marrone/discografia/studio-bar-ao-vivo-2019";
      final deepLinkParser = DeepLinkParser();

      final entries = deepLinkParser.parseUrl(url);

      expect(entries, isA<List<ScreenEntry>>());
      expect(entries?[0], isA<HomeEntry>());
      expect(entries?[1], isA<ArtistEntry>());
      expect(entries?[2], isA<AlbumEntry>());
    });

    test('when url is from shared list should return correct entries', () async {
      const url = "https://www.cifraclub.com.br/musico/546085489/repertorio/10377538";
      final deepLinkParser = DeepLinkParser();

      final entries = deepLinkParser.parseUrl(url);

      expect(entries, isA<List<ScreenEntry>>());
      expect(entries?[0], isA<SongbookEntry>());
      expect(entries?[1], isA<VersionsSharedEntry>());
    });
  });
}
