// ignore_for_file: must_be_immutable
import 'package:cifraclub/data/version/models/user_version/user_version_artist_dto.dart';
import 'package:cifraclub/domain/version/models/capo.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'user_recent_version_dto.g.dart';

@CopyWith()
@Collection(inheritance: false)
class UserRecentVersionDto extends Equatable {
  final Id localDatabaseId;
  final String name;
  final int versionId;
  final String songUrl;
  final String? key;
  @enumerated
  final Instrument instrument;
  @Index()
  final int songId;
  final String? stdKey;
  final int? capo;
  final String? tuning;
  final UserVersionArtistDto artist;
  @Index()
  final String? artistImage;
  @Index()
  final DateTime lastUpdate;

  UserRecentVersionDto({
    required this.localDatabaseId,
    required this.songUrl,
    this.key,
    required this.instrument,
    required this.name,
    this.capo,
    this.stdKey,
    this.tuning,
    required this.songId,
    required this.artist,
    String? artistImage,
    required this.versionId,
    required this.lastUpdate,
  }) : artistImage = (artistImage ?? "").isNotEmpty ? artistImage : null;

  Version toDomain() => Version(
        localDatabaseId: localDatabaseId,
        lastUpdate: lastUpdate,
        songId: songId,
        instrument: instrument,
        name: name,
        songUrl: songUrl,
        key: key,
        stdKey: stdKey,
        capo: Capo.getCapoById(capo),
        tuning: tuning,
        artist: artist.toDomain(artistImage),
        versionId: versionId,
        order: 0,
      );

  UserRecentVersionDto.fromDomain(Version version)
      : this(
          localDatabaseId: version.localDatabaseId ?? Isar.autoIncrement,
          name: version.name,
          songUrl: version.songUrl,
          instrument: version.instrument,
          key: version.key,
          songId: version.songId,
          capo: version.capo?.capoId,
          stdKey: version.stdKey,
          tuning: version.tuning,
          artist: UserVersionArtistDto.fromDomain(version.artist),
          artistImage: (version.artist.image?.size162 ?? "").isNotEmpty ? version.artist.image?.size162 : null,
          versionId: version.versionId,
          lastUpdate: version.lastUpdate ?? DateTime.now(),
        );

  @ignore
  @override
  List<Object?> get props => [
        localDatabaseId,
        name,
        songUrl,
        key,
        instrument,
        songId,
        stdKey,
        versionId,
        capo,
        tuning,
      ];
}
