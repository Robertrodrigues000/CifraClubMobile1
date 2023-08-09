import 'package:cifraclub/domain/search/models/song_search.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:equatable/equatable.dart';

class SongbookVersionInput extends Equatable {
  final String? artistUrl;
  final int? capo;
  final int? versionId;
  final int? id;
  final String? instrument;
  final String? songUrl;
  final String? tone;
  final String? tuning;
  final int? type;
  final String? versionLabel;

  const SongbookVersionInput({
    this.artistUrl,
    this.capo,
    this.versionId,
    this.id,
    this.instrument,
    this.songUrl,
    this.tone,
    this.tuning,
    this.type,
    this.versionLabel,
  });

  SongbookVersionInput.fromSongSearch(SongSearch song)
      : this(
          artistUrl: song.artistUrl,
          songUrl: song.songUrl,
        );

  SongbookVersionInput.fromVersion(Version version)
      : this(
          id: version.remoteDatabaseID,
          versionId: version.versionId,
          artistUrl: version.artist.url,
          songUrl: version.songUrl,
          instrument: Instrument.getInstrumentByType(version.type)?.instrumentUrl,
          capo: version.capo,
          tone: version.tone,
          tuning: version.tuning,
          type: version.type,
        );

  @override
  List<Object?> get props => [artistUrl, capo, versionId, id, instrument, songUrl, tone, tuning, type, versionLabel];
}
