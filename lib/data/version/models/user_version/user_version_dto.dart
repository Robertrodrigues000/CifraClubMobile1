import 'package:cifraclub/data/version/models/user_version/user_version_artist_dto.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'user_version_dto.g.dart';

@CopyWith()
@Collection(inheritance: false)
class UserVersionDto extends Equatable {
  final Id id;
  final String name;
  final int versionId;
  final String songUrl;
  final String? key;
  final int type;
  final int songId;
  final String? stdKey;
  final int? capo;
  final String? tuning;
  final UserVersionArtistDto artist;
  @Index()
  final String? artistImage;
  @Index(composite: [CompositeIndex('artistImage')])
  @Index()
  final int songbookId;
  final int order;

  UserVersionDto({
    required this.songUrl,
    this.key,
    required this.type,
    required this.name,
    required this.songbookId,
    this.capo,
    this.stdKey,
    this.tuning,
    required this.id,
    required this.songId,
    required this.artist,
    String? artistImage,
    required this.versionId,
    required this.order,
  }) : artistImage = (artistImage ?? "").isNotEmpty ? artistImage : null;

  Version toDomain() => Version(
        remoteDatabaseId: id,
        songId: songId,
        instrument: Instrument.getInstrumentByType(type) ?? Instrument.unknown,
        name: name,
        songUrl: songUrl,
        key: key,
        stdKey: stdKey,
        capo: capo,
        tuning: tuning,
        artist: artist.toDomain(artistImage),
        versionId: versionId,
        order: order,
      );

  UserVersionDto.fromDomain(Version version, int songbookId, [int? order])
      : this(
          id: version.remoteDatabaseId!,
          name: version.name,
          songUrl: version.songUrl,
          songbookId: songbookId,
          type: version.instrument.apiType,
          key: version.key,
          songId: version.songId,
          capo: version.capo,
          stdKey: version.stdKey,
          tuning: version.tuning,
          artist: UserVersionArtistDto.fromDomain(version.artist),
          artistImage: (version.artist.image?.size162 ?? "").isNotEmpty ? version.artist.image?.size162 : null,
          versionId: version.versionId,
          order: order ?? version.order,
        );

  @ignore
  @override
  List<Object?> get props => [
        id,
        name,
        songUrl,
        key,
        type,
        songId,
        stdKey,
        versionId,
        capo,
        tuning,
        songbookId,
      ];
}
