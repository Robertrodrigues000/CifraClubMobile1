package com.studiosol.cifraclub.local_songs

import LocalSongsFetchResult
import LocalSongsHostApi
import android.content.Context
import android.media.MediaMetadataRetriever
import android.net.Uri

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodChannel

/** LocalSongsPlugin */
class LocalSongsPlugin : FlutterPlugin, LocalSongsHostApi {
    private lateinit var channel: MethodChannel
    private var applicationContext: Context? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        applicationContext = flutterPluginBinding.applicationContext
        LocalSongsHostApi.setUp(flutterPluginBinding.binaryMessenger, this)
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "local_songs")
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        applicationContext = null
        channel.setMethodCallHandler(null)
    }

    override fun fetchLocalSongs(
        artistName: String,
        songName: String,
    ): LocalSongsFetchResult {
        val context = applicationContext
        if (context != null) {
            return try {
                val songs = LoadLocalSongs().fetchMedias(context, artistName, songName)
                LocalSongsFetchResult(songs = songs)
            } catch (exception: Exception) {
                LocalSongsFetchResult(error = exception.toString())
            }
        }
        return LocalSongsFetchResult(error = "applicationContext is NULL")
    }

    override fun getImage(uri: String): ByteArray? {
        val mediaMetadataRetriever = MediaMetadataRetriever().apply {
            setDataSource(applicationContext, Uri.parse(uri))
        }
        return mediaMetadataRetriever.embeddedPicture
    }
}
