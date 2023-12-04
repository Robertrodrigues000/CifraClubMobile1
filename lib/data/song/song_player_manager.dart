import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:cifraclub/domain/device/operating_system/models/operating_system.dart';
import 'package:cifraclub/domain/device/operating_system/use_cases/get_operating_system.dart';
import 'package:cifraclub/domain/song/song_player.dart';
import 'package:rxdart/rxdart.dart';

class SongPlayerManager extends SongPlayer {
  final AudioPlayer _audioPlayer;
  final GetOperatingSystem _getOperatingSystem;

  final _stateController = BehaviorSubject<SongPlayerState>();
  @override
  Stream<SongPlayerState> get stateStream => _stateController.stream;
  final _positionController = BehaviorSubject<Duration>();
  @override
  Stream<Duration> get positionStream => _positionController.stream;

  SongPlayerManager(this._audioPlayer, this._getOperatingSystem);

  final _compositeSubscription = CompositeSubscription();

  @override
  Future<void> initPlayer() async {
    await _compositeSubscription.clear();
    _audioPlayer.eventStream.distinct(_distinctHourAndSeconds).listen((event) {
      if (event.position != null) {
        _positionController.add(event.position!);
      }
    }).addTo(_compositeSubscription);
  }

  bool _distinctHourAndSeconds(AudioEvent previous, AudioEvent actual) {
    if (previous.position != null && actual.position != null) {
      return previous.position!.inSeconds == actual.position!.inSeconds &&
          previous.position!.inMinutes == actual.position!.inMinutes;
    }
    return false;
  }

  @override
  Future<void> setAudio(String audioPath) async {
    final state = _audioPlayer.state.toSongPlayerState();
    if (state == SongPlayerState.playing || state == SongPlayerState.paused) {
      await _audioPlayer.stop();
    }

    final source = _getOperatingSystem() == OperatingSystem.ios ? UrlSource(audioPath) : DeviceFileSource(audioPath);
    await _audioPlayer.play(source);
    _stateController.add(_audioPlayer.state.toSongPlayerState());
  }

  @override
  Future<void> pauseAudio() async {
    await _audioPlayer.pause();
    _stateController.add(_audioPlayer.state.toSongPlayerState());
  }

  @override
  Future<void> resumeAudio() async {
    await _audioPlayer.resume();
    _stateController.add(_audioPlayer.state.toSongPlayerState());
  }

  @override
  Future<Duration?>? getAudioDuration() {
    return _audioPlayer.getDuration();
  }

  @override
  Future<void> changeAudioTime(Duration duration) async {
    await _audioPlayer.seek(duration);
  }

  @override
  void cancel() async {
    _audioPlayer.stop();
    _compositeSubscription.clear();
  }

  @override
  Future<void> dispose() async {
    await _compositeSubscription.dispose();
    await _audioPlayer.dispose();
  }
}

enum SongPlayerState {
  canceled,
  playing,
  paused,
  disposed,
}

extension _PlayerStateConversion on PlayerState {
  SongPlayerState toSongPlayerState() {
    return switch (this) {
      PlayerState.playing => SongPlayerState.playing,
      PlayerState.paused => SongPlayerState.paused,
      PlayerState.disposed => SongPlayerState.disposed,
      _ => SongPlayerState.canceled,
    };
  }
}
