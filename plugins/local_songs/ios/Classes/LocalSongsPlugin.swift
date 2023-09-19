import Flutter
import Photos
import MediaPlayer
import UIKit
import AssetsLibrary

public class LocalSongsPlugin: NSObject, FlutterPlugin, LocalSongsHostApi {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let _ = FlutterMethodChannel(name: "local_songs", binaryMessenger: registrar.messenger())
        let instance = LocalSongsPlugin()
        LocalSongsHostApiSetup.setUp(binaryMessenger: registrar.messenger(), api: instance)
    }
    
    func fetchLocalSongs(artistName: String, songName: String) throws -> LocalSongsFetchResult {
        let songs = getFilteredMediaSongs(artistName: artistName, songName: songName)
        
        let results = songs?.map({ result -> LocalSongDto in
            let url = String(result.persistentID)
            return LocalSongDto(songName: result.title ?? "", artistName: result.artist ?? "", path: url, duration: Int64(truncating: NSNumber(floatLiteral: result.playbackDuration)), albumId: result.albumPersistentID.description)
        })
        return LocalSongsFetchResult(songs: results)
    }
    
    private func getFilteredMediaSongs(artistName: String, songName: String) -> [MPMediaItem]? {
        let songs = MPMediaQuery.songs()
        let artistPredicate = MPMediaPropertyPredicate(value: artistName, forProperty: MPMediaItemPropertyArtist, comparisonType: .contains)
        let songPredicate = MPMediaPropertyPredicate(value: songName, forProperty: MPMediaItemPropertyTitle, comparisonType: .contains)
        
        songs.addFilterPredicate(artistPredicate)
        songs.addFilterPredicate(songPredicate)
        return songs.items
    }
    
    private func getSongByPersistentID(uri : String)-> MPMediaItem?{
        let songs = MPMediaQuery.songs()
        
        songs.addFilterPredicate(MPMediaPropertyPredicate(value: uri,
                                                          forProperty: MPMediaItemPropertyPersistentID,
                                                          comparisonType: MPMediaPredicateComparison.equalTo))
        
        return songs.items?.first
    }
    
    func getImage(uri: String) throws -> FlutterStandardTypedData? {
        let song = getSongByPersistentID(uri: uri)
        
        let image = song?.artwork?.image(at: CGSize(width: 50, height: 50))
        let data = image?.pngData()
        let flutterData =  data != nil ?FlutterStandardTypedData(bytes: data!) : nil
        
        return flutterData
    }
}
