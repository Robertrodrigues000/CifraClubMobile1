// coverage:ignore-file
import 'package:cifraclub/domain/version/models/instrument.dart';

enum ArtistSongFilter {
  cifra("cifra"),
  bass("bass"),
  harmonica("harmonica"),
  drums("drums");

  final String name;

  const ArtistSongFilter(this.name);

  static ArtistSongFilter getArtistSongFilterByInstrument(Instrument instrument) {
    return switch (instrument) {
      Instrument.bass => ArtistSongFilter.bass,
      Instrument.drums => ArtistSongFilter.drums,
      Instrument.harmonica => ArtistSongFilter.harmonica,
      _ => ArtistSongFilter.cifra
    };
  }
}
