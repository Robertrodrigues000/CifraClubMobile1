// ignore_for_file: must_be_immutable
import 'package:cifraclub/data/version/models/user_version/user_version_artist_dto.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'user_recent_version_dto.g.dart';

@CopyWith()
@Collection(inheritance: false)
class UserRecentVersionDto extends Equatable {
  Id localDatabaseId = Isar.autoIncrement;
  final int? remoteDatabaseId;
  final String name;
  final int versionId;
  final String songUrl;
  final String? key;
  @enumerated
  final Instrument instrument;
  final int songId;
  final String? stdKey;
  final int? capo;
  final String? tuning;
  final UserVersionArtistDto artist;
  @Index()
  final String? artistImage;

  UserRecentVersionDto({
    required this.localDatabaseId,
    this.remoteDatabaseId,
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
  }) : artistImage = (artistImage ?? "").isNotEmpty ? artistImage : null;

  Version toDomain() => Version(
        localDatabaseId: localDatabaseId,
        remoteDatabaseId: (remoteDatabaseId ?? -1) > 0 ? remoteDatabaseId : null,
        songId: songId,
        instrument: instrument,
        name: name,
        songUrl: songUrl,
        key: key,
        stdKey: stdKey,
        capo: capo,
        tuning: tuning,
        artist: artist.toDomain(artistImage),
        versionId: versionId,
        order: 0,
      );

  UserRecentVersionDto.fromDomain(Version version)
      : this(
          localDatabaseId: version.localDatabaseId ?? Isar.autoIncrement,
          remoteDatabaseId: version.remoteDatabaseId,
          name: version.name,
          songUrl: version.songUrl,
          instrument: version.instrument,
          key: version.key,
          songId: version.songId,
          capo: version.capo,
          stdKey: version.stdKey,
          tuning: version.tuning,
          artist: UserVersionArtistDto.fromDomain(version.artist),
          artistImage: (version.artist.image?.size162 ?? "").isNotEmpty ? version.artist.image?.size162 : null,
          versionId: version.versionId,
        );

  @ignore
  @override
  List<Object?> get props => [
        localDatabaseId,
        name,
        remoteDatabaseId,
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
