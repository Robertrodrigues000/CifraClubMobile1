package com.studiosol.cifraclub.shazam.audioManager

import ShazamResult
import ShazamSongDto
import com.shazam.shazamkit.AudioSampleRateInHz
import com.shazam.shazamkit.DeveloperToken
import com.shazam.shazamkit.MatchResult
import com.shazam.shazamkit.ShazamKit
import com.shazam.shazamkit.ShazamKitResult
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.callbackFlow
import kotlinx.coroutines.flow.collect

class ShazamAudioRecorder {
    private val audioRecorderManager by lazy { AudioRecorderManager() }

    @OptIn(ExperimentalCoroutinesApi::class)
    suspend fun startRecognition(token: String): Flow<Result<ShazamResult>> = callbackFlow {
        audioRecorderManager.initAudioRecord()

        val catalog =
            ShazamKit.createShazamCatalog({ DeveloperToken(token) })

        val streamingSession = ShazamKit.createStreamingSession(
            catalog,
            AudioSampleRateInHz.SAMPLE_RATE_44100,
            audioRecorderManager.bufferSizeInBytes
        )

        if (streamingSession is ShazamKitResult.Failure) {
            trySend(Result.failure(streamingSession.reason))
        }

        val currentSession = (streamingSession as ShazamKitResult.Success).data

        audioRecorderManager.setAudioRecorderListener(object : AudioRecorderListener {
            override fun onError(e: Exception?) {
                trySend(Result.failure(e ?: Exception("Unknown error")))
            }

            override fun onRecord(audioByteBuffer: ByteArray, audioRecord: Int) {
                currentSession.matchStream(
                    audioByteBuffer,
                    audioRecord,
                    System.currentTimeMillis()
                )
            }
        })

        audioRecorderManager.startRecord()

        currentSession.recognitionResults().collect { matchResult ->
            trySend(
                when (matchResult) {
                    is MatchResult.Match -> {
                        val mediaItem = matchResult.matchedMediaItems.first()

                        Result.success(
                            ShazamResult(
                                result = ShazamSongDto(
                                    artistName = mediaItem.artist ?: "",
                                    songName = mediaItem.title ?: "",
                                    image = mediaItem.artworkURL?.toString()
                                )
                            )
                        )

                    }

                    is MatchResult.NoMatch -> {
                        Result.failure(Exception("No match founded"))
                    }

                    is MatchResult.Error -> {
                        Result.failure(matchResult.exception)
                    }
                }
            )
        }
    }

    fun stopRecognition() {
        audioRecorderManager.stopRecord()
    }
}