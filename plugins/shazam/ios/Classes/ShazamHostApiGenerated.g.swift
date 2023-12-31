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
struct ShazamSongDto {
  var songName: String
  var artistName: String
  var image: String? = nil

  static func fromList(_ list: [Any?]) -> ShazamSongDto? {
    let songName = list[0] as! String
    let artistName = list[1] as! String
    let image: String? = nilOrValue(list[2])

    return ShazamSongDto(
      songName: songName,
      artistName: artistName,
      image: image
    )
  }
  func toList() -> [Any?] {
    return [
      songName,
      artistName,
      image,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct ShazamResult {
  var result: ShazamSongDto? = nil
  var error: String? = nil

  static func fromList(_ list: [Any?]) -> ShazamResult? {
    var result: ShazamSongDto? = nil
    if let resultList: [Any?] = nilOrValue(list[0]) {
      result = ShazamSongDto.fromList(resultList)
    }
    let error: String? = nilOrValue(list[1])

    return ShazamResult(
      result: result,
      error: error
    )
  }
  func toList() -> [Any?] {
    return [
      result?.toList(),
      error,
    ]
  }
}

private class ShazamHostApiCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
      case 128:
        return ShazamResult.fromList(self.readValue() as! [Any?])
      case 129:
        return ShazamSongDto.fromList(self.readValue() as! [Any?])
      default:
        return super.readValue(ofType: type)
    }
  }
}

private class ShazamHostApiCodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? ShazamResult {
      super.writeByte(128)
      super.writeValue(value.toList())
    } else if let value = value as? ShazamSongDto {
      super.writeByte(129)
      super.writeValue(value.toList())
    } else {
      super.writeValue(value)
    }
  }
}

private class ShazamHostApiCodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return ShazamHostApiCodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return ShazamHostApiCodecWriter(data: data)
  }
}

class ShazamHostApiCodec: FlutterStandardMessageCodec {
  static let shared = ShazamHostApiCodec(readerWriter: ShazamHostApiCodecReaderWriter())
}

/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol ShazamHostApi {
  func search(token: String, completion: @escaping (Result<ShazamResult, Error>) -> Void)
  func cancelSearch() throws
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class ShazamHostApiSetup {
  /// The codec used by ShazamHostApi.
  static var codec: FlutterStandardMessageCodec { ShazamHostApiCodec.shared }
  /// Sets up an instance of `ShazamHostApi` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: ShazamHostApi?) {
    let searchChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.shazam.ShazamHostApi.search", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      searchChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let tokenArg = args[0] as! String
        api.search(token: tokenArg) { result in
          switch result {
            case .success(let res):
              reply(wrapResult(res))
            case .failure(let error):
              reply(wrapError(error))
          }
        }
      }
    } else {
      searchChannel.setMessageHandler(nil)
    }
    let cancelSearchChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.shazam.ShazamHostApi.cancelSearch", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      cancelSearchChannel.setMessageHandler { _, reply in
        do {
          try api.cancelSearch()
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      cancelSearchChannel.setMessageHandler(nil)
    }
  }
}
