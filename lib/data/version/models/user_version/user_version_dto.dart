import 'package:cifraclub/data/version/models/user_version/user_version_artist_dto.dart';
import 'package:cifraclub/domain/version/models/capo.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/domain/version/models/tuning.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'user_version_dto.g.dart';

@CopyWith()
@Collection(inheritance: false)
class UserVersionDto extends Equatable {
  final Id localDatabaseId;
  final int remoteDatabaseId;
  final String name;
  final int versionId;
  final String songUrl;
  final String? key;
  final int type;
  @Index(composite: [CompositeIndex('songbookId')])
  final int songId;
  final String? stdKey;
  final int? capo;
  final String? tuning;
  final UserVersionArtistDto artist;
  @Index()
  final String? artistImage;
  @Index(composite: [CompositeIndex('artistImage')])
  @Index(composite: [CompositeIndex('versionId')])
  @Index()
  final int songbookId;
  final int order;

  UserVersionDto({
    this.key,
    required this.localDatabaseId,
    required this.remoteDatabaseId,
    required this.songbookId,
    required this.songUrl,
    required this.type,
    required this.name,
    this.capo,
    this.stdKey,
    this.tuning,
    required this.songId,
    required this.artist,
    String? artistImage,
    required this.versionId,
    required this.order,
  }) : artistImage = (artistImage ?? "").isNotEmpty ? artistImage : null;

  Version toDomain() => Version(
        localDatabaseId: localDatabaseId,
        remoteDatabaseId: remoteDatabaseId,
        songId: songId,
        instrument: Instrument.getInstrumentByType(type) ?? Instrument.unknown,
        name: name,
        songUrl: songUrl,
        key: key,
        stdKey: stdKey,
        tuning: Tuning.getTuningByValue(tuning),
        capo: Capo.getCapoById(capo),
        artist: artist.toDomain(artistImage),
        versionId: versionId,
        order: order,
      );

  UserVersionDto.fromDomain(Version version, int songbookId, [int? order])
      : this(
          localDatabaseId: version.localDatabaseId ?? Isar.autoIncrement,
          remoteDatabaseId: version.remoteDatabaseId!,
          name: version.name,
          songUrl: version.songUrl,
          songbookId: songbookId,
          type: version.instrument.apiType,
          key: version.key,
          songId: version.songId,
          capo: version.capo?.capoId,
          stdKey: version.stdKey,
          tuning: version.tuning?.value,
          artist: UserVersionArtistDto.fromDomain(version.artist),
          artistImage: (version.artist.image?.size162 ?? "").isNotEmpty ? version.artist.image?.size162 : null,
          versionId: version.versionId,
          order: order ?? version.order,
        );

  @ignore
  @override
  List<Object?> get props => [
        localDatabaseId,
        remoteDatabaseId,
        versionId,
        songbookId,
        name,
        songUrl,
        key,
        type,
        songId,
        stdKey,
        capo,
        tuning,
      ];
}
