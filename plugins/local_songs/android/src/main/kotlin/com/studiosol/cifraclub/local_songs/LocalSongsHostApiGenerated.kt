// Autogenerated from Pigeon (v10.1.6), do not edit directly.
// See also: https://pub.dev/packages/pigeon


import android.util.Log
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MessageCodec
import io.flutter.plugin.common.StandardMessageCodec
import java.io.ByteArrayOutputStream
import java.nio.ByteBuffer

private fun wrapResult(result: Any?): List<Any?> {
  return listOf(result)
}

private fun wrapError(exception: Throwable): List<Any?> {
  if (exception is FlutterError) {
    return listOf(
      exception.code,
      exception.message,
      exception.details
    )
  } else {
    return listOf(
      exception.javaClass.simpleName,
      exception.toString(),
      "Cause: " + exception.cause + ", Stacktrace: " + Log.getStackTraceString(exception)
    )
  }
}

/**
 * Error class for passing custom error details to Flutter via a thrown PlatformException.
 * @property code The error code.
 * @property message The error message.
 * @property details The error details. Must be a datatype supported by the api codec.
 */
class FlutterError (
  val code: String,
  override val message: String? = null,
  val details: Any? = null
) : Throwable()

/** Generated class from Pigeon that represents data sent in messages. */
data class LocalSongDto (
  val songName: String,
  val artistName: String,
  val path: String? = null,
  val completePath: String? = null,
  val duration: Long,
  val albumId: String? = null

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): LocalSongDto {
      val songName = list[0] as String
      val artistName = list[1] as String
      val path = list[2] as String?
      val completePath = list[3] as String?
      val duration = list[4].let { if (it is Int) it.toLong() else it as Long }
      val albumId = list[5] as String?
      return LocalSongDto(songName, artistName, path, completePath, duration, albumId)
    }
  }
  fun toList(): List<Any?> {
    return listOf<Any?>(
      songName,
      artistName,
      path,
      completePath,
      duration,
      albumId,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class LocalSongsFetchResult (
  val songs: List<LocalSongDto?>? = null,
  val error: String? = null

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): LocalSongsFetchResult {
      val songs = list[0] as List<LocalSongDto?>?
      val error = list[1] as String?
      return LocalSongsFetchResult(songs, error)
    }
  }
  fun toList(): List<Any?> {
    return listOf<Any?>(
      songs,
      error,
    )
  }
}
@Suppress("UNCHECKED_CAST")
private object LocalSongsHostApiCodec : StandardMessageCodec() {
  override fun readValueOfType(type: Byte, buffer: ByteBuffer): Any? {
    return when (type) {
      128.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          LocalSongDto.fromList(it)
        }
      }
      129.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          LocalSongsFetchResult.fromList(it)
        }
      }
      else -> super.readValueOfType(type, buffer)
    }
  }
  override fun writeValue(stream: ByteArrayOutputStream, value: Any?)   {
    when (value) {
      is LocalSongDto -> {
        stream.write(128)
        writeValue(stream, value.toList())
      }
      is LocalSongsFetchResult -> {
        stream.write(129)
        writeValue(stream, value.toList())
      }
      else -> super.writeValue(stream, value)
    }
  }
}

/** Generated interface from Pigeon that represents a handler of messages from Flutter. */
interface LocalSongsHostApi {
  fun fetchLocalSongs(artistName: String, songName: String): LocalSongsFetchResult
  fun getImage(uri: String): ByteArray?

  companion object {
    /** The codec used by LocalSongsHostApi. */
    val codec: MessageCodec<Any?> by lazy {
      LocalSongsHostApiCodec
    }
    /** Sets up an instance of `LocalSongsHostApi` to handle messages through the `binaryMessenger`. */
    @Suppress("UNCHECKED_CAST")
    fun setUp(binaryMessenger: BinaryMessenger, api: LocalSongsHostApi?) {
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.local_songs.LocalSongsHostApi.fetchLocalSongs", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val artistNameArg = args[0] as String
            val songNameArg = args[1] as String
            var wrapped: List<Any?>
            try {
              wrapped = listOf<Any?>(api.fetchLocalSongs(artistNameArg, songNameArg))
            } catch (exception: Throwable) {
              wrapped = wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.local_songs.LocalSongsHostApi.getImage", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val uriArg = args[0] as String
            var wrapped: List<Any?>
            try {
              wrapped = listOf<Any?>(api.getImage(uriArg))
            } catch (exception: Throwable) {
              wrapped = wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
    }
  }
}
