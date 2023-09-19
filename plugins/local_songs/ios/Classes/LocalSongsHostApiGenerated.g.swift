// Autogenerated from Pigeon (v10.1.6), do not edit directly.
// See also: https://pub.dev/packages/pigeon

import Foundation
#if os(iOS)
import Flutter
#elseif os(macOS)
import FlutterMacOS
#else
#error("Unsupported platform.")
#endif

private func wrapResult(_ result: Any?) -> [Any?] {
  return [result]
}

private func wrapError(_ error: Any) -> [Any?] {
  if let flutterError = error as? FlutterError {
    return [
      flutterError.code,
      flutterError.message,
      flutterError.details
    ]
  }
  return [
    "\(error)",
    "\(type(of: error))",
    "Stacktrace: \(Thread.callStackSymbols)"
  ]
}

private func nilOrValue<T>(_ value: Any?) -> T? {
  if value is NSNull { return nil }
  return value as! T?
}

/// Generated class from Pigeon that represents data sent in messages.
struct LocalSongDto {
  var songName: String
  var artistName: String
  var path: String? = nil
  var duration: Int64
  var albumId: String? = nil

  static func fromList(_ list: [Any?]) -> LocalSongDto? {
    let songName = list[0] as! String
    let artistName = list[1] as! String
    let path: String? = nilOrValue(list[2])
    let duration = list[3] is Int64 ? list[3] as! Int64 : Int64(list[3] as! Int32)
    let albumId: String? = nilOrValue(list[4])

    return LocalSongDto(
      songName: songName,
      artistName: artistName,
      path: path,
      duration: duration,
      albumId: albumId
    )
  }
  func toList() -> [Any?] {
    return [
      songName,
      artistName,
      path,
      duration,
      albumId,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct LocalSongsFetchResult {
  var songs: [LocalSongDto?]? = nil
  var error: String? = nil

  static func fromList(_ list: [Any?]) -> LocalSongsFetchResult? {
    let songs: [LocalSongDto?]? = nilOrValue(list[0])
    let error: String? = nilOrValue(list[1])

    return LocalSongsFetchResult(
      songs: songs,
      error: error
    )
  }
  func toList() -> [Any?] {
    return [
      songs,
      error,
    ]
  }
}
private class LocalSongsHostApiCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
      case 128:
        return LocalSongDto.fromList(self.readValue() as! [Any?])
      case 129:
        return LocalSongsFetchResult.fromList(self.readValue() as! [Any?])
      default:
        return super.readValue(ofType: type)
    }
  }
}

private class LocalSongsHostApiCodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? LocalSongDto {
      super.writeByte(128)
      super.writeValue(value.toList())
    } else if let value = value as? LocalSongsFetchResult {
      super.writeByte(129)
      super.writeValue(value.toList())
    } else {
      super.writeValue(value)
    }
  }
}

private class LocalSongsHostApiCodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return LocalSongsHostApiCodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return LocalSongsHostApiCodecWriter(data: data)
  }
}

class LocalSongsHostApiCodec: FlutterStandardMessageCodec {
  static let shared = LocalSongsHostApiCodec(readerWriter: LocalSongsHostApiCodecReaderWriter())
}

/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol LocalSongsHostApi {
  func fetchLocalSongs(artistName: String, songName: String) throws -> LocalSongsFetchResult
  func getImage(uri: String) throws -> FlutterStandardTypedData?
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class LocalSongsHostApiSetup {
  /// The codec used by LocalSongsHostApi.
  static var codec: FlutterStandardMessageCodec { LocalSongsHostApiCodec.shared }
  /// Sets up an instance of `LocalSongsHostApi` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: LocalSongsHostApi?) {
    let fetchLocalSongsChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.local_songs.LocalSongsHostApi.fetchLocalSongs", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      fetchLocalSongsChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let artistNameArg = args[0] as! String
        let songNameArg = args[1] as! String
        do {
          let result = try api.fetchLocalSongs(artistName: artistNameArg, songName: songNameArg)
          reply(wrapResult(result))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      fetchLocalSongsChannel.setMessageHandler(nil)
    }
    let getImageChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.local_songs.LocalSongsHostApi.getImage", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      getImageChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let uriArg = args[0] as! String
        do {
          let result = try api.getImage(uri: uriArg)
          reply(wrapResult(result))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      getImageChannel.setMessageHandler(nil)
    }
  }
}
