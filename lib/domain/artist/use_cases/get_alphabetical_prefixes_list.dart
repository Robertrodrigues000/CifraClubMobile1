import 'package:cifraclub/domain/artist/models/artist_song.dart';
import 'package:collection/collection.dart';
import 'package:diacritic/diacritic.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAlphabeticalPrefixesList {
  List<String> call(List<ArtistSong> songs) {
    final alphabeticalSongs = songs.sortedBy((e) => removeDiacritics(e.name).toLowerCase());
    List<String> prefixes = [];

    final groupedSongs = alphabeticalSongs.groupListsBy(
        (e) => removeDiacritics(e.name).startsWith(RegExp("[a-zA-Z]")) ? removeDiacritics(e.name)[0] : "#");

    groupedSongs.forEach(
      (key, value) => value.forEachIndexed(
        (index, element) => index == 0 ? prefixes.add(key) : prefixes.add(""),
      ),
    );
    return prefixes;
  }
}
