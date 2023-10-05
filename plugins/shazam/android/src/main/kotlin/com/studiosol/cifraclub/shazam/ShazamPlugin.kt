package com.studiosol.cifraclub.shazam

import ShazamHostApi
import ShazamResult
import android.content.Context
import com.studiosol.cifraclub.shazam.audioManager.ShazamAudioRecorder
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.*
import kotlinx.coroutines.flow.collect


/** ShazamPlugin */
class ShazamPlugin : FlutterPlugin, ShazamHostApi {
    private lateinit var channel: MethodChannel
    private var applicationContext: Context? = null
    private var job: Job? = null
    private val coroutineScope = CoroutineScope(Dispatchers.IO)
    private val shazamAudioRecorder by lazy { ShazamAudioRecorder() }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        applicationContext = flutterPluginBinding.applicationContext
        ShazamHostApi.setUp(flutterPluginBinding.binaryMessenger, this)
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "shazam")
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        applicationContext = null
        channel.setMethodCallHandler(null)
    }

    override fun search(token: String, callback: (Result<ShazamResult>) -> Unit) {
        job = coroutineScope.launch {
            shazamAudioRecorder.startRecognition(token).collect {
                callback(it)
                release()
            }
        }
    }

    override fun cancelSearch() {
        release()
    }

    private fun release() {
        shazamAudioRecorder.stopRecognition()
        job?.cancel()
        job = null
    }
}
