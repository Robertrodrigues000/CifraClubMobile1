import 'package:cifraclub/data/song/song_player_manager.dart';

abstract class SongPlayer {
  Stream<Duration> get positionStream;
  Stream<SongPlayerState> get stateStream;
  Future<void> initPlayer();
  Future<void> setAudio(String audioPath);
  Future<void> pauseAudio();
  Future<void> resumeAudio();
  Future<Duration?>? getAudioDuration();
  Future<void> changeAudioTime(Duration duration);
  void cancel();
  void dispose();
}
