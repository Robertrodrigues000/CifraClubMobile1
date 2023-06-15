// ignore_for_file: must_be_immutable
import 'package:cifraclub/data/cifra/models/user_cifra_artist_dto.dart';
import 'package:cifraclub/domain/cifra/models/cifra.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'user_cifra_dto.g.dart';

@CopyWith()
@Collection(inheritance: false)
class UserCifraDto extends Equatable {
  Id localDatabaseID = Isar.autoIncrement;
  final String name;
  final int? remoteDatabaseID;
  final int versionId;
  final String songUrl;
  final String? tone;
  final int type;
  final int songId;
  final String? stdTone;
  final int? capo;
  final String? tuning;
  final UserCifraArtistDto artist;
  @Index()
  final String? artistImage;
  @Index(composite: [CompositeIndex('artistImage')])
  @Index()
  final int songbookId;

  UserCifraDto({
    this.remoteDatabaseID,
    required this.songUrl,
    this.tone,
    required this.type,
    required this.name,
    required this.songbookId,
    this.capo,
    this.stdTone,
    this.tuning,
    required this.localDatabaseID,
    required this.songId,
    required this.artist,
    String? artistImage,
    required this.versionId,
  }) : artistImage = (artistImage ?? "").isNotEmpty ? artistImage : null;

  Cifra toDomain() => Cifra(
        localDatabaseID: localDatabaseID,
        songId: songId,
        type: type,
        name: name,
        songUrl: songUrl,
        tone: tone,
        stdTone: stdTone,
        capo: capo,
        tuning: tuning,
        artist: artist.toDomain(artistImage),
        remoteDatabaseID: remoteDatabaseID,
        versionId: versionId,
      );

  UserCifraDto.fromDomain(Cifra cifra, int songbookId)
      : this(
          localDatabaseID: cifra.localDatabaseID ?? Isar.autoIncrement,
          remoteDatabaseID: cifra.remoteDatabaseID,
          name: cifra.name,
          songUrl: cifra.songUrl,
          songbookId: songbookId,
          type: cifra.type,
          tone: cifra.tone,
          songId: cifra.songId,
          capo: cifra.capo,
          stdTone: cifra.stdTone,
          tuning: cifra.tuning,
          artist: UserCifraArtistDto.fromDomain(cifra.artist),
          artistImage: (cifra.artist.image?.size162 ?? "").isNotEmpty ? cifra.artist.image?.size162 : null,
          versionId: cifra.versionId,
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
        songbookId,
      ];
}
