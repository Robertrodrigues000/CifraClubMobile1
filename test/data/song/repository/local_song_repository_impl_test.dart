import 'package:cifraclub/data/song/repository/local_song_repository_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_songs/pigeon.g.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

class _LocalSongsHostApiMock extends Mock implements LocalSongsHostApi {}

void main() {
  group("When call 'fetchLocalSongs'", () {
    test("and is success should return list of songs", () async {
      final localSongsHostApi = _LocalSongsHostApiMock();
      final localSongsResult = LocalSongsFetchResult(
          songs: [LocalSongDto(songName: "songName", artistName: "artistName", duration: 10)], error: null);

      when(() => localSongsHostApi.fetchLocalSongs(captureAny(), captureAny()))
          .thenAnswer((invocation) => SynchronousFuture(localSongsResult));

      final result = await LocalSongRepositoryImpl(localSongsHostApi)
          .getLocalSongs(artistName: "artistName", songName: "songName");
      final params = verify(() => localSongsHostApi.fetchLocalSongs(captureAny(), captureAny())).captured;

      expect(params.first, "artistName");
      expect(params.last, "songName");
      expect(result.isSuccess, isTrue);
      expect(result.get()?.length, 1);
    });

    test("and fails should return error", () async {
      final localSongsHostApi = _LocalSongsHostApiMock();
      final localSongsResult = LocalSongsFetchResult(songs: null, error: "error");

      when(() => localSongsHostApi.fetchLocalSongs(captureAny(), captureAny()))
          .thenAnswer((invocation) => SynchronousFuture(localSongsResult));

      final result = await LocalSongRepositoryImpl(localSongsHostApi)
          .getLocalSongs(artistName: "artistName", songName: "songName");
      final params = verify(() => localSongsHostApi.fetchLocalSongs(captureAny(), captureAny())).captured;

      expect(params.first, "artistName");
      expect(params.last, "songName");
      expect(result.isFailure, isTrue);
      expect(result.getError(), "error");
    });
  });

  test("When request song image should return a Uint8List", () async {
    final localSongsHostApi = _LocalSongsHostApiMock();
    final imageInBit = Uint8List(0);

    when(() => localSongsHostApi.getImage(captureAny())).thenAnswer((invocation) => SynchronousFuture(imageInBit));

    final result = await LocalSongRepositoryImpl(localSongsHostApi).getImage("contect://songs");
    final params = verify(() => localSongsHostApi.getImage(captureAny())).captured;

    expect(params.first, "contect://songs");
    expect(result, imageInBit);
  });
}
