import 'package:pigeon/pigeon.dart';

// #docregion config
@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/pigeon.g.dart',
  dartOptions: DartOptions(),
  kotlinOut: 'android/src/main/kotlin/com/studiosol/cifraclub/local_songs/LocalSongsHostApiGenerated.kt',
  kotlinOptions: KotlinOptions(),
  swiftOut: 'ios/Classes/LocalSongsHostApiGenerated.g.swift',
  swiftOptions: SwiftOptions(),
  // Set this to a unique prefix for your plugin or application, per Objective-C naming conventions.
  objcOptions: ObjcOptions(prefix: 'PGN'),
  dartPackageName: 'local_songs',
))
// #enddocregion config

class LocalSongDto {
  final String songName;
  final String artistName;

  final String? path;

  final int duration;
  final String? albumId;

  const LocalSongDto({
    required this.songName,
    required this.artistName,
    required this.path,
    required this.duration,
    required this.albumId,
  });
}

class LocalSongsFetchResult {
  final List<LocalSongDto?>? songs;
  final String? error;

  const LocalSongsFetchResult(this.songs, this.error);
}

@HostApi()
abstract class LocalSongsHostApi {
  LocalSongsFetchResult fetchLocalSongs(String artistName, String songName);

  Uint8List? getImage(String uri);
}