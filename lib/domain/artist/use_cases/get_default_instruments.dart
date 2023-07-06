import 'package:cifraclub/domain/artist/models/artist_song.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetDefaultInstruments {
  Future<List<Instrument>> call(List<ArtistSong> songs) async {
    final instruments = <Instrument>{};
    final instrumentsMaxSize = Instrument.values.length;

    for (var song in songs) {
      if (song.bass > 0) {
        instruments.add(Instrument.bass);
      }
      if (song.drums > 0) {
        instruments.add(Instrument.drums);
      }
      if (song.harmonica > 0) {
        instruments.add(Instrument.harmonica);
      }
      if (song.guitar > 0) {
        instruments.add(Instrument.guitar);
        instruments.add(Instrument.violaCaipira);
        instruments.add(Instrument.ukulele);
        instruments.add(Instrument.keyboard);
        instruments.add(Instrument.cavaco);
      }

      if (instruments.length == instrumentsMaxSize) {
        break;
      }
    }
    return instruments.toList()..sort((a, b) => a.index.compareTo(b.index));
  }
}
