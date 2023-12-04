// Autogenerated from Pigeon (v10.1.6), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import

import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;

import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';

class LocalSongDto {
  LocalSongDto({
    required this.songName,
    required this.artistName,
    this.path,
    this.completePath,
    required this.duration,
    this.albumId,
  });

  String songName;

  String artistName;

  String? path;

  String? completePath;

  int duration;

  String? albumId;

  Object encode() {
    return <Object?>[
      songName,
      artistName,
      path,
      completePath,
      duration,
      albumId,
    ];
  }

  static LocalSongDto decode(Object result) {
    result as List<Object?>;
    return LocalSongDto(
      songName: result[0]! as String,
      artistName: result[1]! as String,
      path: result[2] as String?,
      completePath: result[3] as String?,
      duration: result[4]! as int,
      albumId: result[5] as String?,
    );
  }
}

class LocalSongsFetchResult {
  LocalSongsFetchResult({
    this.songs,
    this.error,
  });

  List<LocalSongDto?>? songs;

  String? error;

  Object encode() {
    return <Object?>[
      songs,
      error,
    ];
  }

  static LocalSongsFetchResult decode(Object result) {
    result as List<Object?>;
    return LocalSongsFetchResult(
      songs: (result[0] as List<Object?>?)?.cast<LocalSongDto?>(),
      error: result[1] as String?,
    );
  }
}

class _LocalSongsHostApiCodec extends StandardMessageCodec {
  const _LocalSongsHostApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is LocalSongDto) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is LocalSongsFetchResult) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128: 
        return LocalSongDto.decode(readValue(buffer)!);
      case 129: 
        return LocalSongsFetchResult.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

class LocalSongsHostApi {
  /// Constructor for [LocalSongsHostApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  LocalSongsHostApi({BinaryMessenger? binaryMessenger})
      : _binaryMessenger = binaryMessenger;
  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _LocalSongsHostApiCodec();

  Future<LocalSongsFetchResult> fetchLocalSongs(String arg_artistName, String arg_songName) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.local_songs.LocalSongsHostApi.fetchLocalSongs', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_artistName, arg_songName]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as LocalSongsFetchResult?)!;
    }
  }

  Future<Uint8List?> getImage(String arg_uri) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.local_songs.LocalSongsHostApi.getImage', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_uri]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return (replyList[0] as Uint8List?);
    }
  }
}
