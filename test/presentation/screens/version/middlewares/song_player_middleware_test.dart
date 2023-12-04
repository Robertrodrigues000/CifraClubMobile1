import 'package:cifraclub/data/song/song_player_manager.dart';
import 'package:cifraclub/presentation/screens/version/middlewares/song_player_middleware.dart';
import 'package:cifraclub/presentation/screens/version/models/player_action.dart';
import 'package:cifraclub/presentation/screens/version/version_action.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';

class _SongPlayerManagerMock extends Mock implements SongPlayerManager {
  static const duration = Duration.zero;

  @override
  Stream<SongPlayerState> get stateStream => BehaviorSubject.seeded(SongPlayerState.playing);

  @override
  Stream<Duration> get positionStream => BehaviorSubject.seeded(duration);
}

void main() {
  setUpAll(() {
    registerFallbackValue(Duration.zero);
  });

  test("When action is OnSongSelected", () {
    const duration = Duration.zero;
    final songPlayer = _SongPlayerManagerMock();
    final middleware = SongPlayerMiddleware(songPlayer);
    // ignore: close_sinks
    final actionStream = PublishSubject<VersionAction>();

    when(songPlayer.initPlayer).thenAnswer((_) => SynchronousFuture(null));
    when(songPlayer.getAudioDuration).thenAnswer((_) => SynchronousFuture(Duration.zero));
    when(() => songPlayer.setAudio("as")).thenAnswer((_) => SynchronousFuture(null));

    expectLater(
      actionStream.stream,
      emitsInAnyOrder([
        isA<OnGetSongDuration>().having((action) => action.duration, "isFavorite", duration),
        isA<OnUpdateActualTime>().having((action) => action.duration, "isFavorite", duration),
        isA<OnSongPlayerStateChanged>().having((action) => action.state, "isFavorite", SongPlayerState.playing),
      ]),
    );

    middleware.onAction(
      OnSongSelected("as"),
      const VersionState(),
      actionStream.add,
    );
  });

  test("When action is OnSongTimeChanged", () {
    const duration = Duration.zero;
    final songPlayer = _SongPlayerManagerMock();
    final middleware = SongPlayerMiddleware(songPlayer);

    when(() => songPlayer.changeAudioTime(any())).thenAnswer((_) => SynchronousFuture(null));

    middleware.onAction(
      OnSongTimeChanged(duration: duration),
      const VersionState(),
      (p0) {},
    );

    verify(() => songPlayer.changeAudioTime(duration)).called(1);
  });

  group("When action is OnPlayerControllerAction", () {
    final songPlayer = _SongPlayerManagerMock();
    final middleware = SongPlayerMiddleware(songPlayer);

    when(songPlayer.pauseAudio).thenAnswer((_) => SynchronousFuture(null));
    when(songPlayer.resumeAudio).thenAnswer((_) => SynchronousFuture(null));
    when(songPlayer.cancel).thenAnswer((_) => SynchronousFuture(null));

    test("When is action play should call resumeAudio", () {
      middleware.onAction(
        OnPlayerControllerAction(PlayerAction.play),
        const VersionState(),
        (p0) {},
      );

      verify(songPlayer.resumeAudio).called(1);
    });

    test("When is action pause should call pauseAudio", () {
      middleware.onAction(
        OnPlayerControllerAction(PlayerAction.pause),
        const VersionState(),
        (p0) {},
      );

      verify(songPlayer.pauseAudio).called(1);
    });

    test("When is action cancel should call cancel", () {
      final actionStream = PublishSubject<VersionAction>();

      expectLater(actionStream.stream,
          emitsInOrder([isA<OnGetSongDuration>().having((duration) => duration.duration, "duration", isNull)]));

      middleware.onAction(
        OnPlayerControllerAction(PlayerAction.cancel),
        const VersionState(),
        actionStream.add,
      );

      verify(songPlayer.cancel).called(1);
      actionStream.close();
    });
  });

  test("When close should dispose song player", () {
    final songPlayer = _SongPlayerManagerMock();
    final middleware = SongPlayerMiddleware(songPlayer);
    when(songPlayer.dispose).thenAnswer((_) => SynchronousFuture(null));

    middleware.close();

    verify(songPlayer.dispose).called(1);
  });
}
