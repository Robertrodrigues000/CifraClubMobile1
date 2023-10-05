import Flutter
import UIKit
import Combine

@available(iOS 15.0, *)
public class ShazamPlugin: NSObject, FlutterPlugin, ShazamHostApi {
    let audioRecord =  ShazamAudioRecorder()
    var cancellable: AnyCancellable?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let _ = FlutterMethodChannel(name: "shazam", binaryMessenger: registrar.messenger())
        let instance = ShazamPlugin()
        ShazamHostApiSetup.setUp(binaryMessenger: registrar.messenger(), api: instance)
    }
    
    func search(token: String, completion: @escaping (Result<ShazamResult, Error>) -> Void) {
        if cancellable == nil{
            audioRecord.startRecognition()
            cancellable = audioRecord.$listening
                .sink { listening in
                    if !listening{
                        guard let result = self.audioRecord.item else{
                            completion(.success(ShazamResult(error: self.audioRecord.error)))
                            self.release()
                            return
                        }
                        
                        let songName = result.title
                        let artistName = result.artist
                        let image = result.artworkURL?.absoluteString
                        
                        completion(.success(ShazamResult(result: ShazamSongDto(songName: songName ?? "", artistName: artistName ?? "", image: image))))
                        self.release()
                    }
                }
            
        }
        
    }
    
    func cancelSearch() throws {
        audioRecord.stopRecognition()
        release()
    }
    
    private func release() {
        cancellable?.cancel()
        cancellable = nil
    }
}
