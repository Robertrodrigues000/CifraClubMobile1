import 'package:cifraclub/domain/artist/models/artist_song.dart';
import 'package:diacritic/diacritic.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetArtistSongsFilteredBySearch {
  (List<ArtistSong>, List<String>) call({required List<ArtistSong> songs, required String searchString}) {
    var indices = List<int>.generate(songs.length, (i) => i);
    if (searchString.trim().isNotEmpty) {
      indices = indices
          .where((element) => removeDiacritics(songs[element].name)
              .toLowerCase()
              .trim()
              .contains(removeDiacritics(searchString).toLowerCase().trim()))
          .toList();
    }
    return (indices.map((e) => songs[e]).toList(), indices.map((e) => (e + 1).toString()).toList());
  }
}
