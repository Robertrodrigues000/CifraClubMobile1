// coverage:ignore-file
import 'package:cifraclub/domain/search/models/search_models/song_search.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:equatable/equatable.dart';

class SongbookVersionInput extends Equatable {
  final String? artistUrl;
  final int? capo;
  final int? versionId;
  final int? id;
  final String? instrument;
  final String? songUrl;
  final String? key;
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
    this.key,
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
          id: version.remoteDatabaseId,
          versionId: version.versionId,
          artistUrl: version.artist.url,
          songUrl: version.songUrl,
          instrument: version.instrument.instrumentUrl,
          capo: version.capo?.capoId,
          key: version.key,
          tuning: version.tuning?.value,
          type: version.instrument.apiType,
        );

  @override
  List<Object?> get props => [artistUrl, capo, versionId, id, instrument, songUrl, key, tuning, type, versionLabel];
}
