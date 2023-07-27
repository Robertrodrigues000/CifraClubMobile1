// ignore_for_file: must_be_immutable
import 'package:cifraclub/data/version/models/user_version_artist_dto.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'user_recent_version_dto.g.dart';

@CopyWith()
@Collection(inheritance: false)
class UserRecentVersionDto extends Equatable {
  Id localDatabaseID = Isar.autoIncrement;
  final int? remoteDatabaseID;
  final String name;
  final int versionId;
  final String songUrl;
  final String? tone;
  final int type;
  final int songId;
  final String? stdTone;
  final int? capo;
  final String? tuning;
  final UserVersionArtistDto artist;
  @Index()
  final String? artistImage;

  UserRecentVersionDto({
    required this.localDatabaseID,
    this.remoteDatabaseID,
    required this.songUrl,
    this.tone,
    required this.type,
    required this.name,
    this.capo,
    this.stdTone,
    this.tuning,
    required this.songId,
    required this.artist,
    String? artistImage,
    required this.versionId,
  }) : artistImage = (artistImage ?? "").isNotEmpty ? artistImage : null;

  Version toDomain() => Version(
        localDatabaseID: localDatabaseID,
        remoteDatabaseID: (remoteDatabaseID ?? -1) > 0 ? remoteDatabaseID : null,
        songId: songId,
        type: type,
        name: name,
        songUrl: songUrl,
        tone: tone,
        stdTone: stdTone,
        capo: capo,
        tuning: tuning,
        artist: artist.toDomain(artistImage),
        versionId: versionId,
        order: 0,
      );

  UserRecentVersionDto.fromDomain(Version version)
      : this(
          localDatabaseID: version.localDatabaseID ?? Isar.autoIncrement,
          remoteDatabaseID: version.remoteDatabaseID,
          name: version.name,
          songUrl: version.songUrl,
          type: version.type,
          tone: version.tone,
          songId: version.songId,
          capo: version.capo,
          stdTone: version.stdTone,
          tuning: version.tuning,
          artist: UserVersionArtistDto.fromDomain(version.artist),
          artistImage: (version.artist.image?.size162 ?? "").isNotEmpty ? version.artist.image?.size162 : null,
          versionId: version.versionId,
        );

  @ignore
  @override
  List<Object?> get props => [
        localDatabaseID,
        name,
        remoteDatabaseID,
        songUrl,
        tone,
        type,
        songId,
        stdTone,
        versionId,
        capo,
        tuning,
      ];
}
