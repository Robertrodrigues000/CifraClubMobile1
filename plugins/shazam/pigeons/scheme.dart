import 'package:pigeon/pigeon.dart';

// #docregion config
@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/pigeon.g.dart',
  dartOptions: DartOptions(),
  kotlinOut: 'android/src/main/kotlin/com/studiosol/cifraclub/shazam/ShazamHostApiGenerated.g.kt',
  kotlinOptions: KotlinOptions(errorClassName: "ShazamFlutterError"),
  swiftOut: 'ios/Classes/ShazamHostApiGenerated.g.swift',
  swiftOptions: SwiftOptions(),
  // Set this to a unique prefix for your plugin or application, per Objective-C naming conventions.
  objcOptions: ObjcOptions(prefix: 'PGN'),
  dartPackageName: 'shazam',
))
// #enddocregion config


class ShazamSongDto{
  final String songName;
  final String artistName;
  final String? image;

  const ShazamSongDto({required this.songName, required this.artistName, this.image});
}

class ShazamResult{
  final ShazamSongDto? result;
  final String? error;

  const ShazamResult(this.result, this.error);
}

@HostApi()
abstract class ShazamHostApi {
  @async
  ShazamResult search(String token);
  void cancelSearch();
}