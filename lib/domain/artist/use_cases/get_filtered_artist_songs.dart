import 'package:cifraclub/domain/artist/models/artist_song.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetFilteredArtistSongs {
  Future<List<ArtistSong>> call(List<ArtistSong> songs, Instrument? instrument) async {
    if (instrument == null) {
      return songs;
    } else {
      final filteredSongs = <ArtistSong>[];
      for (var song in songs) {
        if (instrument == Instrument.bass && song.bass > 0) {
          filteredSongs.add(song);
        }
        if (instrument == Instrument.drums && song.drums > 0) {
          filteredSongs.add(song);
        }
        if (instrument == Instrument.harmonica && song.harmonica > 0) {
          filteredSongs.add(song);
        }
        if (instrument != Instrument.bass &&
            instrument != Instrument.drums &&
            instrument != Instrument.harmonica &&
            song.guitar > 0) {
          filteredSongs.add(song);
        }
      }
      return filteredSongs;
    }
  }
}
