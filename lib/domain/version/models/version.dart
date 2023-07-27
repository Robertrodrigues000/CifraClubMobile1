import 'package:cifraclub/domain/artist/models/artist.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'version.g.dart';

@CopyWith()
class Version extends Equatable {
  final int? localDatabaseID;
  final int? remoteDatabaseID;
  final int songId;
  final int versionId;
  final int type;
  final String name;
  final String songUrl;
  final String? tone;
  final String? stdTone;
  final int? capo;
  final String? tuning;
  final Artist artist;
  final int order;

  const Version({
    this.localDatabaseID,
    this.remoteDatabaseID,
    required this.songId,
    required this.versionId,
    required this.type,
    required this.name,
    required this.songUrl,
    this.tone,
    this.stdTone,
    this.capo,
    this.tuning,
    required this.artist,
    required this.order,
  });

  // coverage:ignore-start
  @override
  List<Object?> get props => [
        localDatabaseID,
        remoteDatabaseID,
        songId,
        versionId,
        type,
        name,
        songUrl,
        tone,
        stdTone,
        capo,
        tuning,
        artist,
        order,
      ];
  // coverage:ignore-end
}
