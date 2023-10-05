package com.studiosol.cifraclub.shazam.audioManager

import android.media.AudioFormat
import android.media.AudioRecord
import android.media.MediaRecorder
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch

class AudioRecorderManager : AudioRecorder() {

    private var audioRecord: AudioRecord? = null
    var bufferSizeInBytes = 0
        private set
    private var keepRunning = true
    private var job: Job? = null
    private val coroutineScope = CoroutineScope(Dispatchers.IO)

    companion object {
        const val sampleRateInHz = 44100
        const val bufferSize = 2 * 4096
    }

    override fun initAudioRecord() {
        val minBufferSizeBytes = AudioRecord.getMinBufferSize(
            sampleRateInHz,
            AudioFormat.CHANNEL_IN_MONO,
            AudioFormat.ENCODING_PCM_16BIT
        )

        if (minBufferSizeBytes != AudioRecord.ERROR && minBufferSizeBytes != AudioRecord.ERROR_BAD_VALUE) {
            bufferSizeInBytes = bufferSize * 2

            audioRecord = AudioRecord(
                MediaRecorder.AudioSource.MIC,
                sampleRateInHz,
                AudioFormat.CHANNEL_IN_MONO,
                AudioFormat.ENCODING_PCM_16BIT,
                bufferSizeInBytes
            )
        }

        if (audioRecord == null || audioRecord!!.state != AudioRecord.STATE_INITIALIZED) {
            throw Exception("Java InitAudioRecord Fail - AudioRecord not initialized")
        }
    }

    override fun startRecord() {
        if (audioRecord != null)
            callRecord()
    }

    private fun callRecord() {
        keepRunning = true
        if (job == null) {

            job = coroutineScope.launch {

                if (bufferSizeInBytes == 0) {
                    reportError(Exception("Maybe forgot to initialize the AudioManager."))
                }

                val audioByteBuffer = ByteArray(bufferSizeInBytes)

                try {
                    if (audioRecord != null && audioRecord!!.state == AudioRecord.STATE_INITIALIZED) {
                        audioRecord!!.startRecording()

                        while (keepRunning) {
                            val audioRecord =
                                audioRecord!!.read(audioByteBuffer, 0, bufferSizeInBytes)

                            if (audioRecorderListener != null) {
                                audioRecorderListener.onRecord(audioByteBuffer, audioRecord)
                            } else {
                                reportError(Exception("Error to send listener"))
                            }

                        }
                    }
                } catch (e: java.lang.Exception) {
                    reportError(e)
                }
            }
        }
    }


    override fun stopRecord() {
        keepRunning = false
        audioRecord?.release()
        job?.cancel()
        job = null
    }

    private fun reportError(e: Exception) {
        e.printStackTrace()
        keepRunning = false
        if (audioRecorderListener != null) {
            audioRecorderListener.onError(e)
        }
    }
}