package com.studiosol.cifraclub.shazam.audioManager

interface AudioRecorderListener {
    fun onError(e: Exception?)
    fun onRecord(audioByteBuffer: ByteArray, audioRecord : Int)
}