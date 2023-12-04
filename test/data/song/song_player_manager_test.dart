import 'package:audioplayers/audioplayers.dart';
import 'package:cifraclub/data/song/song_player_manager.dart';
import 'package:cifraclub/domain/device/operating_system/models/operating_system.dart';
import 'package:cifraclub/domain/device/operating_system/use_cases/get_operating_system.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';

class _AudioPlayerMock extends Mock implements AudioPlayer {
  static const firstDuration = Duration(milliseconds: 100);
  static const secondDuration = Duration(milliseconds: 500);
  static const thirdDuration = Duration(seconds: 1);
  PlayerState playerState = PlayerState.stopped;
  final stream = BehaviorSubject.seeded(const AudioEvent(eventType: AudioEventType.duration, position: firstDuration));

  @override
  PlayerState get state => playerState;

  @override
  Stream<AudioEvent> get eventStream => stream;
}

class _GetOperatingSystemMock extends Mock implements GetOperatingSystem {}

void main() {
  setUpAll(() {
    registerFallbackValue(Duration.zero);
    registerFallbackValue(DeviceFileSource(""));
  });

  test("When changeAudioTime should change to Duration declared", () async {
    const duration = Duration(days: 4);
    final audioPlayer = _AudioPlayerMock();
    when(() => audioPlayer.seek(any())).thenAnswer((_) => SynchronousFuture(null));

    final songPlayerManager = SongPlayerManager(audioPlayer, _GetOperatingSystemMock());

    await songPlayerManager.changeAudioTime(duration);
    verify(() => audioPlayer.seek(duration)).called(1);
  });

  test("When getAudioDuration should return total of audio duration", () async {
    const duration = Duration(days: 4);
    final audioPlayer = _AudioPlayerMock();
    when(audioPlayer.getDuration).thenAnswer((_) => SynchronousFuture(duration));

    final songPlayerManager = SongPlayerManager(audioPlayer, _GetOperatingSystemMock());
    final result = await songPlayerManager.getAudioDuration();

    expect(result, duration);
    verify(audioPlayer.getDuration).called(1);
  });

  test("When resumeAudio should change resume audio", () async {
    final audioPlayer = _AudioPlayerMock();
    when(audioPlayer.resume).thenAnswer((_) => SynchronousFuture(null));
    audioPlayer.playerState = PlayerState.playing;

    final songPlayerManager = SongPlayerManager(audioPlayer, _GetOperatingSystemMock());

    expectLater(songPlayerManager.stateStream, emitsInOrder([SongPlayerState.playing]));

    await songPlayerManager.resumeAudio();
    verify(audioPlayer.resume).called(1);
  });

  test("When pauseAudio should change to pause audio", () async {
    final audioPlayer = _AudioPlayerMock();
    when(audioPlayer.pause).thenAnswer((_) => SynchronousFuture(null));
    audioPlayer.playerState = PlayerState.paused;

    final songPlayerManager = SongPlayerManager(audioPlayer, _GetOperatingSystemMock());

    expectLater(songPlayerManager.stateStream, emitsInOrder([SongPlayerState.paused]));

    await songPlayerManager.pauseAudio();
    verify(audioPlayer.pause).called(1);
  });

  test("When setAudio should change audio", () async {
    final audioPlayer = _AudioPlayerMock();
    final getOperatingSystem = _GetOperatingSystemMock();
    when(audioPlayer.stop).thenAnswer((_) => SynchronousFuture(null));
    when(() => audioPlayer.play(any())).thenAnswer((_) => SynchronousFuture(null));
    when(getOperatingSystem).thenReturn(OperatingSystem.android);
    audioPlayer.playerState = PlayerState.playing;

    final songPlayerManager = SongPlayerManager(audioPlayer, getOperatingSystem);

    await songPlayerManager.setAudio("123456");
    verify(audioPlayer.stop).called(1);
    verify(() => audioPlayer.play(any())).called(1);
  });

  test("When initPlayer should init audio", () async {
    final audioPlayer = _AudioPlayerMock();
    audioPlayer.playerState = PlayerState.stopped;

    final songPlayerManager = SongPlayerManager(audioPlayer, _GetOperatingSystemMock());

    expectLater(songPlayerManager.positionStream,
        emitsInOrder([_AudioPlayerMock.firstDuration, _AudioPlayerMock.thirdDuration]));

    await songPlayerManager.initPlayer();
    audioPlayer.stream
        .add(const AudioEvent(eventType: AudioEventType.duration, position: _AudioPlayerMock.secondDuration));
    audioPlayer.stream
        .add(const AudioEvent(eventType: AudioEventType.duration, position: _AudioPlayerMock.thirdDuration));
  });

  test("When cancel should call cancel", () {
    final audioPlayer = _AudioPlayerMock();
    when(audioPlayer.stop).thenAnswer((_) => SynchronousFuture(null));

    final songPlayerManager = SongPlayerManager(audioPlayer, _GetOperatingSystemMock());
    songPlayerManager.cancel();
    verify(audioPlayer.stop).called(1);
  });

  test("When dispose should dispose", () async {
    final audioPlayer = _AudioPlayerMock();
    when(audioPlayer.dispose).thenAnswer((_) => SynchronousFuture(null));

    final songPlayerManager = SongPlayerManager(audioPlayer, _GetOperatingSystemMock());
    await songPlayerManager.dispose();
    verify(audioPlayer.dispose).called(1);
  });
}
