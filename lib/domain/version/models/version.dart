import 'package:cifraclub/domain/artist/models/artist.dart';
import 'package:cifraclub/domain/version/models/capo.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/domain/version/models/version_data.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'version.g.dart';

@CopyWith()
class Version extends Equatable {
  final int? localDatabaseId;
  final int? remoteDatabaseId;
  final DateTime? lastUpdate;
  final int songId;
  final int versionId;
  final Instrument instrument;
  final String name;
  final String songUrl;
  final String? key;
  final String? stdKey;
  final Capo? capo;
  final String? tuning;
  final Artist artist;
  final int order;

  const Version({
    this.localDatabaseId,
    this.remoteDatabaseId,
    this.lastUpdate,
    required this.songId,
    required this.versionId,
    required this.instrument,
    required this.name,
    required this.songUrl,
    this.key,
    this.stdKey,
    this.capo,
    this.tuning,
    required this.artist,
    required this.order,
  });

  Version.fromVersionData(VersionData versionData, {DateTime? lastUpdate})
      : this(
          localDatabaseId: versionData.versionLocalDatabaseId,
          songId: versionData.song.songId,
          versionId: versionData.versionId,
          instrument: versionData.instrument,
          name: versionData.song.name,
          songUrl: versionData.completePath,
          artist: versionData.artist!,
          capo: versionData.capo,
          tuning: versionData.tuning,
          key: versionData.key,
          stdKey: versionData.stdKey,
          order: 0,
          lastUpdate: lastUpdate,
        );

  // coverage:ignore-start
  @override
  List<Object?> get props => [
        localDatabaseId,
        remoteDatabaseId,
        songId,
        versionId,
        instrument,
        name,
        songUrl,
        key,
        stdKey,
        capo,
        tuning,
        artist,
        order,
      ];
  // coverage:ignore-end
}
