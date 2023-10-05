//
//  ShazamAudioRecorder.swift
//  shazam
//
//  Created by Arthur otero on 26/09/23.
//

import Foundation
import AVFAudio
import AVKit
import ShazamKit
import Combine


@available(iOS 15.0, *)
class ShazamAudioRecorder: NSObject, ObservableObject{
    @Published var item: SHMediaItem? = nil
    @Published var error: String? = nil
    @Published var listening = false
    
    private let session = SHSession()
    private let audioEngine = AVAudioEngine()
    
    override init() {
        super.init()
        session.delegate = self
    }
    
    private func initAudioRecord() throws {
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
    }
    
    private func audioBuffer() {
        let format = audioEngine.inputNode.outputFormat(forBus: 0)
        
        audioEngine.inputNode.installTap(onBus: .zero, bufferSize: 4096 * 2, format: format) { [weak session] buffer, audioTime in
            session?.matchStreamingBuffer(buffer, at: audioTime)
        }
    }
    
    private func startAudioRecord() throws {
        try audioEngine.start()
        listening = true
        error = nil
    }
    
    public func startRecognition() {
        do {
            if audioEngine.isRunning {
                stopRecognition()
                return
            }
            
            try initAudioRecord()
            audioBuffer()
            try startAudioRecord()
        } catch {
            self.error = error.localizedDescription
            stopRecognition()
        }
    }
    
    public func stopRecognition() {
        listening = false
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: .zero)
    }
}

@available(iOS 15.0, *)
extension ShazamAudioRecorder: SHSessionDelegate {
    @available(iOS 15.0, *)
    
    public func session(_ session: SHSession, didFind match: SHMatch) {
        guard let mediaItem = match.mediaItems.first else {
            self.error = "No match founded"
            self.stopRecognition()
            return
        }
        
        self.item = mediaItem
        self.stopRecognition()
    }
    
    public func session(_ session: SHSession, didNotFindMatchFor signature: SHSignature, error: Error?) {
        self.error = error.debugDescription
        self.stopRecognition()
    }
    
}
